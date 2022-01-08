import 'dart:convert';

import 'package:agrohub_collector_flutter/api/apiOrders.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_bloc.dart';
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
    // OrderList rawOrderList = OrderList.fromJson(response.data);
    // print('HEY');
    return ord;
  }

// Future<List<Order>?> getAllOrder() async {
  //   Response<dynamic> response = await http.get("/orders/get_all_orders/");
  //   // OrderList orderList = OrderList.fromJson(response.data);
  //   List list = response.data['results'];
  //   List<Order> listOfOrders = [];
  //   for (var element in list) {
  //     // var order = Order.fromMap(element);
  //     print(element.runtimeType);
  //     // listOfOrders.add();
  //   }
  //   print('RESULT IS: ${listOfOrders.first}');

  //   // List<Order>? order = response.data['results']!.map<Order>((Order json) {
  //   //   print(json);
  //   //   return json;
  //   // }).toList();
  //   return listOfOrders;
  // }
}
