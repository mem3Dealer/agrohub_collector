import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';

class OrdersState extends Equatable {
  bool? loading = false;
  bool? errorNullProducts = false;
  bool? errorUnavailableOrder = false;
  bool? isProdOnDelete = false;
  String? deliveryTime;

  int? farmerId;
  int? orderId;
  // List<FirstOrder>? firstOrder = <FirstOrder>[];
  List<Order>? orders = [];
  List<Product>? listOfProducts = [];

  String? status;
  String? deliveryId;
  int version = 0;
  Order? currentOrder;
  OrdersState({
    this.loading,
    this.errorNullProducts,
    this.errorUnavailableOrder,
    this.isProdOnDelete,
    this.deliveryTime,
    this.farmerId,
    this.orderId,
    this.orders,
    this.listOfProducts,
    this.status,
    this.deliveryId,
    required this.version,
    this.currentOrder,
  });

  OrdersState copyWith({
    bool? loading,
    bool? errorNullProducts,
    bool? errorUnavailableOrder,
    bool? isProdOnDelete,
    String? deliveryTime,
    int? farmerId,
    int? orderId,
    List<Order>? orders,
    List<Product>? listOfProducts,
    String? status,
    String? deliveryId,
    int? version,
    Order? currentOrder,
  }) {
    return OrdersState(
      loading: loading ?? this.loading,
      errorNullProducts: errorNullProducts ?? this.errorNullProducts,
      errorUnavailableOrder:
          errorUnavailableOrder ?? this.errorUnavailableOrder,
      isProdOnDelete: isProdOnDelete ?? this.isProdOnDelete,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      farmerId: farmerId ?? this.farmerId,
      orderId: orderId ?? this.orderId,
      orders: orders ?? this.orders,
      listOfProducts: listOfProducts ?? this.listOfProducts,
      status: status ?? this.status,
      deliveryId: deliveryId ?? this.deliveryId,
      version: version ?? this.version,
      currentOrder: currentOrder ?? this.currentOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
      'errorNullProducts': errorNullProducts,
      'errorUnavailableOrder': errorUnavailableOrder,
      'isProdOnDelete': isProdOnDelete,
      'deliveryTime': deliveryTime,
      'farmerId': farmerId,
      'orderId': orderId,
      'orders': orders?.map((x) => x.toMap()).toList(),
      'listOfProducts': listOfProducts?.map((x) => x.toMap()).toList(),
      'status': status,
      'deliveryId': deliveryId,
      'version': version,
      'currentOrder': currentOrder?.toMap(),
    };
  }

  factory OrdersState.fromMap(Map<String, dynamic> map) {
    return OrdersState(
      loading: map['loading'],
      errorNullProducts: map['errorNullProducts'],
      errorUnavailableOrder: map['errorUnavailableOrder'],
      isProdOnDelete: map['isProdOnDelete'],
      deliveryTime: map['deliveryTime'],
      farmerId: map['farmerId']?.toInt(),
      orderId: map['orderId']?.toInt(),
      orders: map['orders'] != null
          ? List<Order>.from(map['orders']?.map((x) => Order.fromMap(x)))
          : null,
      listOfProducts: map['listOfProducts'] != null
          ? List<Product>.from(
              map['listOfProducts']?.map((x) => Product.fromMap(x)))
          : null,
      status: map['status'],
      deliveryId: map['deliveryId'],
      version: map['version']?.toInt() ?? 0,
      currentOrder: map['currentOrder'] != null
          ? Order.fromMap(map['currentOrder'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersState.fromJson(String source) =>
      OrdersState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrdersState(loading: $loading, errorNullProducts: $errorNullProducts, errorUnavailableOrder: $errorUnavailableOrder, isProdOnDelete: $isProdOnDelete, deliveryTime: $deliveryTime, farmerId: $farmerId, orderId: $orderId, orders: $orders, listOfProducts: $listOfProducts, status: $status, deliveryId: $deliveryId, version: $version, currentOrder: $currentOrder)';
  }

  @override
  List<dynamic> get props {
    return [
      loading,
      errorNullProducts,
      errorUnavailableOrder,
      isProdOnDelete,
      deliveryTime,
      farmerId,
      orderId,
      orders,
      listOfProducts,
      status,
      deliveryId,
      version,
      currentOrder,
    ];
  }
}
