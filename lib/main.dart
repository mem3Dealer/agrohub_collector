import 'dart:developer';

import 'package:agrohub_collector_flutter/api/apiOrders.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/network/network_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/loginPage.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final AuthenticationRepository _authenticationRepository =
    AuthenticationRepository();
final OrdersRepository _ordersRepository = OrdersRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  GetIt.instance
    ..registerSingleton<AuthenticationBloc>(
        AuthenticationBloc(authenticationRepository: _authenticationRepository))
    // ..registerFactory(() => Dio())
    ..registerSingleton<OrdersBloc>(OrdersBloc(_ordersRepository))
    ..registerSingleton<HtttpSerivceOrders>(HtttpSerivceOrders())
    ..registerSingleton<NetworkBloc>(NetworkBloc());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final networkBloc = GetIt.I.get<NetworkBloc>();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => authBloc,
        ),
        BlocProvider<OrdersBloc>(
          create: (BuildContext context) => ordersBloc,
        ),
        BlocProvider<NetworkBloc>(
          create: (BuildContext context) => networkBloc,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: const LoginPage(),
        // routes: ,
      ),
    );
  }
}
