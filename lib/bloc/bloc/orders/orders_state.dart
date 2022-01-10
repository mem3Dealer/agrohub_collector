import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';

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
  int version = 0;
  OrdersState({
    this.loading,
    this.deliveryNumber,
    this.deliveryTime,
    this.farmerName,
    this.farmerStore,
    this.farmerId,
    this.orderId,
    this.allOrders,
    this.listOfProducts,
    this.selectOrder,
    this.ordersNew,
    this.ordersInWork,
    this.ordersCollected,
    this.initialParamsDetail,
    this.idOrder,
    this.farmerOrderId,
    this.status,
    this.deliveryId,
    required this.version,
  });

  OrdersState copyWith({
    bool? loading,
    String? deliveryNumber,
    String? deliveryTime,
    String? farmerName,
    String? farmerStore,
    int? farmerId,
    int? orderId,
    List<Order>? allOrders,
    List<Product>? listOfProducts,
    List<Order>? selectOrder,
    List<Order>? ordersNew,
    List<Order>? ordersInWork,
    List<Order>? ordersCollected,
    Map<String, dynamic>? initialParamsDetail,
    int? idOrder,
    int? farmerOrderId,
    String? status,
    String? deliveryId,
    int? version,
  }) {
    return OrdersState(
      loading: loading ?? this.loading,
      deliveryNumber: deliveryNumber ?? this.deliveryNumber,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      farmerName: farmerName ?? this.farmerName,
      farmerStore: farmerStore ?? this.farmerStore,
      farmerId: farmerId ?? this.farmerId,
      orderId: orderId ?? this.orderId,
      allOrders: allOrders ?? this.allOrders,
      listOfProducts: listOfProducts ?? this.listOfProducts,
      selectOrder: selectOrder ?? this.selectOrder,
      ordersNew: ordersNew ?? this.ordersNew,
      ordersInWork: ordersInWork ?? this.ordersInWork,
      ordersCollected: ordersCollected ?? this.ordersCollected,
      initialParamsDetail: initialParamsDetail ?? this.initialParamsDetail,
      idOrder: idOrder ?? this.idOrder,
      farmerOrderId: farmerOrderId ?? this.farmerOrderId,
      status: status ?? this.status,
      deliveryId: deliveryId ?? this.deliveryId,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
      'deliveryNumber': deliveryNumber,
      'deliveryTime': deliveryTime,
      'farmerName': farmerName,
      'farmerStore': farmerStore,
      'farmerId': farmerId,
      'orderId': orderId,
      'allOrders': allOrders?.map((x) => x.toMap()).toList(),
      'listOfProducts': listOfProducts?.map((x) => x.toMap()).toList(),
      'selectOrder': selectOrder?.map((x) => x.toMap()).toList(),
      'ordersNew': ordersNew?.map((x) => x.toMap()).toList(),
      'ordersInWork': ordersInWork?.map((x) => x.toMap()).toList(),
      'ordersCollected': ordersCollected?.map((x) => x.toMap()).toList(),
      'initialParamsDetail': initialParamsDetail,
      'idOrder': idOrder,
      'farmerOrderId': farmerOrderId,
      'status': status,
      'deliveryId': deliveryId,
      'version': version,
    };
  }

  factory OrdersState.fromMap(Map<String, dynamic> map) {
    return OrdersState(
      loading: map['loading'],
      deliveryNumber: map['deliveryNumber'],
      deliveryTime: map['deliveryTime'],
      farmerName: map['farmerName'],
      farmerStore: map['farmerStore'],
      farmerId: map['farmerId']?.toInt(),
      orderId: map['orderId']?.toInt(),
      allOrders: map['allOrders'] != null
          ? List<Order>.from(map['allOrders']?.map((x) => Order.fromMap(x)))
          : null,
      listOfProducts: map['listOfProducts'] != null
          ? List<Product>.from(
              map['listOfProducts']?.map((x) => Product.fromMap(x)))
          : null,
      selectOrder: map['selectOrder'] != null
          ? List<Order>.from(map['selectOrder']?.map((x) => Order.fromMap(x)))
          : null,
      ordersNew: map['ordersNew'] != null
          ? List<Order>.from(map['ordersNew']?.map((x) => Order.fromMap(x)))
          : null,
      ordersInWork: map['ordersInWork'] != null
          ? List<Order>.from(map['ordersInWork']?.map((x) => Order.fromMap(x)))
          : null,
      ordersCollected: map['ordersCollected'] != null
          ? List<Order>.from(
              map['ordersCollected']?.map((x) => Order.fromMap(x)))
          : null,
      initialParamsDetail:
          Map<String, dynamic>.from(map['initialParamsDetail']),
      idOrder: map['idOrder']?.toInt(),
      farmerOrderId: map['farmerOrderId']?.toInt(),
      status: map['status'],
      deliveryId: map['deliveryId'],
      version: map['version']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersState.fromJson(String source) =>
      OrdersState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrdersState(loading: $loading, deliveryNumber: $deliveryNumber, deliveryTime: $deliveryTime, farmerName: $farmerName, farmerStore: $farmerStore, farmerId: $farmerId, orderId: $orderId, allOrders: $allOrders, listOfProducts: $listOfProducts, selectOrder: $selectOrder, ordersNew: $ordersNew, ordersInWork: $ordersInWork, ordersCollected: $ordersCollected, initialParamsDetail: $initialParamsDetail, idOrder: $idOrder, farmerOrderId: $farmerOrderId, status: $status, deliveryId: $deliveryId, version: $version)';
  }

  @override
  List<dynamic> get props => [
        loading,
        deliveryNumber,
        deliveryTime,
        farmerName,
        farmerStore,
        farmerId,
        orderId,
        allOrders,
        listOfProducts,
        selectOrder,
        ordersNew,
        ordersInWork,
        ordersCollected,
        initialParamsDetail,
        idOrder,
        farmerOrderId,
        status,
        deliveryId,
        version,
      ];
}
