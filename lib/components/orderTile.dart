import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatefulWidget {
  Order order;
  BuildContext buildContext;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getProduct(Order order, BuildContext context) async {
    ordersBloc.add(OrdersGetDetailOrder(
      context: widget.buildContext,
      order: order,
    ));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    DateFormat format = DateFormat('HH:mm');
    DateFormat _dayFormat = DateFormat('dd.MM.yy');
    String _day =
        _dayFormat.format(widget.order.deliveryTime ?? DateTime.now());
    String _time = format.format(widget.order.deliveryTime ?? DateTime.now());
    final _theme = Theme.of(context);
    final _cs = Theme.of(context).colorScheme;
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
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Заказ №${widget.order.agregatorOrderId}",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: _theme.textTheme.headline3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:
                                  Text(_day, style: _theme.textTheme.subtitle1),
                            )
                          ],
                        )),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 28, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_time,
                              textAlign: TextAlign.end,
                              style: _theme.textTheme.subtitle2),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/expIcon.png'))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                collapsed: Container(
                  child: kDebugMode
                      ? Text('${widget.order.id}, ${widget.order.status}')
                      : null,
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
                                  backgroundColor:
                                      MaterialStateProperty.all(_cs.tertiary),
                                  overlayColor: MaterialStateProperty.all(
                                      Color(0xff4a7683))),
                              onPressed: () {
                                getProduct(widget.order, context);
                              },
                              child: Text('Начать сборку',
                                  style: _theme.textTheme.headline2!
                                      .copyWith(color: Colors.white))),
                        ),
                      )),
                ),
              ),
            );
          },
        ));
  }
}
