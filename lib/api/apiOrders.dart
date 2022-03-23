import 'dart:developer';
import 'package:agrohub_collector_flutter/api/errorHandler.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HtttpSerivceOrders {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  Dio dio = Dio();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  // final String baseUrl = "https://dev-orders-api.agrohub.io"; //смотрит на тест
  final String baseUrl = "https://orders-api.agrohub.io"; //смотрит на прод

  HttpServiceOrders() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
  }

  Future<Response<dynamic>> post(
      String endPoint, Map<String, dynamic> data) async {
    Response<dynamic> response;
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
    try {
      response = await _dio.post(endPoint, data: data);
      return response;
    } catch (exception) {
      inspect(exception);
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
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
