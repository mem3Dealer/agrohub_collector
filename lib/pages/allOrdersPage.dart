import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_state.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/components/productCard.dart';
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
    // _controller.dispose();
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
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        List _ctrlList = [];
        // ExpandableController _lastCtrl = ExpandableController();
        if (state.allOrders != null) {
          _ctrlList = List<ExpandableController>.generate(
              state.allOrders!.length, (index) {
            final controller = ExpandableController();
            controller.addListener(() {
              // bool _isAny = false;
              // // int? _index;
              // for (var i = 0; i < state.allOrders!.length; i++) {
              //   _ctrlList.any((element) {
              //     // _index = element[index];
              //     return _isAny = element.expanded;
              //   });
              //   if (i == index) {
              //     // _index = i;
              //     // _lastCtrl = _ctrlList[i];
              //     print('yes');
              //   } else if (i != index && _isAny == true) {
              //     print('ee?');
              //     // _isAny = false;
              //     Future.delayed(Duration(milliseconds: 500), () {
              //       _ctrlList[index].expanded = false;
              //       // _ctrlList[i].expanded = false;
              //       // _ctrlList[i].expanded = true;

              //       // _ctrlList[i].toggle();
              //       // print('ctrl collapsed $i');
              //     });
              //   }

              //   // if (i != index) {

              //   //   if()
              //   //   _ctrlList[i].toggle();
              //   // } else {
              //   //   if (_ctrlList[i].expanded == false) {

              //   //   }
              //   // }
              // }
            });
            // print(controller);
            return controller;
          });
        }

        return MyScaffold(false, false, title: 'Список заказов', body: Center(
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (_context, state) {
              return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: Colors.grey,
                      child: isError == false
                          ? state.loading == false
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.ordersNew?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Order order = Order();
                                    if (state.ordersNew != null) {
                                      order = state.ordersNew![index];
                                    } else {
                                      // print('sucks');
                                      // ordersBloc.add(LoadNewOrders());
                                    }
                                    return OrderTile(
                                        buildContext: cntx,

                                        // controller: _ctrlList[index],
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
                            ),
                    ),
                  ));
            },
          ),
        ));
      },
    );
  }
}
