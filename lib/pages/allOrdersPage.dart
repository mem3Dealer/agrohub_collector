import 'dart:async';
import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_state.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/network/network_bloc.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';

OrdersRepository ord_rep = OrdersRepository();

FlutterSecureStorage storage = const FlutterSecureStorage();

class AllOrdersPage extends StatefulWidget {
  static const String routeName = '/allOrders';

  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final networkBloc = GetIt.I.get<NetworkBloc>();
  final ExpandableController _controller = ExpandableController();

  @override
  void initState() {
    getOrders();
    super.initState();
    // authBloc.add(AuthenticationInit());
    setState(() {
      context.read<NetworkBloc>().connectivityResult;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    context.read<NetworkBloc>().dispose();
  }

  Future<void> getOrders() async {
    ordersBloc.add(OrdersGetAllOrders(
        onError: (e) {
          inspect(e);
        },
        onSuccess: () => print('amazing')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
        bloc: networkBloc,
        builder: (context, networkState) {
          context.read<NetworkBloc>().add(ListenConnection());
          return networkState is ConnectionFailure
              // TODO можно отдельным классом оформить
              ? const Center(child: Text('Нет Интернет соединения'))
              : ListOrderShow(ordersBloc: ordersBloc, controller: _controller);
        });
  }
}

class ListOrderShow extends StatelessWidget {
  const ListOrderShow({
    Key? key,
    required this.ordersBloc,
    required ExpandableController controller,
  })  : _controller = controller,
        super(key: key);

  final OrdersBloc ordersBloc;
  final ExpandableController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        return MyScaffold(
          false,
          title: 'Список заказов',
          body: state.allOrders != null
              ? Expanded(
                  child: Center(
                      child: ListView.builder(
                          itemCount: state.allOrders?.length,
                          itemBuilder: (BuildContext context, int index) {
                            Order order = state.allOrders![index];
                            String time =
                                order.delivery_time!.substring(17, 22);
                            // DateTime time1 = DateTime.parse(
                            //     order.delivery_time.toString());
                            // DateTime time =
                            //     DateTime.parse(order.delivery_time это хорошая идея, но с бека приходит неправильный формат даты
                            return OrderTile(
                                controller: _controller,
                                id: order.id!,
                                time: "К $time",
                                deliveryId:
                                    int.parse(order.agregator_order_id!));
                          })),
                )
              : SizedBox(
                  child: const Center(child: CircularProgressIndicator()),
                  height: MediaQuery.of(context).size.height / 1.3,
                ),
        );
      },
    );
  }
}
