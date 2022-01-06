import 'package:flutter/material.dart';

class CollectingOrderPage extends StatelessWidget {
  const CollectingOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Экран сбора заказа'),
      ),
    );
  }
}
