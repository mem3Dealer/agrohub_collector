import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkState(true)) {
    // on<NetworkEvent>();
    on<ListenConnection>(_checker);
    on<ConnectionFailure>(_eventConnectionFailure);
  }
  late StreamSubscription _subscription;

  void _eventConnectionFailure(
      ConnectionFailure event, Emitter<NetworkState> emitter) {
    showSimpleNotification(Text('no internet'));
  }

  void _checker(NetworkEvent event, Emitter<NetworkState> emitter) {
    print('it evokes?');
    if (event is ListenConnection) {
      print(event);
      _subscription =
          InternetConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == InternetConnectionStatus.disconnected
            ? emitter(state.copyWith(hasInternet: false))
            : emitter(state.copyWith(hasInternet: true))));
        print(state);
      });
    }
    if (event is ConnectionChanged) {
      // emitter(event.emittedEvent);
      print('event is connectiong changed');
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
