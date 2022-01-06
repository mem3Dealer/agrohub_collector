import 'package:flutter/material.dart';

import 'package:agrohub_collector_flutter/cont/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const <Widget>[
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
            ProductTiles(
              title: tomato,
              weight: weight,
            ),
          ],
        ),
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
