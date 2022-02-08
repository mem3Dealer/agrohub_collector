import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:agrohub_collector_flutter/shared/globals.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatefulWidget {
  Order order;
  BuildContext buildContext;

  // Future<void> onPressed;
  // ExpandableController controller;
  int index;
  OrderTile({
    required this.order,
    required this.buildContext,
    // required this.controller,
    required this.index,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  bool _isLoading = false;
  MyGlobals myGlobals = MyGlobals();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // widget.controller.dispose();
  }

  Future<void> getProduct(Order order, BuildContext context) async {
    // BuildContext _bCtx = myGlobals.scaffoldKey.currentContext!;
    ordersBloc.add(OrdersGetDetailOrder(
      context: widget.buildContext,
      order: order,
    ));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    DateFormat format = DateFormat('HH:MM');
    String _time = format.format(widget.order.deliveryTime ?? DateTime.now());
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          bloc: ordersBloc,
          builder: (_context, state) {
            return Card(
              child: ExpandablePanel(
                // controller: widget.controller,
                theme: const ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  iconPadding: EdgeInsets.zero,
                  hasIcon: false,
                ),
                header: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 0, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Заказ №${widget.order.agregatorOrderId}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color(0xff363B3F),
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/expIcon.png'))),
                              ),
                            )
                          ],
                        )),
                    const Divider(
                      // height: 2,
                      thickness: 1.5,
                      color: Color(0xff69A8BB),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _time,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                collapsed: Container(
                  child: Text('${widget.order.id}, ${widget.order.status}'),
                ),
                expanded: Center(
                  child: SizedBox(
                      height: 72,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          width: 350,
                          height: 56,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                const Color(0xff69A8BB),
                              )),
                              onPressed: () {
                                getProduct(widget.order, context);
                                setState(() {
                                  _isLoading = true;
                                });
                              },
                              child: Text(
                                'Начать сборку',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              )),
                        ),
                      )),
                ),
              ),
            );
          },
        ));
  }
}
