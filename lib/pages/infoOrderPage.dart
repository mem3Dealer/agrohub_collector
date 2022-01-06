import 'package:flutter/material.dart';

class OrderInfoPage extends StatelessWidget {
  const OrderInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Экран дополнительной\nинформации по заказу'),
      ),
    );
  }
}
