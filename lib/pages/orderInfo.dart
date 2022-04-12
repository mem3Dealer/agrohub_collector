import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
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
        final _tTh = Theme.of(context).textTheme;
        // double totalPrice = 0.0;
        for (Product e in _list) {
          totalWeight += e.ordered_quantity ?? 0;
          // totalPrice += e.unit_price ?? 0;
        }
        Widget _sB = SizedBox(
          height: 12,
        );
        var _wdt = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            leading: IconButton(
                color: Color(0xff363B3F),
                padding: EdgeInsets.only(left: 16),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined)),
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text("Заказ №${order.agregatorOrderId}",
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: _tTh.headlineLarge!),
            ),
          ),
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
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            child:
                                Text('Детали заказа:', style: _tTh.headline4),
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
                                leftSide('Дата заказа:', context),
                                _sB,
                                leftSide('Время доставки:', context),
                                _sB,
                                leftSide('Количество товаров:', context),
                                _sB,
                                leftSide('Общий вес:', context),
                                _sB,
                                leftSide('Сумма заказа:', context),
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
                                  rightSide(date, context),
                                  _sB,
                                  rightSide(_time, context, isTime: true),
                                  _sB,
                                  rightSide('${_list.length} шт.', context),
                                  _sB,
                                  rightSide("$totalWeight кг", context),
                                  _sB,
                                  rightSide('${order.totalPrice} руб.', context)
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
          ),
        );
      },
    );
  }

  Widget leftSide(
    String text,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Text(text, style: Theme.of(context).textTheme.headline1),
    );
  }

  Widget rightSide(String text, BuildContext context, {bool isTime = false}) {
    return Container(
      // width: 117,
      child: Text(text,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              color: isTime ? Color(0xffE14D43) : Color(0xff363B3F),
              fontWeight: isTime ? FontWeight.w700 : FontWeight.w500)),
    );
  }
}
