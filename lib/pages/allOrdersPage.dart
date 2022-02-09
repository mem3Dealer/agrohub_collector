import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_state.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/components/productCard/productCard.dart';
import 'package:agrohub_collector_flutter/shared/globals.dart';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/date_symbols.dart';
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
  MyGlobals myGlobals = MyGlobals();
  bool isError = false;
  @override
  void initState() {
    super.initState();
    getOrders();

    // authBloc.add(AuthenticationInit());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getOrders() async {
    ordersBloc.add(OrdersGetAllOrders(
        onError: (e) {
          inspect(e);
          isError = true;
        },
        onSuccess: () => print('Everything`s proceeding as I have forseen')));
  }

  @override
  Widget build(BuildContext cntx) {
    return MyScaffold(false, false,
        title: 'Список заказов',
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: Colors.grey,
                      child: BlocConsumer<OrdersBloc, OrdersState>(
                        listener: (context, state) {
                          if (state.errorNullProducts == true) {
                            MyWidgets.buildSnackBar(
                                context: context,
                                content:
                                    "С этим заказом что-то не так.\nПопробуйте взять другой",
                                secs: 2,
                                button: true);
                          } else if (state.errorUnavailableOrder == true) {
                            MyWidgets.buildSnackBar(
                                context: context,
                                content: "Заказ больше не доступен",
                                secs: 2,
                                button: true);
                          }
                        },
                        builder: (context, state) {
                          return isError == false
                              ? state.orders != null && state.loading == false
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.orders?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Order order = Order();
                                        if (state.orders != null) {
                                          order = state.orders![index];
                                        }
                                        return OrderTile(
                                            buildContext: cntx,
                                            index: index,
                                            order: order);
                                      })
                                  : CircularProgressIndicator(
                                      color: Color(0xffE14D43),
                                    )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Кажется, у нас какие-то неполадки.\nСвяжитесь с администратором.',
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                );
                        },
                      )),
                ))));
  }
}

class OrdersDelivery {
  OrdersDelivery();
}
