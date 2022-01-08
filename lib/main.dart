import 'package:agrohub_collector_flutter/bloc/data_provider/products_provider.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/business_logic_layer/collecting_lists_bloc.dart';

void main() {
  runApp(
    BlocProvider<CollectingListsBloc>(
        create: (BuildContext context) => CollectingListsBloc(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AllOrdersPage(),
    );

    // routes: ,
  }
}
