import 'dart:convert';

import 'package:agrohub_collector_flutter/api/apiOrders.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:dio/dio.dart';

import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:get_it/get_it.dart';

AuthenticationRepository authRep = AuthenticationRepository();
final authBloc = GetIt.I.get<AuthenticationBloc>();
final http = GetIt.I.get<HtttpSerivceOrders>();

class OrdersRepository {
  //Получение всех заказов с рынка

  Future<List<Order>> getAllOrders() async {
    Response<dynamic> response = await http.get("/orders/get_all_orders/");
    List list = response.data['results'];

    List<Order> ord = list.map<Order>((e) => Order.fromMap(e)).toList();
    return ord;
  }

  //конкретный заказ
  Future<List<Product>?> getDetailOrder(
    int id,
  ) async {
    Response<dynamic> response =
        await http.get("/orders/get_detailed_order/?order_id=$id");
    List list = response.data;

    List<Product> listOfProducts =
        list.map<Product>((e) => Product.fromMap(e)).toList();
    return listOfProducts;
  }

  Future<Order> getThisOrder(int id) async {
    Response<dynamic> response =
        await http.get('/orders/order_search/?order_id=$id');
    // print(response);
    Order res = Order.fromMap(response.data['result']);
    return res;
  }

  void setOrderStatus({required int id, required String status}) {
    //TODO оформить это надобно
  }
}
