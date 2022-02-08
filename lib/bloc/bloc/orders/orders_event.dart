import 'package:flutter/cupertino.dart';

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
    required this.order,
    required this.context,
    this.onError,
    this.onSuccess,
  });
  BuildContext context;
  final Order order;
  // final int id;
  final Function? onError;
  final Function? onSuccess;
}

class ChangeProductStatus extends OrdersEvents {
  ChangeProductStatus(
    this.collectedQuantity, {
    required this.product,
    required this.newStatus,
  });
  double collectedQuantity = 0.0;
  final Product product;
  final String newStatus;
}

class InitCollectingOrder extends OrdersEvents {
  Function? onError;
  Function? onSuccess;
  InitCollectingOrder(
      {required this.collectingOrderId,
      required this.context,
      this.onError,
      this.onSuccess});
  int? collectingOrderId;
  BuildContext context;
}

class FinishCollecting extends OrdersEvents {
  BuildContext context;
  FinishCollecting({required this.context});
}

class LoadNewOrders extends OrdersEvents {
  // BuildContext context;
  LoadNewOrders();
}

// class CollectProduct extends OrdersEvents {
//   CollectProduct({
//     required this.collectedQuantity,
//     required this.product,
//   });
//   double collectedQuantity;
//   Product product;
// }
class OrdersLoading extends OrdersEvents {
  bool loading = false;
  OrdersLoading({
    required this.loading,
  });
}
