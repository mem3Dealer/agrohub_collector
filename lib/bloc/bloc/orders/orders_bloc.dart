import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrdersEvents, OrdersState> {
  final ordersRepository = OrdersRepository();

  OrdersBloc(
    OrdersRepository? ordersRepository,
  ) : super(OrdersState()) {
    on<OrdersGetAllOrders>(_eventOrdersGetAllOrders);
    on<OrdersGetDetailOrder>(_eventOrdersGetDetailOrder);
  }

  Future<void> _eventOrdersGetAllOrders(
    OrdersGetAllOrders event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      List<Order> orders = await _allOrders(
        onError: event.onError,
        data: event.params,
      );

      List<Order> ordersNew = orders
          .where((Order element) => element.status == 'ready_to_collect')
          .toList();
      sortingOrder(ordersNew);
      List<Order> ordersInWork = orders
          .where((Order element) => element.status == 'collecting')
          .toList();
      sortingOrder(ordersInWork);
      List<Order> ordersCollected = orders
          .where((Order element) => element.status == 'ready_to_ship')
          .toList();
      sortingOrder(orders);
      emitter(
        state.copyWith(
          loading: false,
          allOrders: orders,
          ordersNew: ordersNew,
          ordersInWork: ordersInWork,
          ordersCollected: ordersCollected,
        ),
      );
      event.onSuccess!();
    } catch (e) {
      emitter(
        state.copyWith(
          loading: false,
          allOrders: [],
          ordersNew: [],
          ordersInWork: [],
          ordersCollected: [],
        ),
      );
      // print('we drop here?  ${state.allOrders}');
      inspect(e);
      event.onError!(e);
    }
  }

  Future<List<Order>> _allOrders({
    Function? onError,
    Map<String, dynamic>? data,
  }) async {
    // add(const OrdersLoading(loading: true));
    final List<Order> orders = await ordersRepository.getAllOrders();
    // add(const OrdersLoading(loading: false));
    return orders;
  }

  void sortingOrder(List<Order> orders) {
    orders.sort((Order a, Order b) {
      String adate = a.delivery_time!;
      String bdate = b.delivery_time!;
      return adate.compareTo(bdate);
    });
  }

  Future<void> _eventOrdersGetDetailOrder(
    OrdersGetDetailOrder event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      List<Product>? _listOfProducts = await detailOrder(
        id: event.id,
        onError: event.onError,
      );
      emitter(state.copyWith(
        listOfProducts: _listOfProducts,
        //TODO мне нужно как-то его обнулять по выходу из сборки, отмене заказа или типа того
      ));
      event.onSuccess!();
    } catch (e) {
      event.onError!(e);
    }
  }

  Future<List<Product>?> detailOrder({
    Function? onError,
    required int id,
  }) async {
    // add(const OrdersLoading(loading: true));
    final List<Product>? order = await ordersRepository.getDetailOrder(id);
    // add(const OrdersLoading(loading: false));
    return order;
  }
}
