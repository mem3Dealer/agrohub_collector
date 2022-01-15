import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  String? role;
  String? JWT;
  int? collectorId;
  int? currentCollectingOrderId;
  int? storeId;
  int? farmerId;
  bool? isChangePrice;
  bool? loading;
  AuthenticationState({
    this.role,
    this.JWT,
    this.collectorId,
    this.currentCollectingOrderId,
    this.storeId,
    this.farmerId,
    this.isChangePrice,
    this.loading,
  });

  AuthenticationState copyWith({
    String? role,
    String? JWT,
    int? collectorId,
    int? currentCollectingOrderId,
    int? storeId,
    int? farmerId,
    bool? isChangePrice,
    bool? loading,
  }) {
    return AuthenticationState(
      role: role ?? this.role,
      JWT: JWT ?? this.JWT,
      collectorId: collectorId ?? this.collectorId,
      currentCollectingOrderId:
          currentCollectingOrderId ?? this.currentCollectingOrderId,
      storeId: storeId ?? this.storeId,
      farmerId: farmerId ?? this.farmerId,
      isChangePrice: isChangePrice ?? this.isChangePrice,
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'JWT': JWT,
      'collectorId': collectorId,
      'currentCollectingOrderId': currentCollectingOrderId,
      'storeId': storeId,
      'farmerId': farmerId,
      'isChangePrice': isChangePrice,
      'loading': loading,
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      role: map['role'],
      JWT: map['JWT'],
      collectorId: map['collectorId']?.toInt(),
      currentCollectingOrderId: map['currentCollectingOrderId']?.toInt(),
      storeId: map['storeId']?.toInt(),
      farmerId: map['farmerId']?.toInt(),
      isChangePrice: map['isChangePrice'],
      loading: map['loading'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthenticationState(role: $role, JWT: $JWT, collectorId: $collectorId, currentCollectingOrderId: $currentCollectingOrderId, storeId: $storeId, farmerId: $farmerId, isChangePrice: $isChangePrice, loading: $loading)';
  }

  @override
  List<dynamic> get props {
    return [
      role,
      JWT,
      collectorId,
      currentCollectingOrderId,
      storeId,
      farmerId,
      isChangePrice,
      loading,
    ];
  }
}
