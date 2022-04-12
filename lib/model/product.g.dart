// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      agrohub_price: (json['agrohub_price'] as num?)?.toDouble(),
      collected_quantity: (json['collected_quantity'] as num?)?.toDouble(),
      farmer_order_id: json['farmer_order_id'] as int?,
      id: json['id'] as int?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      order_id: json['order_id'] as int?,
      out_of_stock: json['out_of_stock'] as bool?,
      product_id: json['product_id'] as int?,
      product_type: json['product_type'] as String?,
      status: json['status'] as String?,
      store_id: json['store_id'] as int?,
      total_price: (json['total_price'] as num?)?.toDouble(),
      unit_price: (json['unit_price'] as num?)?.toDouble(),
      ordered_quantity: (json['ordered_quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'agrohub_price': instance.agrohub_price,
      'collected_quantity': instance.collected_quantity,
      'farmer_order_id': instance.farmer_order_id,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'order_id': instance.order_id,
      'out_of_stock': instance.out_of_stock,
      'product_id': instance.product_id,
      'product_type': instance.product_type,
      'status': instance.status,
      'store_id': instance.store_id,
      'total_price': instance.total_price,
      'unit_price': instance.unit_price,
      'ordered_quantity': instance.ordered_quantity,
    };
