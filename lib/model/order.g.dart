// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
      order: (json['order'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'order': instance.order?.map((e) => e.toJson()).toList(),
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      agregator_order_id: json['agregator_order_id'] as String?,
      agregator_order_time: json['agregator_order_time'] as String?,
      agrohub_order_time: json['agrohub_order_time'] as String?,
      delivery_id: json['delivery_id'] as String?,
      delivery_time: json['delivery_time'] as String?,
      farmer_id: json['farmer_id'] as int?,
      farmer_order_id: json['farmer_order_id'] as int?,
      id: json['id'] as int?,
      status: json['status'] as String?,
      store_id: json['store_id'] as int?,
      total_price: (json['total_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'agregator_order_id': instance.agregator_order_id,
      'agregator_order_time': instance.agregator_order_time,
      'agrohub_order_time': instance.agrohub_order_time,
      'delivery_id': instance.delivery_id,
      'delivery_time': instance.delivery_time,
      'farmer_id': instance.farmer_id,
      'farmer_order_id': instance.farmer_order_id,
      'id': instance.id,
      'status': instance.status,
      'store_id': instance.store_id,
      'total_price': instance.total_price,
    };
