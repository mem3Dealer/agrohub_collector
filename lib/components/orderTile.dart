import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class OrderTile extends StatefulWidget {
  Order order;

  OrderTile({
    required this.order,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  late var _exContrl = ExpandableController();
  @override
  void initState() {
    super.initState();
    _exContrl = ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    _exContrl.dispose();
    super.dispose();
  }

  // double _height = 116;
  // bool isVisiible = true;

  Future getProduct(int id) async {
    ordersBloc.add(OrdersGetDetailOrder(
        id: id,
        onError: (e) {
          inspect(e);
        },
        onSuccess: () {}));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return buildOrderTile(widget.order);
  }

  Widget buildOrderTile(Order order) {
    // DateTime? _time =
    //     DateFormat('EEE, dd MMM yyyy HH:MM').parse(order.delivery_time!);
    DateFormat format = DateFormat('HH:MM');
    String _time = format.format(order.delivery_time!);
    // print(_time);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Card(
        child: ExpandablePanel(
          // key: widget.myKey,
          controller: _exContrl,
          theme: const ExpandableThemeData(
            hasIcon: false,
          ),
          header: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 56, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Заказ №${order.agregator_order_id}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              const Divider(
                // height: 2,
                thickness: 1.5,
                color: Color(0xff69A8BB),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(265, 12, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
          collapsed: Container(),
          expanded: Center(
            child: SizedBox(
                height: 72,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    width: 350,
                    height: 56,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color(0xff69A8BB),
                      )),
                      onPressed: () async {
                        await getProduct(widget.order.id!).then((value) {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  CollectingOrderPage(
                                      // widget.imageUrl,
                                      widget.order),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        'Начать сборку',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
