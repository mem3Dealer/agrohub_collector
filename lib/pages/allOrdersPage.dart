import 'dart:async';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
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

  bool isError = false;
  late Timer refresher;
  @override
  void initState() {
    super.initState();

    getOrders();

    const halfMin = Duration(seconds: 30);
    refresher = Timer.periodic(halfMin, (timer) {
      getOrders();
    });
  }

  @override
  void dispose() {
    // _t.cancel();
    refresher.cancel();
    super.dispose();
  }

  Future<void> getOrders() async {
    ordersBloc.add(OrdersGetAllOrders(
        onError: (e) {},
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
                                    "С этим заказом что-то не так.\nПопробуйте взять другой.",
                                secs: 2,
                                button: false);
                          } else if (state.errorUnavailableOrder == true) {
                            MyWidgets.buildSnackBar(
                                context: context,
                                content: "Заказ больше не доступен",
                                secs: 2,
                                button: false);
                          }
                        },
                        builder: (context, state) {
                          if (state.loading == true) {
                            return CircularProgressIndicator(
                              color: Color(0xffE14D43),
                            );
                          }
                          if (state.orders == null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Кажется, у нас какие-то неполадки.\nСвяжитесь с администратором.',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }
                          if (state.orders!.isEmpty == true) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Новых заказов в сборку пока нет :(",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.orders?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Order order = state.orders![index];
                                      return OrderTile(
                                          buildContext: cntx,
                                          index: index,
                                          order: order);
                                    }),
                              ),
                            ],
                          );
                        },
                      )),
                ))));
  }
}
