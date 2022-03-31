import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/auth/auth_events.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/pages/loginPage.dart';
import 'package:agrohub_collector_flutter/pages/orderInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyScaffold extends StatelessWidget {
  Widget body;
  String title;
  bool isItInfo, isCollecting;
  Widget? fab;

  String? deliveryTime;
  MyScaffold(this.isItInfo, this.isCollecting,
      {required this.title,
      required this.body,
      this.deliveryTime,
      this.fab,
      Key? key})
      : super(key: key);

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final authBloc = GetIt.I.get<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    // deliveryTime = '12:00-15:00';
    final _theme = Theme.of(context);
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          floatingActionButton: fab,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actions: <Widget>[
              !isCollecting && !isItInfo
                  ? IconButton(
                      iconSize: 30,
                      color: Colors.red,
                      onPressed: () {
                        authBloc.add(AuthenticationLogout(
                            onSuccess: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const LoginPage(),
                                  ),
                                )));
                      },
                      icon: Icon(Icons.logout))
                  : SizedBox.shrink(),
              isCollecting
                  ? BlocBuilder<OrdersBloc, OrdersState>(
                      bloc: ordersBloc,
                      builder: (context, state) {
                        return Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  ordersBloc
                                      .add(QuitCollecting(context: context));
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                            Visibility(
                              visible: state.listOfProducts != null
                                  ? state.listOfProducts!.isNotEmpty
                                      ? true
                                      : false
                                  : false,
                              child: IconButton(
                                  color: Color(0xff363B3F),
                                  iconSize: 35,
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            OrderInfoPage(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.info_outline)),
                            ),
                          ],
                        );
                      },
                    )
                  : SizedBox.shrink()
            ],
            leadingWidth: isItInfo ? 30 : 0,
            titleSpacing: 0,
            toolbarHeight: 64,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                textAlign: TextAlign.left,
                style: _theme.textTheme.headlineLarge,
              ),
            ),
            bottom: isCollecting
                ? PreferredSize(
                    preferredSize: Size.fromHeight(56),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Время доставки:',
                            style: TextStyle(
                              color: Color(0xff363B3F),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            deliveryTime!,
                            style: TextStyle(
                              color: Color(0xffE14D43),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : PreferredSize(
                    child: SizedBox.shrink(),
                    preferredSize: Size.fromHeight(0)),
          ),
          body: body),
    );
  }
}
