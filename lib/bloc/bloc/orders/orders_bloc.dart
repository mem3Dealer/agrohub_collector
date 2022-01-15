import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
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
      for (Order order in orders) {
        order.status = 'ACCEPTED';
      }
      List<Order> ordersNew = orders
          .where((Order element) => element.status == 'ready_to_collect')
          .toList();
      sortingOrder(ordersNew);
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

  Future<void> _eventInitCollectingOrder(
      InitCollectingOrder event, Emitter<OrdersState> emitter) async {
    List<Order> orders = await _allOrders();
    Order currentOrder =
        orders.firstWhere((element) => element.id == event.collectingOrderId);

    await detailOrder(id: currentOrder.id!).then((value) {
      emitter(state.copyWith(
          currentOrder: currentOrder,
          listOfProducts: value,
          version: state.version + 1));
      Navigator.pushReplacement<void, void>(
          event.context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                CollectingOrderPage(currentOrder),
          ));
    });
  }

  Future<void> _eventOrdersGetDetailOrder(
    OrdersGetDetailOrder event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      Order _order = await ord_rep.getThisOrder(event.order.id!);
      if (_order.status != 'IN PROGRESS' &&
          _order.status != 'READY' &&
          _order.status != 'CANCELLED') {
        List<Product>? _listOfProducts = await detailOrder(
          id: event.order.id!,
          onError: event.onError,
        );

        String? _currentOrder = await storage.read(key: 'currentOrderId');
        // print('THIS IS IT: $_currentOrder');
        if (_currentOrder == null || _currentOrder == '0') {
          await storage.write(
              key: 'currentOrderId', value: "${event.order.id}");
        }
        for (Product p in _listOfProducts!) {
          p.status = 'to_collect';
          p.collected_quantity = 0.0;
        }

        emitter(state.copyWith(
            listOfProducts: _listOfProducts,
            currentOrder: event.order.copyWith(status: 'IN PROGRESS')));

        ord_rep.setOrderStatus(id: 85, status: 'IN PROGRESS');
        event.onSuccess!();
      }
    } catch (e) {
      event.onError!(e);
    }
  }

  Future<void> _eventFinishCollecting(
      FinishCollecting event, Emitter<OrdersState> emitter) async {
    await storage.write(key: 'currentOrderId', value: '0');

    state.currentOrder?.status = 'READY';
    Map<String, dynamic> _packedOrder = state.currentOrder!.toJson();

    List<Map<String, dynamic>> _packedListOfProducts = [];

    state.listOfProducts!.forEach((product) {
      _packedListOfProducts.add(product.toJson());
    });
    // print('BLOC: ${_packedListOfProducts}');
    // var _postdata = [_packedOrder, _packedListOfProducts];
    // print(_postdata);
    // print('PRINT FROM BLOC ${state.currentOrder}');
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
    final List<Product>? listOfProducts =
        await ordersRepository.getDetailOrder(id);
    // add(const OrdersLoading(loading: false));
    return listOfProducts;
  }

  Future<void> checkStatus(BuildContext context, Order _order) async {
    Order _otherOrder = await ord_rep.getThisOrder(_order.id!);
    // bool _isCancel = false;
    bool isCancelled = false;
    bool isAlreadycDone = false;
    String _cancel = 'К сожалению, этот заказ был отменён';
    String _done = 'К сожалению, этот заказ был уже собран';

    SnackBar _snackBar = SnackBar(
        onVisible: () {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
        },
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        width: 360,
        backgroundColor: const Color(0xffFAE2E1),
        content: SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(isCancelled ? _cancel : _done,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff363B3F),
                      fontSize: 16)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ок :(',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff363B3F),
                          fontSize: 18)))
            ],
          ),
        ));

    if (_otherOrder.status == 'CANCELLED') {
      // setState(() {
      isCancelled = true;
      // });
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    } else if (_otherOrder.status == 'READY') {
      // setState(() {
      isAlreadycDone = true;
      // });
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      // ScaffoldMessenger.of(context).showSnackBar(_snackBarOnDone);
    }
  }
}
