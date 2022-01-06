import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:agrohub_collector_flutter/uncollected_order_product_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'orderInfo.dart';

class CollectingOrderPage extends StatelessWidget {
  const CollectingOrderPage(String number, String time, {Key? key})
      : super(key: key);
  static const String routeName = '/collectingOrder';

  //Экран сбора заказа
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Заказ №З1313',
                        style: orderTitle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    OrderInfoPage('34', '45'),
                              ));
                        },
                        child: const Icon(
                          Icons.adjust,
                          color: Colors.red,
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
                const Align(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      '10:00 - 12:00',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () {},
                    child: const OrderBoxes(title: 'Собрать')),
                OutlinedButton(
                    onPressed: () {},
                    child: const OrderBoxes(title: 'Собрано')),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const UncollectedOrderProductList(),
          ],
        ),
      ),
    );
  }
}

class OrderBoxes extends StatelessWidget {
  const OrderBoxes({
    Key? key,
    required this.title,
    //this.quantity
  }) : super(key: key);
  final String title;
  //final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 10.0),
          Text(UncollectedOrderProductList.listOrder.length.toString()),
        ],
      ),
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
