import 'dart:async';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'auth_events.dart';
import 'auth_state.dart';

List<int> storeToEditable = <int>[114, 101, 122];

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationState()) {
    on<AuthenticationLogIn>(_onEventAuthenticationLogIn);
    on<AuthenticationInit>(_onEventAuthenticationInit);
    on<AuthenticationLoading>(_onEventAuthenticationLoading);
    on<AuthenticationLogout>(_onEventAuthenticationLogout);
  }

  Future<void> _onEventAuthenticationLoading(
    AuthenticationLoading event,
    Emitter<AuthenticationState> emitter,
  ) async {
    emitter(
      state.copyWith(
        loading: event.loading,
      ),
    );
  }

  Future<void> _onEventAuthenticationLogout(
    AuthenticationLogout event,
    Emitter<AuthenticationState> emitter,
  ) async {
    await storage.write(key: 'token', value: '');
    await storage.write(key: 'user', value: '');
    emitter(
      state.copyWith(
        JWT: '',
        role: '',
      ),
    );
    event.onSuccess!();
  }

  void _onEventAuthenticationLogIn(
    AuthenticationLogIn event,
    Emitter<AuthenticationState> emitter,
  ) async {
    try {
      String token = await (_logIn(
        login: event.login,
        password: event.password,
        onError: event.onError,
        onSuccess: event.onSuccess,
      ));
      Map<String, dynamic> payload = Jwt.parseJwt(token);

      String role = '';
      int? farmerId = payload['farmer_id'];
      bool? isChangePrice;
      String storeId = '';
      if (farmerId != null) {
        // await FirebaseMessaging.instance.subscribeToTopic('farmer');
        farmerId = payload['farmer_id'];
        storeId = payload['store_id'].toString();
        isChangePrice = storeToEditable.contains(payload['store_id']);
      } else {
        // await FirebaseMessaging.instance.subscribeToTopic('collector');
        role = 'collector';
      }
      // await FirebaseMessaging.instance
      //     .getToken()
      //     .then((String? value) => print('token firebase $value'));
      await storage.write(key: 'role', value: role);
      await storage.write(key: 'store', value: storeId);
      await storage.write(key: 'farmerId', value: farmerId.toString());
      emitter(
        state.copyWith(
          JWT: 'JWT $token',
          role: role,
          farmerId: farmerId,
          loading: false,
          isChangePrice: isChangePrice,
        ),
      );
      event.onSuccess!();
    } catch (e) {
      event.onError!(e);
    }
  }

  Future<void> _onEventAuthenticationInit(
    AuthenticationInit event,
    Emitter<AuthenticationState> emitter,
  ) async {
    Map<String, dynamic>? userInfo = await _initUser(onError: event.onError);
    if (userInfo != null) {
      emitter(
        state.copyWith(
          JWT: userInfo['token'],
          role: userInfo['role'],
          isChangePrice: userInfo['store'],
          farmerId: userInfo['farmerId'],
        ),
      );
      event.onSuccess!(userInfo['role']);
    } else {
      event.onError!();
    }
  }

  Future<String> _logIn({
    required String login,
    required String password,
    Function? onError,
    Function? onSuccess,
  }) async {
    final String token = await _authenticationRepository.login(
      login: login,
      password: password,
    );

    await storage.write(key: 'token', value: 'JWT $token');

    return token;
  }

  Future<Map<String, dynamic>?> _initUser({Function? onError}) async {
    String? token = await storage.read(key: 'token');

    if (token != '' && token != null) {
      String? store = await storage.read(key: 'store');
      if (await storage.read(key: 'role') == 'collector') {
        return <String, dynamic>{
          'role': 'collector',
          'token': token,
          'store': false
        };
      } else {
        String? farmer = await ((storage.read(key: 'farmerId')));
        int farmerId = int.parse(farmer!);
        // int farmerId = int.parse(await (storage.read(key: 'farmerId').toString()));
        return <String, dynamic>{
          'farmerId': farmerId,
          'role': '',
          'token': token,
          'store': storeToEditable.contains(int.parse(store!))
        };
      }
    } else {
      return null;
    }
  }
}
