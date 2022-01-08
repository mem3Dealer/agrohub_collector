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
      farmer_id: map['farmer_id'],
      farmer_order_id: map['farmer_order_id'],
      id: map['id'],
      status: map['status'],
      store_id: map['store_id'],
      total_price: map['total_price'],
    );
  }

  @override
  String toString() {
    return 'Order(agregator_order_id: $agregator_order_id, agregator_order_time: $agregator_order_time, agrohub_order_time: $agrohub_order_time, delivery_id: $delivery_id, delivery_time: $delivery_time, farmer_id: $farmer_id, farmer_order_id: $farmer_order_id, id: $id, status: $status, store_id: $store_id, total_price: $total_price)';
  }
}
