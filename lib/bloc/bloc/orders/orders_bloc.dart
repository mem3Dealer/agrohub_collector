import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/response.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrdersEvents, OrdersState> {
  final ordersRepository = OrdersRepository();

  OrdersBloc(
    OrdersRepository? ordersRepository,
  ) : super(OrdersState(version: 0)) {
    on<OrdersGetAllOrders>(_eventOrdersGetAllOrders);
    on<OrdersGetDetailOrder>(_eventOrdersGetDetailOrder);
    on<ChangeProductStatus>(_eventChangeProductStatus);
    on<InitCollectingOrder>(_eventInitCollectingOrder);
    on<FinishCollecting>(_eventFinishCollecting);
    // on<CollectProduct>(_eventCollectProduct);
    on<LoadNewOrders>(_eventLoadNewOrders);
  }
  List<String> _listStats = ['ACCEPTED_BY_RESTAURANT', 'READY', 'CANCELLED'];

  Future<void> _eventOrdersGetAllOrders(
    OrdersGetAllOrders event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      List<Order> orders = await _allOrders(
        onError: event.onError,
        data: event.params,
      );
      List<Order> ordersNew =
          orders.where((Order element) => element.status == 'NEW').toList();
      sortingOrder(ordersNew);

      // if (ordersNew.length < 6) {
      //   LoadNewOrders();
      //   // print('yup');
      // }
      // List<Order> ordersInWork = orders
      //     .where((Order element) => element.status == 'collecting')
      //     .toList();
      // sortingOrder(ordersInWork);
      // List<Order> ordersCollected = orders
      //     .where((Order element) => element.status == 'ready_to_ship')
      // .toList();

      ordersNew.sort((a, b) {
        return a.deliveryTime!.compareTo(b.deliveryTime!);
      });
      emitter(
        state.copyWith(
          loading: false,
          allOrders: orders,
          ordersNew: ordersNew,
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

// подгруз заказов
  Future<void> _eventLoadNewOrders(
    LoadNewOrders event,
    Emitter<OrdersState> emitter,
  ) async {
    List<Order> _list = await ord_rep.getMoreOrders();

    List<Order> _newOrders =
        _list.where((Order element) => element.status == 'NEW').toList();
    // emitter(state.copyWith(loading: true));
    List<Order>? _aga = state.ordersNew;
    _aga!.addAll(_newOrders);
    // for (Order or in _aga) {
    //   print(or.agregator_order_id);
    // }
    // print(_list.length);
    emitter(state.copyWith(allOrders: _aga, version: state.version++));
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
      DateTime adate = a.deliveryTime!;
      DateTime bdate = b.deliveryTime!;
      return adate.compareTo(bdate);
    });
  }

  Future<void> _eventInitCollectingOrder(
      InitCollectingOrder event, Emitter<OrdersState> emitter) async {
    // List<Order> orders = await _allOrders();
    // await storage.write(
    //     key: 'currentOrderId', value: '${event.collectingOrderId}');
    String? id = await storage.read(key: 'currentOrderId');
    try {
      if (id != null) {
        Order? currentOrder;
        currentOrder = await ord_rep.getThisOrder(int.parse(id));

        await detailOrder(id: currentOrder.id!).then((value) {
          emitter(state.copyWith(
              currentOrder: currentOrder,
              listOfProducts: value,
              version: state.version + 1));
          Navigator.pushReplacement<void, void>(
              event.context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    CollectingOrderPage(currentOrder!),
              ));
        });
      } else {
        print('there is no id, isnt it? $id');
      }
    } catch (e) {
      inspect(e);
      print(e);
      event.onError;
    }
  }

  Future<void> _eventOrdersGetDetailOrder(
    OrdersGetDetailOrder event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      Order _order = await ord_rep.getThisOrder(event.order.id!);
      // print(_listStats.contains(_order.status) == false);
      if (_listStats.contains(_order.status) == false) {
        List<Product>? _listOfProducts = await detailOrder(
          id: event.order.id!,
          onError: event.onError,
        );

        Map<String, dynamic> _postData = {
          'id': _order.id,
          'status': 'ACCEPTED_BY_RESTAURANT'
        };
        String? _currentOrder = await storage.read(key: 'currentOrderId');
        // print('THIS IS IT: $_currentOrder');
        if (_currentOrder == null || _currentOrder == '0') {
          await storage.write(
              key: 'currentOrderId', value: "${event.order.id}");
        }
        ord_rep.updateOrderStatus(
            data:
                _postData); // TODO раскоментить чтобы возобновить работу с беком
        emitter(state.copyWith(
            listOfProducts: _listOfProducts,
            currentOrder:
                event.order.copyWith(status: 'ACCEPTED_BY_RESTAURANT')));
        event.onSuccess!();
      } else {
        MyWidgets.buildSnackBar(
            content: 'Заказ не доступен к собрке',
            context: event.context,
            button: true,
            secs: 3);
      }
    } catch (e) {
      // inspect(e);
      event.onError!(e);
    }
  }

  Future<void> _eventFinishCollecting(
      FinishCollecting event, Emitter<OrdersState> emitter) async {
    await storage.write(key: 'currentOrderId', value: '0');
    MyResponse _orderPost = MyResponse(orderId: state.currentOrder?.id,
        // farmerOrderId: state.currentOrder?,
        listShortProduct: <ShortProduct>[]);

    for (Product product in state.listOfProducts!) {
      if (product.status == 'deleted') {
        product.collected_quantity = 0.0;
      }
      _orderPost.listShortProduct?.add(product.toShortProduct);
    }
    Map<String, dynamic> _statusPost = {
      'id': state.currentOrder?.id,
      'status': 'READY'
    };
    // print('ORDER SENT: ${_orderPost.toServerMap()}');
    ord_rep.updateOrderStatus(data: _statusPost);
    ord_rep.postProducts(data: _orderPost.toServerMap());
    //  TODO раскоментить чтобы возобновить работу с беком

    emitter(state.copyWith(listOfProducts: [], currentOrder: Order()));
    authBloc.emit(authBloc.state.copyWith(currentCollectingOrderId: 0));

    Navigator.popAndPushNamed(event.context, '/allOrders');
  }

  void _eventChangeProductStatus(
    ChangeProductStatus event,
    Emitter<OrdersState> emitter,
  ) {
    if (event.newStatus == 'to_collect') {
      event.product.status = 'to_collect';
      event.product.collected_quantity = 0.0;
    } else if (event.newStatus == 'collected') {
      event.product.status = 'collected';
      // if(event.collectedQuantity)
      event.product.collected_quantity = event.collectedQuantity;
    } else if (event.newStatus == 'deleted') {
      event.product.collected_quantity = 0.1;
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
    final List<Product>? listOfProducts =
        await ordersRepository.getDetailOrder(id);
    // print(listOfProducts);
    // add(const OrdersLoading(loading: false));
    return listOfProducts;
  }
}
