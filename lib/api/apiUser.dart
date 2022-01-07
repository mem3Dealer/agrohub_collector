import 'dart:async';
import 'package:agrohub_collector_flutter/api/errorHandler.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_bloc.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import "package:dio/dio.dart";

AuthenticationRepository authRep = AuthenticationRepository();

class HttpService {
  AuthenticationBloc authBloc =
      AuthenticationBloc(authenticationRepository: authRep);
  late Dio _dio;

  final String baseUrl = "https://dev-base-api.agrohub.io";

  HttpService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: <String, dynamic>{"Authorization": authBloc.state.JWT},
      ),
    );
  }

  Future<Response<dynamic>> getRequest(String endPoint) async {
    Response<dynamic> response;
    try {
      response = await _dio.get(endPoint);
      return response;
    } catch (exception) {
      final String errorMessage =
          DioExceptions.fromDioError(exception as DioError).toString();
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<Response<dynamic>> get(
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

  Future<Response<dynamic>> patch(
    String endPoint,
    Map<String, dynamic>? data,
  ) async {
    Response<dynamic> response;

    try {
      response = await _dio.patch(endPoint, data: data);
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
