import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:agrohub_collector_flutter/model/orderTile.dart';
import 'package:agrohub_collector_flutter/product_card.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CollectingOrderPage extends StatelessWidget {
  const CollectingOrderPage({Key? key}) : super(key: key);

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
                        onTap: () {},
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
              children: const [
                OrderBoxes(title: 'Собрать'),
                OrderBoxes(title: 'Собрано'),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const ProductCard(),
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
        children: [
          Text(title),
        ],
      ),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
