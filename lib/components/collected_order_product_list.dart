import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:agrohub_collector_flutter/cont/constants.dart';

class CollectedOrderProductList extends StatelessWidget {
  const CollectedOrderProductList({Key? key}) : super(key: key);
  static final List<ExpandableProductTiles> collectedListOrder = [
    const ExpandableProductTiles(stringPrice: strPrice, price: 1.8),
    const ExpandableProductTiles(stringPrice: strPrice, price: 1.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: collectedListOrder,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          const Placeholder(
            fallbackHeight: 150.0,
            fallbackWidth: 150.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 40.0,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '$weight кг',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
