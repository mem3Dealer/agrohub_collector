import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  String? role;
  String? JWT;
  int? collectorId;
  int? storeId;
  int? farmerId;
  bool? isChangePrice;
  bool? loading;

  AuthenticationState({
    this.role,
    this.JWT,
    this.collectorId,
    this.storeId,
    this.farmerId,
    this.isChangePrice,
    this.loading,
  });

  @override
  List<dynamic> get props => <dynamic>[
        role,
        JWT,
        farmerId,
        loading,
        isChangePrice,
        collectorId,
        storeId
      ];

  AuthenticationState copyWith(
      {String? role,
      String? JWT,
      int? farmerId,
      int? collectorId,
      int? storeId,
      bool? loading,
      bool? isChangePrice}) {
    return AuthenticationState(
      role: role ?? this.role,
      JWT: JWT ?? this.JWT,
      collectorId: collectorId ?? this.collectorId,
      storeId: storeId ?? this.storeId,
      farmerId: farmerId ?? this.farmerId,
      loading: loading ?? this.loading,
      isChangePrice: isChangePrice ?? this.isChangePrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'JWT': JWT,
      'collectorId': collectorId,
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
    return 'AuthenticationState(role: $role, JWT: $JWT, collectorId: $collectorId, storeId: $storeId, farmerId: $farmerId, isChangePrice: $isChangePrice, loading: $loading)';
  }
}
