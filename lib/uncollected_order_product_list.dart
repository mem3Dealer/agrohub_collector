import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:agrohub_collector_flutter/cont/constants.dart';

class UncollectedOrderProductList extends StatelessWidget {
  const UncollectedOrderProductList({Key? key}) : super(key: key);
  static final List<ExpandableProductTiles> listOrder = [
    const ExpandableProductTiles(stringPrice: strRrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strRrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strRrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strRrice, price: 113.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: listOrder,
        ),
      ),
    );
  }
}

class ExpandableProductTiles extends StatefulWidget {
  const ExpandableProductTiles({
    Key? key,
    required this.stringPrice,
    required this.price,
  }) : super(key: key);
  final String stringPrice;
  final double price;

  @override
  State<ExpandableProductTiles> createState() => _ExpandableProductTilesState();
}

class _ExpandableProductTilesState extends State<ExpandableProductTiles> {
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        hasIcon: false,
      ),
      collapsed: Container(),
      expanded: Column(
        children: [
          const Divider(
            color: Colors.blue,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(widget.stringPrice), Text('${widget.price} р/кг')],
          ),
          const SizedBox(height: 20.0),
          const Align(
            child: Text(
              'Товара собрано',
            ),
            alignment: Alignment.bottomLeft,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Собрать'),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      header: const ProductTiles(
        title: tomato,
        weight: weight,
      ),
    );
  }
}

class ProductTiles extends StatelessWidget {
  const ProductTiles({Key? key, required this.title, required this.weight})
      : super(key: key);
  final String title;
  final double weight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        const Placeholder(
          fallbackHeight: 150,
          fallbackWidth: 150,
        ),
        Expanded(
          child: Column(
            children: [
              Text(title),
              Align(
                child: Text('$weight кг'),
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
