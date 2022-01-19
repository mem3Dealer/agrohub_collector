import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:agrohub_collector_flutter/model/product.dart';

class MyResponse {
  int? orderId;
  int? farmerOrderId;
  List<ShortProduct>? listShortProduct;
  MyResponse({
    this.orderId,
    this.farmerOrderId,
    this.listShortProduct,
  });

  MyResponse copyWith({
    int? orderId,
    int? farmerOrderId,
    List<ShortProduct>? listShortProduct,
  }) {
    return MyResponse(
      orderId: orderId ?? this.orderId,
      farmerOrderId: farmerOrderId ?? this.farmerOrderId,
      listShortProduct: listShortProduct ?? this.listShortProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'farmerOrderId': farmerOrderId,
      'listShortProduct': listShortProduct?.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toServerMap() {
    return {
      'order_id': orderId,
      // 'farmer_order_id': farmerOrderId,
      'product': listShortProduct?.map((x) => x.toMap()).toList(),
    };
  }

  factory MyResponse.fromMap(Map<String, dynamic> map) {
    return MyResponse(
      orderId: map['orderId']?.toInt(),
      farmerOrderId: map['farmerOrderId']?.toInt(),
      listShortProduct: map['listShortProduct'] != null
          ? List<ShortProduct>.from(
              map['listShortProduct']?.map((x) => ShortProduct.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyResponse.fromJson(String source) =>
      MyResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'MyResponse(orderId: $orderId, farmerOrderId: $farmerOrderId, listShortProduct: $listShortProduct)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyResponse &&
        other.orderId == orderId &&
        other.farmerOrderId == farmerOrderId &&
        listEquals(other.listShortProduct, listShortProduct);
  }

  @override
  int get hashCode =>
      orderId.hashCode ^ farmerOrderId.hashCode ^ listShortProduct.hashCode;
}
