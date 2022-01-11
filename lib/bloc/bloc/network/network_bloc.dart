import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  NetworkBloc() : super(ConnectionInitial()) {
    on<ListenConnection>(_checkNetworkConnection);
  }

  Future _checkNetworkConnection(
      ListenConnection event, Emitter<NetworkState> emit) async {
    StreamSubscription<ConnectivityResult> _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      add(result);
    });
  }

  //make dispose method
//_subscription.cancel();
//call this method in dispose in parent class
}
