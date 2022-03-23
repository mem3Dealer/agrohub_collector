import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'order.g.dart';

@JsonSerializable()
class Order {
  int? agregatorExternalOrderId;
  String? agregatorOrderId;
  DateTime? agregatorOrderTime;
  DateTime? agrohubOrderTime;
  String? clientName;
  String? clientPhone;
  String? comment;
  // String? deliveryId;
  DateTime? deliveryTime;
  String? discriminator;
  int? id;
  String? latitude;
  String? longitude;
  String? paymentType;
  int? persons;
  String? status;
  int? storeId;
  double? totalPrice;
  double? unitsPrice;
  DateTime? updatedAt;

  Order({
    this.agregatorExternalOrderId,
    this.agregatorOrderId,
    this.agregatorOrderTime,
    this.agrohubOrderTime,
    this.clientName,
    this.clientPhone,
    this.comment,
    // this.deliveryId,
    this.deliveryTime,
    this.discriminator,
    this.id,
    this.latitude,
    this.longitude,
    this.paymentType,
    this.persons,
    this.status,
    this.storeId,
    this.totalPrice,
    this.unitsPrice,
    this.updatedAt,
  });

  // factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  // Map<String, dynamic> toJson() => _$OrderToJson(this);

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      agregatorExternalOrderId: map['agregator_external_order_id']?.toInt(),
      agregatorOrderId: map['agregator_order_id'],
      agregatorOrderTime: map['agregator_order_time'] != null
          ? DateFormat('E, d MMM yyyy HH:mm:ss')
              .parse(map['agregator_order_time'] as String)
          : null,
      agrohubOrderTime: map['agrohub_order_time'] != null
          ? DateFormat('E, d MMM yyyy HH:mm:ss')
              .parse(map['agrohub_order_time'] as String)
          : null,
      clientName: map['client_name'],
      clientPhone: map['client_phone'],
      comment: map['comment'],
      // deliveryId: map['delivery_id'],
      deliveryTime: map['delivery_time'] != null
          ? DateFormat('E, d MMM yyyy HH:mm:ss')
              .parse(map['delivery_time'] as String)
          : null,
      discriminator: map['discriminator'],
      id: map['id']?.toInt(),
      latitude: map['latitude'],
      longitude: map['longitude'],
      paymentType: map['paymentType'],
      persons: map['persons']?.toInt(),
      status: map['status'],
      storeId: map['store_id']?.toInt(),
      totalPrice: map['total_price']?.toDouble(),
      unitsPrice: map['units_price']?.toDouble(),
      updatedAt: map['updated_at'] != null
          ? DateFormat('E, d MMM yyyy HH:mm:ss')
              .parse(map['updated_at'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'Order(agregatorExternalOrderId: $agregatorExternalOrderId, agregatorOrderId: $agregatorOrderId, agregatorOrderTime: $agregatorOrderTime, agrohubOrderTime: $agrohubOrderTime, clientName: $clientName, clientPhone: $clientPhone, comment: $comment,deliveryTime: $deliveryTime, discriminator: $discriminator, id: $id, latitude: $latitude, longitude: $longitude, paymentType: $paymentType, persons: $persons, status: $status, storeId: $storeId, totalPrice: $totalPrice, unitsPrice: $unitsPrice, updatedAt: $updatedAt)';
  }

  Order copyWith({
    int? agregatorExternalOrderId,
    String? agregatorOrderId,
    DateTime? agregatorOrderTime,
    DateTime? agrohubOrderTime,
    String? clientName,
    String? clientPhone,
    String? comment,
    // String/? deliveryId,
    DateTime? deliveryTime,
    String? discriminator,
    int? id,
    String? latitude,
    String? longitude,
    String? paymentType,
    int? persons,
    String? status,
    int? storeId,
    double? totalPrice,
    double? unitsPrice,
    DateTime? updatedAt,
  }) {
    return Order(
      agregatorExternalOrderId:
          agregatorExternalOrderId ?? this.agregatorExternalOrderId,
      agregatorOrderId: agregatorOrderId ?? this.agregatorOrderId,
      agregatorOrderTime: agregatorOrderTime ?? this.agregatorOrderTime,
      agrohubOrderTime: agrohubOrderTime ?? this.agrohubOrderTime,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      comment: comment ?? this.comment,
      // deliveryId: deliveryId ?? this.deliveryId,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      discriminator: discriminator ?? this.discriminator,
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      paymentType: paymentType ?? this.paymentType,
      persons: persons ?? this.persons,
      status: status ?? this.status,
      storeId: storeId ?? this.storeId,
      totalPrice: totalPrice ?? this.totalPrice,
      unitsPrice: unitsPrice ?? this.unitsPrice,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agregatorExternalOrderId': agregatorExternalOrderId,
      'agregatorOrderId': agregatorOrderId,
      'agregatorOrderTime': agregatorOrderTime?.millisecondsSinceEpoch,
      'agrohubOrderTime': agrohubOrderTime?.millisecondsSinceEpoch,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'comment': comment,
      // 'deliveryId': deliveryId,
      'deliveryTime': deliveryTime?.millisecondsSinceEpoch,
      'discriminator': discriminator,
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'paymentType': paymentType,
      'persons': persons,
      'status': status,
      'storeId': storeId,
      'totalPrice': totalPrice,
      'unitsPrice': unitsPrice,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.agregatorExternalOrderId == agregatorExternalOrderId &&
        other.agregatorOrderId == agregatorOrderId &&
        other.agregatorOrderTime == agregatorOrderTime &&
        other.agrohubOrderTime == agrohubOrderTime &&
        other.clientName == clientName &&
        other.clientPhone == clientPhone &&
        other.comment == comment &&
        // other.deliveryId == deliveryId &&
        other.deliveryTime == deliveryTime &&
        other.discriminator == discriminator &&
        other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.paymentType == paymentType &&
        other.persons == persons &&
        other.status == status &&
        other.storeId == storeId &&
        other.totalPrice == totalPrice &&
        other.unitsPrice == unitsPrice &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return agregatorExternalOrderId.hashCode ^
        agregatorOrderId.hashCode ^
        agregatorOrderTime.hashCode ^
        agrohubOrderTime.hashCode ^
        clientName.hashCode ^
        clientPhone.hashCode ^
        comment.hashCode ^
        // deliveryId.hashCode ^
        deliveryTime.hashCode ^
        discriminator.hashCode ^
        id.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        paymentType.hashCode ^
        persons.hashCode ^
        status.hashCode ^
        storeId.hashCode ^
        totalPrice.hashCode ^
        unitsPrice.hashCode ^
        updatedAt.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
