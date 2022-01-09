import 'package:equatable/equatable.dart';

import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/model/order.dart';

class OrdersState extends Equatable {
  bool? loading = false;
  String? deliveryNumber = "";
  String? deliveryTime;
  String? farmerName;
  String? farmerStore;
  int? farmerId;
  int? orderId;
  // List<FirstOrder>? firstOrder = <FirstOrder>[];
  List<Order>? allOrders = [];
  List<Product>? listOfProducts = [];
  List<Order>? selectOrder = [];
  List<Order>? ordersNew = [];
  List<Order>? ordersInWork = [];
  List<Order>? ordersCollected = [];
  Map<String, dynamic>? initialParamsDetail;
  int? idOrder;
  int? farmerOrderId;
  String? status;
  String? deliveryId;

  OrdersState({
    this.loading,
    this.deliveryNumber,
    this.deliveryTime,
    this.farmerName,
    this.farmerStore,
    this.farmerId,
    this.orderId,
    this.allOrders,

    // this.firstOrder,
    this.listOfProducts,
    this.initialParamsDetail,
    this.selectOrder,
    this.ordersNew,
    this.ordersInWork,
    this.ordersCollected,
    this.deliveryId,
    this.farmerOrderId,
    this.idOrder,
    this.status,
  });

  @override
  List<dynamic> get props => <dynamic>[
        loading,
        deliveryNumber,
        deliveryTime,
        farmerId,
        farmerName,
        farmerStore,
        orderId,

        // firstOrder,
        listOfProducts,
        allOrders,
        initialParamsDetail,
        selectOrder,
        ordersNew,
        ordersInWork,
        ordersCollected,
        deliveryId,
        farmerOrderId,
        idOrder,
        status,
      ];

  OrdersState copyWith({
    bool? loading,
    String? deliveryNumber,
    String? deliveryTime,
    int? farmerId,
    String? farmerName,
    String? farmerStore,
    int? orderId,
    List<Order>? allOrders,

    // List<FirstOrder>? firstOrder,
    List<Product>? listOfProducts,
    Map<String, dynamic>? initialParamsDetail,
    List<Order>? selectOrder,
    List<Order>? ordersNew,
    List<Order>? ordersInWork,
    List<Order>? ordersCollected,
    String? deliveryId,
    int? farmerOrderId,
    int? idOrder,
    String? status,
  }) {
    return OrdersState(
      loading: loading ?? this.loading,
      deliveryNumber: deliveryNumber ?? this.deliveryNumber,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      farmerId: farmerId ?? this.farmerId,
      farmerName: farmerName ?? this.farmerName,
      farmerStore: farmerStore ?? this.farmerStore,
      orderId: orderId ?? this.orderId,
      // firstOrder: firstOrder ?? this.firstOrder,
      listOfProducts: listOfProducts ?? this.listOfProducts,
      initialParamsDetail: initialParamsDetail ?? this.initialParamsDetail,
      selectOrder: selectOrder ?? this.selectOrder,
      allOrders: allOrders ?? this.allOrders,
      ordersNew: ordersNew ?? this.ordersNew,
      ordersInWork: ordersInWork ?? this.ordersInWork,
      ordersCollected: ordersCollected ?? this.ordersCollected,
      deliveryId: deliveryId ?? this.deliveryId,
      farmerOrderId: farmerOrderId ?? this.farmerOrderId,
      idOrder: idOrder ?? this.orderId,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'OrdersState(loading: $loading, deliveryNumber: $deliveryNumber, deliveryTime: $deliveryTime, farmerName: $farmerName, farmerStore: $farmerStore, farmerId: $farmerId, orderId: $orderId, allOrders: $allOrders, listOfProducts: $listOfProducts, selectOrder: $selectOrder, ordersNew: $ordersNew, ordersInWork: $ordersInWork, ordersCollected: $ordersCollected, initialParamsDetail: $initialParamsDetail, idOrder: $idOrder, farmerOrderId: $farmerOrderId, status: $status, deliveryId: $deliveryId)';
  }
}
