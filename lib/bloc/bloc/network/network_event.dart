part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  void emitter;
  // NetworkEvent emittedEvent;
  ConnectionChanged(this.emitter);
}

class ConnectionFailure extends NetworkEvent {}

class ConnectionSuccess extends NetworkEvent {}
