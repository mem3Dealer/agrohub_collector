import 'package:agrohub_collector_flutter/model/orderTile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF1F1F1),
        body: ListView(
          children: [
            OrderTile(number: 'З1313', time: '12:10-13:40'),
            OrderTile(number: '345432', time: '12:10-13:40'),
            OrderTile(number: '32132', time: '12:10-13:40'),
            OrderTile(number: '64564', time: '12:10-13:40'),
          ],
        ));
  }
}
