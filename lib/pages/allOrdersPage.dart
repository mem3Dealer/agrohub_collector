import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_state.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

OrdersRepository ord_rep = OrdersRepository();

FlutterSecureStorage storage = FlutterSecureStorage();

class AllOrdersPage extends StatefulWidget {
  static const String routeName = '/allOrders';

  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final ExpandableController _controller = ExpandableController();
  @override
  void initState() {
    getOrders();
    super.initState();
    // authBloc.add(AuthenticationInit());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getOrders() async {
    ordersBloc.add(OrdersGetAllOrders(
        onError: (e) {
          inspect(e);
        },
        onSuccess: () => print('amaizing')));
  }

  @override
  Widget build(BuildContext context) {
    // print();
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        // ordersBloc.add(OrdersGetAllOrders());
        // ord_rep.getAllOrders();
        // print('THESE ARE: ${ordersBloc.state}');
        return MyScaffold(
          false,
          false,
          title: 'Список заказов',
          body: state.allOrders != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.allOrders?.length,
                  itemBuilder: (BuildContext context, int index) {
                    Order order = state.allOrders![index];
                    String time = order.delivery_time!.substring(17, 22);
                    ExpandableController ctrl = ExpandableController();

                    // DateTime time1 = DateTime.parse(
                    //     order.delivery_time.toString());
                    // DateTime time =
                    //     DateTime.parse(order.delivery_time это хорошая идея, но с бека приходит неправильный формат даты
                    return OrderTile(
                        controller: ctrl,
                        id: order.id!,
                        time: "К $time",
                        deliveryId: int.parse(order.agregator_order_id!));
                  })
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
