// import 'package:equatable/equatable.dart';

part of 'network_bloc.dart';

class NetworkState extends Equatable {
  bool hasInternet;
  NetworkState(
    this.hasInternet,
  );

  @override
  String toString() => 'NetworkState(hasInternet: $hasInternet)';

  @override
  List<Object> get props => [hasInternet];

  NetworkState copyWith({
    bool? hasInternet,
  }) {
    return NetworkState(
      hasInternet ?? this.hasInternet,
    );
  }
}

// class ConnectionInitial() extends NetworkState {}

// class ConnectionSuccess extends NetworkState {}

// class ConnectionFailureState extends NetworkState {
//   // String message;
//   // ConnectionFailure(this.message);
// }
