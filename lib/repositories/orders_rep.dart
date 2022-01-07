// import 'package:dio/dio.dart';
// import 'package:agrohub_collector_flutter/api/apiOrders.dart';

// class OrdersRepository {
//   //Получение всех заказов с рынка
//   Future<List<Order>> getAllOrder(Map<String, dynamic>? params) async {
//     Response<dynamic> response =
//         await HttpServiceOrders().getRequest("/orders/get_all_orders/", params);
//     OrderList orderList = OrderList.fromJson(response.data);
//     List<Order>? order = orderList.order?.map<Order>((Order json) {
//       return json;
//     }).toList();
//     return order!;
//   }
// }
