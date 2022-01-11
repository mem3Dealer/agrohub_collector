import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';

abstract class OrdersEvents {
  OrdersEvents();
}

class OrdersGetAllOrders extends OrdersEvents {
  OrdersGetAllOrders({
    this.params,
    this.onError,
    this.onSuccess,
  });

  final Map<String, dynamic>? params;
  final Function? onError;
  final Function? onSuccess;
}

// получение детального заказа
class OrdersGetDetailOrder extends OrdersEvents {
  OrdersGetDetailOrder({
    required this.id,
    this.onError,
    this.onSuccess,
  });

  final int id;
  final Function? onError;
  final Function? onSuccess;
}

class ChangeProductStatus extends OrdersEvents {
  ChangeProductStatus(
    this.collectedQuantity,
    this.isOnDelete, {
    required this.product,
    required this.newStatus,
  });
  bool isOnDelete = false;
  double collectedQuantity = 0.0;
  final Product product;
  final String newStatus;
}

// class CollectProduct extends OrdersEvents {
//   CollectProduct({
//     required this.collectedQuantity,
//     required this.product,
//   });
//   double collectedQuantity;
//   Product product;
// }
