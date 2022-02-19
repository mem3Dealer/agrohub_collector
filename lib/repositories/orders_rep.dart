import 'dart:convert';
import 'dart:developer';

import 'package:agrohub_collector_flutter/api/apiOrders.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:dio/dio.dart';

import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:get_it/get_it.dart';

AuthenticationRepository authRep = AuthenticationRepository();
final authBloc = GetIt.I.get<AuthenticationBloc>();
final http = GetIt.I.get<HtttpSerivceOrders>();
String? url = '';

class OrdersRepository {
  //Получение всех заказов с рынка

  Future<List<Order>> getNewOrders() async {
    try {
      Response<dynamic> response =
          await http.get("/orders/get_all_orders/?status=NEW");
      List list = response.data['results'];

      List<Order> ord = list.map<Order>((e) => Order.fromMap(e)).toList();
      return ord;
    } catch (e) {
      inspect(e);
      return null!;
    }
  }

  //следующие заказы
  Future<List<Order>> getMoreOrders() async {
    Response<dynamic> response =
        await http.get("/orders/get_all_orders/?page=$url&per_page=7");
    List list = response.data['results'];

    if (response.data['next'].toString() != 'null') {
      String _url = response.data['next'];
      url = _url.substring(62);
    }
    // print(response.data);
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
    print(list);
    List<Product> listOfProducts =
        list.map<Product>((e) => Product.fromMap(e)).toList();
    for (Product p in listOfProducts) {
      p.status = 'collecting';
      p.collected_quantity = 0.0;
    }
    // print(listOfProducts);
    return listOfProducts;
  }

  //узнать статус конкретного заказа
  Future<Order> getThisOrder(int id) async {
    Response<dynamic> response =
        await http.get('/orders/order_search/?order_id=$id');

    Order res = Order.fromMap(response.data['result']);
    return res;
  }

  //обновить статус заказа
  void updateOrderStatus({required Map<String, dynamic> data}) {
    http.post('/orders/change_status_order/', data);
    print('SENT:$data');
  }

  //отправить собранную корзину продуктов
  void postProducts({required Map<String, dynamic> data}) {
    http.post('/orders/collect_product/', data);
    print('SENT:$data');
  }
}
