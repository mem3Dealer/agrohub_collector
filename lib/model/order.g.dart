// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'order.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
//       order: (json['order'] as List<dynamic>?)
//           ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );

// Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
//       'order': instance.order?.map((e) => e.toJson()).toList(),
//     };

// Order _$OrderFromJson(Map<String, dynamic> json) => Order(
//       agregatorExternalOrderId: json['agregator_external_order_id'] as int?,
//       agregatorOrderId: json['agregator_order_id'] as String?,
//       agregatorOrderTime: json['agregator_order_time'] == null
//           ? null
//           : DateFormat('EEE, dd MMM yyyy HH:MM')
//               .parse(json['agregator_order_time'] as String),
//       agrohubOrderTime: json['agrohub_order_time'] == null
//           ? null
//           : DateFormat('EEE, dd MMM yyyy HH:MM')
//               .parse(json['agrohub_order_time'] as String),
//       clientName: json['client_name'] as String?,
//       clientPhone: json['client_phone'] as String?,
//       comment: json['comment'] as String?,
//       deliveryId: json['delivery_id'] as int?,
//       deliveryTime: json['delivery_time'] == null
//           ? null
//           : DateFormat('EEE, dd MMM yyyy HH:MM')
//               .parse(json['delivery_time'] as String),
//       discriminator: json['discriminator'] as String?,
//       id: json['id'] as int?,
//       latitude: json['latitude'] as String?,
//       longitude: json['longitude'] as String?,
//       paymentType: json['payment_type'] as String?,
//       persons: json['persons'] as int?,
//       status: json['status'] as String?,
//       storeId: json['store_id'] as int?,
//       totalPrice: json['total_price'] as double?,
//       unitsPrice: json['units_price'] as double?,
//       updatedAt: json['updated_at'] == null
//           ? null
//           : DateFormat('EEE, dd MMM yyyy HH:MM')
//               .parse(json['updated_at'] as String),
//     );

// Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
//       'agregator_external_order_id': instance.agregatorExternalOrderId,
//       'agregator_order_id': instance.agregatorOrderId,
//       'agregator_order_time': instance.agregatorOrderTime?.toIso8601String(),
//       'agrohub_order_time': instance.agrohubOrderTime?.toIso8601String(),
//       'client_name': instance.clientName,
//       'client_phone': instance.clientPhone,
//       'comment': instance.comment,
//       'delivery_id': instance.deliveryId,
//       'delivery_time': instance.deliveryTime?.toIso8601String(),
//       'discriminator': instance.discriminator,
//       'id': instance.id,
//       'latitude': instance.latitude,
//       'longitude': instance.longitude,
//       'payment_type': instance.paymentType,
//       'persons': instance.persons,
//       'status': instance.status,
//       'store_id': instance.storeId,
//       'total_price': instance.totalPrice,
//       'units_price': instance.unitsPrice,
//       'updated_at': instance.updatedAt?.toIso8601String(),
//     };
