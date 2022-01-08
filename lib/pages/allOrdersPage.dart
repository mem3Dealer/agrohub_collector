import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOrdersPage extends StatelessWidget {
  static const String routeName = '/allOrders';

  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(false,
        title: 'Список заказов',
        body: Expanded(
          child: ListView(
            // shrinkWrap: true,
            children: [
              OrderTile(number: 'З1313', time: '12:10-13:40'),
              OrderTile(number: '345432', time: '12:10-13:40'),
              OrderTile(number: '32132', time: '12:10-13:40'),
              OrderTile(number: '64564', time: '12:10-13:40'),
              OrderTile(number: '64564', time: '12:10-13:40'),
            ],
          ),
        ));
  }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(),
//     body: const Center(
//       child: Text('Экран всех заказов'),
//     ),
//   );
// }

//   class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);
//   // final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MyScaffold(
//         title: 'Список заказов',
//         body: Expanded(
//           child: ListView(
//             // shrinkWrap: true,
//             children: [
//               OrderTile(number: 'З1313', time: '12:10-13:40'),
//               OrderTile(number: '345432', time: '12:10-13:40'),
//               OrderTile(number: '32132', time: '12:10-13:40'),
//               OrderTile(number: '64564', time: '12:10-13:40'),
//               OrderTile(number: '64564', time: '12:10-13:40'),
//             ],
//           ),
//         ));
//   }
// }
// }
}
