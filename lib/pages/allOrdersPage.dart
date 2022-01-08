import 'package:agrohub_collector_flutter/bloc/bloc/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth_state.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';

import 'package:agrohub_collector_flutter/components/orderTile.dart';
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
  @override
  void initState() {
    getOrders();
    super.initState();
    // authBloc.add(AuthenticationInit());
  }

  void getOrders() {
    ordersBloc.add(OrdersGetAllOrders());
  }

  @override
  Widget build(BuildContext context) {
    // print();
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        // ordersBloc.add(OrdersGetAllOrders());
        // ord_rep.getAllOrders();
        print('THESE ARE: ${ordersBloc.state}');
        return MyScaffold(false,
            title: 'Список заказов',
            body: Expanded(child: Container()
                // ListView.builder(
                //     itemCount: ordersBloc.state.allOrders!.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return OrderTile(
                //           number: ordersBloc.state.orderId.toString(),
                //           time: ordersBloc.state.deliveryTime!);
                //     }))

                ));
      },
    );
  }
}
