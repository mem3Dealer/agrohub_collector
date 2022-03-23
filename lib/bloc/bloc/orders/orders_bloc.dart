import 'dart:developer';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/response.dart';
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
    // on<LoadNewOrders>(_eventLoadNewOrders);
    on<OrdersLoading>(_eventOrdersLoading);
    on<QuitCollecting>(_eventQuitCollecting);
  }
  List<String> _listStats = ['ACCEPTED_BY_RESTAURANT', 'READY', 'CANCELLED'];

  // Stream<List<Order>> getOrders() =>
  //     Stream.periodic(Duration(seconds: 1)).asyncMap((_) => _allOrders());

  //получаем все заказы
  Future<void> _eventOrdersGetAllOrders(
    OrdersGetAllOrders event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      add(OrdersLoading(loading: true));
      List<Order> orders = await _allOrders(
        onError: event.onError,
        data: event.params,
      );
      sortingOrder(orders);
      emitter(
        state.copyWith(
          orders: orders,
          loading: false,
        ),
      );
      event.onSuccess!();
    } catch (e) {
      emitter(
        state.copyWith(
          loading: false,
          orders: [],
        ),
      );
      inspect(e);
      event.onError!(e);
    }
  }

  Future<List<Order>> _allOrders({
    Function? onError,
    Map<String, dynamic>? data,
  }) async {
    add(OrdersLoading(loading: true));
    final List<Order> orders = await ordersRepository.getNewOrders();

    if (orders.isNotEmpty) {
      add(OrdersLoading(loading: false));
      return orders;
    }
    return [];
  }

  void sortingOrder(List<Order> orders) {
    orders.sort((Order a, Order b) {
      DateTime adate = a.deliveryTime!;
      DateTime bdate = b.deliveryTime!;
      return adate.compareTo(bdate);
    });
  }

  //проверка может уже был начата сборка заказа
  Future<void> _eventInitCollectingOrder(
      InitCollectingOrder event, Emitter<OrdersState> emitter) async {
    String? id = await storage.read(key: 'currentOrderId');
    try {
      if (id != null) {
        add(OrdersLoading(loading: true));
        Order? currentOrder;
        currentOrder = await ord_rep.getThisOrder(int.parse(id));

        await detailOrder(id: currentOrder.id!).then((value) {
          emitter(state.copyWith(
              currentOrder: currentOrder,
              listOfProducts: value,
              loading: false,
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

//прекращение сборки
  Future<void> _eventQuitCollecting(
    QuitCollecting event,
    Emitter<OrdersState> emitter,
  ) async {
    Map<String, dynamic> _postData = {
      'id': state.currentOrder?.id,
      'status': 'NEW'
    };
    ord_rep.updateOrderStatus(data: _postData);
    await storage.write(key: 'currentOrderId', value: '0');
    emitter(state.copyWith(listOfProducts: [], currentOrder: Order()));
    Navigator.popAndPushNamed(event.context, '/allOrders');
  }

  Future<void> _eventOrdersGetDetailOrder(
    OrdersGetDetailOrder event,
    Emitter<OrdersState> emitter,
  ) async {
    try {
      Order _order = await ord_rep.getThisOrder(event.order.id!);

      if (_listStats.contains(_order.status) == false) {
        Map<String, dynamic> _postData = {
          'id': _order.id,
          'status': 'ACCEPTED_BY_RESTAURANT'
        };
        List<Product>? _listOfProducts = await detailOrder(
          id: event.order.id!,
          onError: () {
            Navigator.canPop(event.context);
            emitter(state.copyWith(
                listOfProducts: [],
                loading: false,
                errorNullProducts: true,
                currentOrder: Order()));
            emitter(state.copyWith(errorNullProducts: false));
          },
        );
        if (_listOfProducts != null && _listOfProducts.isNotEmpty) {
          String? _currentOrder = await storage.read(key: 'currentOrderId');
          if (_currentOrder == null || _currentOrder == '0') {
            await storage.write(
                key: 'currentOrderId', value: "${event.order.id}");
          }

          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute<void>(
              builder: (BuildContext _context) =>
                  CollectingOrderPage(event.order),
            ),
          );
          emitter(state.copyWith(
              version: state.version + 1,
              listOfProducts: _listOfProducts,
              loading: false,
              currentOrder:
                  event.order.copyWith(status: 'ACCEPTED_BY_RESTAURANT')));

          // if (!kDebugMode) {
          ord_rep.updateOrderStatus(data: _postData);
          // } // TODO раскоментить чтобы возобновить работу с беком

        }
      } else {
        emitter(state.copyWith(errorUnavailableOrder: true));
        emitter(state.copyWith(errorUnavailableOrder: false));
      }
    } catch (e) {
      emitter(state
          .copyWith(listOfProducts: [], loading: false, currentOrder: Order()));
      inspect(e);
      // event.onError!();
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
    // if (!kDebugMode) {
    print('ORDER SENT: ${_orderPost.toServerMap()}');
    ord_rep.updateOrderStatus(data: _statusPost);
    ord_rep.postProducts(data: _orderPost.toServerMap());
    // // }
    //  TODO раскоментить чтобы возобновить работу с беком

    emitter(state.copyWith(listOfProducts: [], currentOrder: Order()));
    authBloc.emit(authBloc.state.copyWith(currentCollectingOrderId: 0));
    Navigator.popAndPushNamed(event.context, '/allOrders');
  }

  void _eventChangeProductStatus(
    ChangeProductStatus event,
    Emitter<OrdersState> emitter,
  ) {
    if (event.newStatus == 'collecting') {
      event.product.status = 'collecting';
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
    Function? onSuccess,
    required int id,
  }) async {
    try {
      add(OrdersLoading(loading: true));
      final List<Product>? listOfProducts =
          await ordersRepository.getDetailOrder(id);
      // add(OrdersLoading(loading: false));
      if (listOfProducts!.isNotEmpty) {
        return listOfProducts;
      } else {
        add(OrdersLoading(loading: false));
        onError!();
      }
    } catch (e) {
      add(OrdersLoading(loading: false));
      onError!();
    }
  }

  void _eventOrdersLoading(OrdersLoading event, Emitter<OrdersState> emitter) {
    emitter(state.copyWith(loading: event.loading));
  }
}
