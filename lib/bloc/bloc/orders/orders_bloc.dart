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
  ) : super(OrdersState(version: 0)) {
    on<OrdersGetAllOrders>(_eventOrdersGetAllOrders);
    on<OrdersGetDetailOrder>(_eventOrdersGetDetailOrder);
    on<ChangeProductStatus>(_eventChangeProductStatus);
    // on<CollectProduct>(_eventCollectProduct);
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

      // List<Order> ordersNew = orders
      //     .where((Order element) => element.status == 'ready_to_collect')
      //     .toList();
      // sortingOrder(ordersNew);
      // List<Order> ordersInWork = orders
      //     .where((Order element) => element.status == 'collecting')
      //     .toList();
      // sortingOrder(ordersInWork);
      // List<Order> ordersCollected = orders
      //     .where((Order element) => element.status == 'ready_to_ship')
      // .toList();

      orders.sort((a, b) {
        return a.delivery_time!.compareTo(b.delivery_time!);
      });
      emitter(
        state.copyWith(
          loading: false,
          allOrders: orders,
          // ordersNew: ordersNew,
          // ordersInWork: ordersInWork,
          // ordersCollected: ordersCollected,
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
      DateTime adate = a.delivery_time!;
      DateTime bdate = b.delivery_time!;
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
      for (Product p in _listOfProducts!) {
        p.status = 'to_collect';
      }

      emitter(state.copyWith(
        listOfProducts: _listOfProducts,
      ));
      event.onSuccess!();
    } catch (e) {
      event.onError!(e);
    }
  }

  // _eventCollectProduct(
  //   CollectProduct event,
  //   Emitter<OrdersState> emitter,
  // ) {
  //   event.product.collected_quantity = event.collectedQuantity;
  //   emitter(state.copyWith(
  //       listOfProducts: state.listOfProducts, version: state.version + 1));
  // }

  void _eventChangeProductStatus(
    ChangeProductStatus event,
    Emitter<OrdersState> emitter,
  ) {
    if (event.newStatus == 'to_collect') {
      event.product.status = 'to_collect';
      event.product.collected_quantity = 0.0;
    } else if (event.newStatus == 'collected') {
      event.product.status = 'collected';
      event.product.collected_quantity = event.collectedQuantity;
    } else if (event.newStatus == 'deleted') {
      event.product.collected_quantity = 0.0;
      event.product.status = 'deleted';
    }

    emitter(state.copyWith(
        listOfProducts: state.listOfProducts, version: state.version + 1));
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
