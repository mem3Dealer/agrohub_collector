import 'package:flutter/material.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Экран всех заказов'),
      ),
    );
  }
}
