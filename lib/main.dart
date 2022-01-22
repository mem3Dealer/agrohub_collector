import 'dart:developer';

import 'package:agrohub_collector_flutter/api/apiOrders.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/network/network_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:agrohub_collector_flutter/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/components/orderTile.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/loginPage.dart';
import 'package:agrohub_collector_flutter/repositories/auth_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';

final AuthenticationRepository _authenticationRepository =
    AuthenticationRepository();
final OrdersRepository _ordersRepository = OrdersRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  GetIt.instance
    ..registerSingleton<NetworkBloc>(NetworkBloc())
    ..registerSingleton<AuthenticationBloc>(
        AuthenticationBloc(authenticationRepository: _authenticationRepository))
    // ..registerFactory(() => Dio())
    ..registerSingleton<OrdersBloc>(OrdersBloc(_ordersRepository))
    ..registerSingleton<HtttpSerivceOrders>(HtttpSerivceOrders());
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
        BlocProvider<NetworkBloc>(
          create: (context) => networkBloc..add(ListenConnection()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authBloc,
        ),
        BlocProvider<OrdersBloc>(
          create: (context) => ordersBloc,
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: SplashScreenView(
            duration: 2500,
            imageSize: 130,
            imageSrc: 'assets/images/logo.png',
            backgroundColor: Color(0xffF1F1F1),
            navigateRoute: LoginPage(),
          ),
          routes: <String, Widget Function(BuildContext)>{
            PageRoutes.allOrders: (BuildContext context) =>
                const AllOrdersPage()
          },
        ),
      ),
    );
  }
}
