import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  String? role;
  String? JWT;
  int? farmerId;
  bool? isChangePrice;
  bool? loading;

  AuthenticationState({
    this.role,
    this.JWT,
    this.farmerId,
    this.loading,
    this.isChangePrice,
  });

  @override
  List<dynamic> get props =>
      <dynamic>[role, JWT, farmerId, loading, isChangePrice];

  AuthenticationState copyWith(
      {String? role,
      String? JWT,
      int? farmerId,
      bool? loading,
      bool? isChangePrice}) {
    return AuthenticationState(
      role: role ?? this.role,
      JWT: JWT ?? this.JWT,
      farmerId: farmerId ?? this.farmerId,
      loading: loading ?? this.loading,
      isChangePrice: isChangePrice ?? this.isChangePrice,
    );
  }
}
