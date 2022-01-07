import 'package:agrohub_collector_flutter/api/errorHandler.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_bloc.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:dio/dio.dart';

class HtttpSerivce {
  final authBloc =
      AuthenticationBloc(authenticationRepository: AuthenticationRepository());
  late Dio _dio;
  final String baseUrl = "https://dev-orders-api.agrohub.io";

  HttpServiceOrders() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
  }

  Future<Response<dynamic>> getRequest(
    String endPoint,
    Map<String, dynamic>? query,
  ) async {
    Response<dynamic> response;

    try {
      response = await _dio.get(endPoint, queryParameters: query);
      return response;
    } catch (exception) {
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<Response<dynamic>> post(String endPoint, dynamic data) async {
    Response<dynamic> response;

    try {
      response = await _dio.post(endPoint, data: data);
      return response;
    } catch (exception) {
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
