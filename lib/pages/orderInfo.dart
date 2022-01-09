import 'dart:ui';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OrderInfoPage extends StatelessWidget {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  String orderNumber;
  String deliveryTime;
  static const String routeName = '/infoOrder';
  OrderInfoPage(this.deliveryTime, this.orderNumber, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        List<Product> _list = ordersBloc.state.listOfProducts!;
        double totalWeight = 0.0;
        double totalPrice = 0.0;
        for (var e in _list) {
          totalWeight += e.ordered_quantity ?? 0;
          totalPrice += e.unit_price ?? 0;
        }

        return MyScaffold(true,
            title: orderNumber,
            body: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                height: 216,
                width: 382,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text('Детали заказа',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24)),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 50, top: 10),
                      child: Row(
                        children: [
                          Text('Интервал доставки:', style: style),
                          const SizedBox(
                            width: 62,
                          ),
                          Text(
                            deliveryTime,
                            style: const TextStyle(
                                color: Color(0xffE14D43),
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 60, top: 10),
                      child: Row(
                        children: [
                          Text('Количество товаров:', style: style),
                          const SizedBox(
                            width: 55,
                          ),
                          Text(
                            '${_list.length} шт.',
                            style: style.copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 60, top: 10),
                      child: Row(
                        children: [
                          Text('Общий вес:', style: style),
                          const SizedBox(
                            width: 127,
                          ),
                          Text(
                            '$totalWeight кг',
                            style: style.copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18, right: 60, top: 10, bottom: 25),
                      child: Row(
                        children: [
                          Text('Сумма заказа:', style: style),
                          const SizedBox(
                            width: 103,
                          ),
                          Text(
                            '$totalPrice руб.',
                            style: style.copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 16,
                      endIndent: 16,
                      // height: 2,
                      thickness: 1.5,
                      color: Color(0xff69A8BB),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  TextStyle style = const TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16);
}
