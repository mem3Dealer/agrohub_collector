import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NetworkBloc() : super(ConnectionInitial()) {
    on<ListenConnection>(_checkNetworkConnection);
  }

  void _checkNetworkConnection(
      ListenConnection event, Emitter<NetworkState> emit) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    connectivityResult == ConnectivityResult.none
        ? emit(ConnectionFailure())
        : emit(ConnectionSuccess());
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectivityResult = result;
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
