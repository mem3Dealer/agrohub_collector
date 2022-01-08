import 'dart:developer';

import 'package:agrohub_collector_flutter/api/errorHandler.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_bloc.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HtttpSerivceOrders {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  Dio dio = Dio();

  final String baseUrl = "https://dev-orders-api.agrohub.io";

  HttpServiceOrders() {
    print('aloha');
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
    print('alohahaha');
  }

  Future<Response<dynamic>> getRequest(
    String endPoint, {
    Map<String, dynamic>? query,
  }) async {
    Response<dynamic> response;
    try {
      response = await dio.get(endPoint, queryParameters: query);
      return response;
    } catch (exception) {
      inspect(exception);
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<Response<dynamic>> get(String endPoint) async {
    Response<dynamic> response;
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
    try {
      response = await _dio.get(endPoint);
      return response;
    } catch (exception) {
      inspect(exception);
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
