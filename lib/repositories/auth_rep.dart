import 'dart:async';
import 'package:agrohub_collector_flutter/api/apiUser.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository {
  Future<String> login({
    required String login,
    required String password,
  }) async {
    final Response<dynamic> JWTResponse =
        await HttpService().post('/farmer/login/', <String, dynamic>{
      'username': login,
      'password': password,
    });
    return JWTResponse.data['access'];
  }
}
