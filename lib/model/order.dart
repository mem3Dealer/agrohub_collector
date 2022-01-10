import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderList {
  final List<Order>? order;

  OrderList({
    this.order,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListToJson(this);
}

@JsonSerializable()
class Order {
  String? agregator_order_id;
  String? agregator_order_time;
  String? agrohub_order_time;
  String? delivery_id;
  String? delivery_time;
  int? farmer_id;
  int? farmer_order_id;
  int? id;
  String? status;
  int? store_id;
  double? total_price;

  Order({
    this.agregator_order_id,
    this.agregator_order_time,
    this.agrohub_order_time,
    this.delivery_id,
    this.delivery_time,
    this.farmer_id,
    this.farmer_order_id,
    this.id,
    this.status,
    this.store_id,
    this.total_price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      agregator_order_id: map['agregator_order_id'],
      agregator_order_time: map['agregator_order_time'],
      agrohub_order_time: map['agrohub_order_time'],
      delivery_id: map['delivery_id'],
      delivery_time: map['delivery_time'],
      farmer_id: map['farmer_id']?.toInt(),
      farmer_order_id: map['farmer_order_id']?.toInt(),
      id: map['id']?.toInt(),
      status: map['status'],
      store_id: map['store_id']?.toInt(),
      total_price: map['total_price']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'Order(agregator_order_id: $agregator_order_id, agregator_order_time: $agregator_order_time, agrohub_order_time: $agrohub_order_time, delivery_id: $delivery_id, delivery_time: $delivery_time, farmer_id: $farmer_id, farmer_order_id: $farmer_order_id, id: $id, status: $status, store_id: $store_id, total_price: $total_price)';
  }

  Order copyWith({
    String? agregator_order_id,
    String? agregator_order_time,
    String? agrohub_order_time,
    String? delivery_id,
    String? delivery_time,
    int? farmer_id,
    int? farmer_order_id,
    int? id,
    String? status,
    int? store_id,
    double? total_price,
  }) {
    return Order(
      agregator_order_id: agregator_order_id ?? this.agregator_order_id,
      agregator_order_time: agregator_order_time ?? this.agregator_order_time,
      agrohub_order_time: agrohub_order_time ?? this.agrohub_order_time,
      delivery_id: delivery_id ?? this.delivery_id,
      delivery_time: delivery_time ?? this.delivery_time,
      farmer_id: farmer_id ?? this.farmer_id,
      farmer_order_id: farmer_order_id ?? this.farmer_order_id,
      id: id ?? this.id,
      status: status ?? this.status,
      store_id: store_id ?? this.store_id,
      total_price: total_price ?? this.total_price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agregator_order_id': agregator_order_id,
      'agregator_order_time': agregator_order_time,
      'agrohub_order_time': agrohub_order_time,
      'delivery_id': delivery_id,
      'delivery_time': delivery_time,
      'farmer_id': farmer_id,
      'farmer_order_id': farmer_order_id,
      'id': id,
      'status': status,
      'store_id': store_id,
      'total_price': total_price,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.agregator_order_id == agregator_order_id &&
        other.agregator_order_time == agregator_order_time &&
        other.agrohub_order_time == agrohub_order_time &&
        other.delivery_id == delivery_id &&
        other.delivery_time == delivery_time &&
        other.farmer_id == farmer_id &&
        other.farmer_order_id == farmer_order_id &&
        other.id == id &&
        other.status == status &&
        other.store_id == store_id &&
        other.total_price == total_price;
  }

  @override
  int get hashCode {
    return agregator_order_id.hashCode ^
        agregator_order_time.hashCode ^
        agrohub_order_time.hashCode ^
        delivery_id.hashCode ^
        delivery_time.hashCode ^
        farmer_id.hashCode ^
        farmer_order_id.hashCode ^
        id.hashCode ^
        status.hashCode ^
        store_id.hashCode ^
        total_price.hashCode;
  }
}
