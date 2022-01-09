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
