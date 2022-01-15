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
              ? state.allOrders!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      itemCount: state.allOrders?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Order order = state.allOrders![index];
                        if (order.status != 'IN PROGRESS') {
                          return OrderTile(order: order);
                        } else {
                          return Container(
                            child: Text(order.status.toString()),
                          );
                        }
                      })
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Кажется, у нас какие-то неполадки.\nСвяжитесь с администратором.',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xffE14D43),
                )),
        );
      },
    );
  }
}

// class AnotherOne extends StatelessWidget {
//   const AnotherOne({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//        child: ExpansionPanelList.radio(
//          children: widget.state.allOrders!
//              .map<ExpansionPanelRadio>((Order order) {
//            return ExpansionPanelRadio(
//              value: order.id!,
//              headerBuilder:
//                  (BuildContext context, bool isExpanded) {
//                return Card(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Padding(
//                          padding: const EdgeInsets.fromLTRB(
//                              16, 12, 56, 12),
//                          child: Row(
//                            mainAxisAlignment:
//                                MainAxisAlignment.start,
//                            children: [
//                              Text(
//                                "Заказ №${order.agregator_order_id}",
//                                textAlign: TextAlign.left,
//                                style: const TextStyle(
//                                    fontFamily: 'Roboto',
//                                    fontSize: 24,
//                                    fontWeight: FontWeight.w500),
//                              ),
//                            ],
//                          )),
//                      const Divider(
//                        // height: 2,
//                        thickness: 1.5,
//                        color: Color(0xff69A8BB),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(
//                            265, 12, 0, 10),
//                        child: Row(
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment:
//                              MainAxisAlignment.end,
//                          children: [
//                            Text(
//                              '12:30',
//                              textAlign: TextAlign.end,
//                              style: const TextStyle(
//                                  fontFamily: 'Roboto',
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.w500),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                );
//              },
//              body: ListTile(
//                title: Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(4)),
//                  width: 350,
//                  height: 56,
//                  child: ElevatedButton(
//                    style: ButtonStyle(
//                        backgroundColor:
//                            MaterialStateProperty.all(
//                      const Color(0xff69A8BB),
//                    )),
//                    onPressed: () {
//                      // getProduct(widget.order).then((value) {
//                      //   Navigator.push<void>(
//                      //     context,
//                      //     MaterialPageRoute<void>(
//                      //       builder: (BuildContext context) =>
//                      //           CollectingOrderPage(
//                      //               // widget.imageUrl,
//                      //               widget.order),
//                      //     ),
//                      //   );
//                      // });
//                    },
//                    child: const Text(
//                      'Начать сборку',
//                      style: TextStyle(
//                          fontFamily: 'Roboto',
//                          fontWeight: FontWeight.w400,
//                          fontSize: 16),
//                    ),
//                  ),
//                ),
//              ),
//            );
//          }).toList(),
//        ),
//      );
//   }
// }
