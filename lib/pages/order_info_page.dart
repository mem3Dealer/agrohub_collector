import 'dart:ui';

import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';

class OrderInfoPage extends StatelessWidget {
  String orderNumber;
  String deliveryTime;
  static const String routeName = '/infoOrder';
  OrderInfoPage(this.deliveryTime, this.orderNumber, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(true,
        title: orderNumber,
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
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
                  padding: const EdgeInsets.only(left: 18, right: 50, top: 10),
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
                  padding: const EdgeInsets.only(left: 18, right: 60, top: 10),
                  child: Row(
                    children: [
                      Text('Количество товаров:', style: style),
                      const SizedBox(
                        width: 55,
                      ),
                      Text(
                        '18 шт.',
                        style: style.copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 60, top: 10),
                  child: Row(
                    children: [
                      Text('Общий вес:', style: style),
                      SizedBox(
                        width: 127,
                      ),
                      Text(
                        '12,7 кг.',
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
                      SizedBox(
                        width: 103,
                      ),
                      Text(
                        '15 367 руб.',
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
  }

  TextStyle style = const TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16);
}

// Text('Детали заказа',
//                   style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24)),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('интервал доставки'),
//                         Text('количество товаров'),
//                         Text('общий вес'),
//                         Text('сумма заказа'),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('10-12'),
//                         Text('18 шт.'),
//                         Text('12,7 кг'),
//                         Text('15 673 р'),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
