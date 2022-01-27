import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  double? agrohub_price;
  double? collected_quantity;
  int? farmer_order_id;
  int? id;
  String? image;
  String? name;
  int? order_id;
  bool? out_of_stock;
  int? product_id;
  String? product_type;
  String? status;
  int? store_id;
  double? total_price;
  double? unit_price;
  double? ordered_quantity;

  Product({
    this.agrohub_price,
    this.collected_quantity,
    this.farmer_order_id,
    this.id,
    this.image,
    this.name,
    this.order_id,
    this.out_of_stock,
    this.product_id,
    this.product_type,
    this.status,
    this.store_id,
    this.total_price,
    this.unit_price,
    this.ordered_quantity,
  });

  ShortProduct get toShortProduct {
    return ShortProduct(
        productId: product_id,
        status: status,
        farmer_order_id: farmer_order_id,
        orderedQuantity: ordered_quantity);
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    double? agrohub_price,
    double? collected_quantity,
    int? farmer_order_id,
    int? id,
    String? image,
    String? name,
    int? order_id,
    bool? out_of_stock,
    int? product_id,
    String? product_type,
    String? status,
    int? store_id,
    double? total_price,
    double? unit_price,
    double? ordered_quantity,
  }) {
    return Product(
      agrohub_price: agrohub_price ?? this.agrohub_price,
      collected_quantity: collected_quantity ?? this.collected_quantity,
      farmer_order_id: farmer_order_id ?? this.farmer_order_id,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      order_id: order_id ?? this.order_id,
      out_of_stock: out_of_stock ?? this.out_of_stock,
      product_id: product_id ?? this.product_id,
      product_type: product_type ?? this.product_type,
      status: status ?? this.status,
      store_id: store_id ?? this.store_id,
      total_price: total_price ?? this.total_price,
      unit_price: unit_price ?? this.unit_price,
      ordered_quantity: ordered_quantity ?? this.ordered_quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agrohub_price': agrohub_price,
      'collected_quantity': collected_quantity,
      'farmer_order_id': farmer_order_id,
      'id': id,
      'image': image,
      'name': name,
      'order_id': order_id,
      'out_of_stock': out_of_stock,
      'product_id': product_id,
      'product_type': product_type,
      'status': status,
      'store_id': store_id,
      'total_price': total_price,
      'unit_price': unit_price,
      'ordered_quantity': ordered_quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      agrohub_price: map['agrohub_price']?.toDouble(),
      collected_quantity: map['collected_quantity']?.toDouble(),
      farmer_order_id: map['farmer_order_id']?.toInt(),
      id: map['id']?.toInt(),
      image: map['image'],
      name: map['name'],
      order_id: map['order_id']?.toInt(),
      out_of_stock: map['out_of_stock'],
      product_id: map['product_id']?.toInt(),
      product_type: map['product_type'],
      status: map['status'],
      store_id: map['store_id']?.toInt(),
      total_price: map['total_price']?.toDouble(),
      unit_price: map['unit_price']?.toDouble(),
      ordered_quantity: map['ordered_quantity']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'Product(agrohub_price: $agrohub_price, collected_quantity: $collected_quantity, farmer_order_id: $farmer_order_id, id: $id, image: $image, name: $name, order_id: $order_id, out_of_stock: $out_of_stock, product_id: $product_id, product_type: $product_type, status: $status, store_id: $store_id, total_price: $total_price, unit_price: $unit_price, ordered_quantity: $ordered_quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.agrohub_price == agrohub_price &&
        other.collected_quantity == collected_quantity &&
        other.farmer_order_id == farmer_order_id &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.order_id == order_id &&
        other.out_of_stock == out_of_stock &&
        other.product_id == product_id &&
        other.product_type == product_type &&
        other.status == status &&
        other.store_id == store_id &&
        other.total_price == total_price &&
        other.unit_price == unit_price &&
        other.ordered_quantity == ordered_quantity;
  }

  @override
  int get hashCode {
    return agrohub_price.hashCode ^
        collected_quantity.hashCode ^
        farmer_order_id.hashCode ^
        id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        order_id.hashCode ^
        out_of_stock.hashCode ^
        product_id.hashCode ^
        product_type.hashCode ^
        status.hashCode ^
        store_id.hashCode ^
        total_price.hashCode ^
        unit_price.hashCode ^
        ordered_quantity.hashCode;
  }
}

class ShortProduct {
  int? productId;
  String? status;
  double? formedQuantity;
  double? orderedQuantity;
  int? farmer_order_id;
  ShortProduct({
    this.productId,
    this.status,
    this.formedQuantity,
    this.orderedQuantity,
    this.farmer_order_id,
  });

  ShortProduct copyWith({
    int? productId,
    String? status,
    double? formedQuantity,
    double? orderedQuantity,
    int? farmer_order_id,
  }) {
    return ShortProduct(
      productId: productId ?? this.productId,
      status: status ?? this.status,
      formedQuantity: formedQuantity ?? this.formedQuantity,
      orderedQuantity: orderedQuantity ?? this.orderedQuantity,
      farmer_order_id: farmer_order_id ?? this.farmer_order_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'status': status,
      'formedQuantity': formedQuantity,
      'orderedQuantity': orderedQuantity,
      'farmer_order_id': farmer_order_id,
    };
  }

  factory ShortProduct.fromMap(Map<String, dynamic> map) {
    return ShortProduct(
      productId: map['productId']?.toInt(),
      status: map['status'],
      formedQuantity: map['formedQuantity']?.toDouble(),
      orderedQuantity: map['orderedQuantity']?.toDouble(),
      farmer_order_id: map['farmer_order_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortProduct.fromJson(String source) =>
      ShortProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShortProduct(productId: $productId, status: $status, formedQuantity: $formedQuantity, orderedQuantity: $orderedQuantity, farmer_order_id: $farmer_order_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShortProduct &&
        other.productId == productId &&
        other.status == status &&
        other.formedQuantity == formedQuantity &&
        other.orderedQuantity == orderedQuantity &&
        other.farmer_order_id == farmer_order_id;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        status.hashCode ^
        formedQuantity.hashCode ^
        orderedQuantity.hashCode ^
        farmer_order_id.hashCode;
  }
}
