import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';

class CollectingOrderPage extends StatelessWidget {
  String orderNumber;
  String deliveryTime;
  static const String routeName = '/collectingOrder';
  CollectingOrderPage(this.orderNumber, this.deliveryTime, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(orderNumber);
    return MyScaffold(
      false,
      title: "Заказ №$orderNumber",
      body: Container(),
      deliveryTime: deliveryTime,
    );
  }
}
