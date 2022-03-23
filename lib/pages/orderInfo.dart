import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OrderInfoPage extends StatelessWidget {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  static const String routeName = '/infoOrder';
  OrderInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        DateFormat _dayFormat = DateFormat('dd.MM.yy');
        List<Product> _list = ordersBloc.state.listOfProducts!;
        Order order = ordersBloc.state.currentOrder!;
        DateFormat format = DateFormat('HH:mm');
        String _time = format.format(order.deliveryTime!);
        String date = _dayFormat.format(order.deliveryTime!);
        double totalWeight = 0.0;
        // double totalPrice = 0.0;
        for (Product e in _list) {
          totalWeight += e.ordered_quantity ?? 0;
          // totalPrice += e.unit_price ?? 0;
        }
        Widget _sB = SizedBox(
          height: 12,
        );
        var _wdt = MediaQuery.of(context).size.width;

        return MyScaffold(true, false,
            title: "Заказ №${order.agregatorOrderId}",
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, top: 16, bottom: 16),
                              child: Text('Детали заказа:',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  leftSide('Дата заказа:'),
                                  _sB,
                                  leftSide('Время доставки:'),
                                  _sB,
                                  leftSide('Количество товаров:'),
                                  _sB,
                                  leftSide('Общий вес:'),
                                  _sB,
                                  leftSide('Сумма заказа:'),
                                ],
                              ),
                            ),
                            SizedBox(width: _wdt > 360 ? _wdt * 0.15 : 5),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    rightSide(date),
                                    _sB,
                                    rightSide(_time, isTime: true),
                                    _sB,
                                    rightSide('${_list.length} шт.'),
                                    _sB,
                                    rightSide("$totalWeight кг"),
                                    _sB,
                                    rightSide('${order.totalPrice} руб.')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          indent: 16,
                          endIndent: 16,
                          // height: 2,
                          thickness: 2,
                          color: Color(0xff69A8BB),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  Widget leftSide(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Text(text, style: style),
    );
  }

  Widget rightSide(String text, {bool isTime = false}) {
    return Container(
      // width: 117,
      child: Text(text,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: style.copyWith(
              color: isTime ? Color(0xffE14D43) : Color(0xff363B3F),
              fontWeight: isTime ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  TextStyle style = const TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16);
}
