import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CollectingOrderPage extends StatefulWidget {
  // Product order; TODO это нужно сделать через блок с полем Product collecting;
  final int agregatorOrderId;
  final String deliveryTime;
  static const String routeName = '/collectingOrder';
  const CollectingOrderPage(
      // this.order,
      this.agregatorOrderId,
      this.deliveryTime,
      {Key? key})
      : super(key: key);

  @override
  State<CollectingOrderPage> createState() => _CollectingOrderPageState();
}

class _CollectingOrderPageState extends State<CollectingOrderPage> {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ordersBloc.emit(ordersBloc.state.copyWith(listOfProducts: []));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(orderNumber);
    return MyScaffold(
      false,
      title: "Заказ №${widget.agregatorOrderId}",
      //TODO убрал substring, в MyScaffold поставил softwrap: false и overflow заработал-krs_83
      body: Container(),
      deliveryTime: widget.deliveryTime,
    );
  }
}
