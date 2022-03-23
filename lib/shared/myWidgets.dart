import 'dart:async';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyWidgets {
  static buildSnackBar(
      {required BuildContext context,
      required String content,
      required int secs,
      required bool button,
      Function? onVisible,
      TextButton? textButton}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        onVisible: () => onVisible,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: secs),
        width: MediaQuery.of(context).size.width - 30,
        backgroundColor: const Color(0xffFAE2E1),
        content: SizedBox(
          height: 50,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(content,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff363B3F),
                      fontSize: 16)),
              button
                  ? TextButton(
                      onPressed: () {
                        // Navigator.popAndPushNamed(context, '/allOrders');
                      },
                      child: const Text('¯\\_(ツ)_/¯',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff363B3F),
                              fontSize: 18)))
                  : SizedBox.shrink()
            ],
          ),
        )));
  }

  static buildSnackBarOnDelete({
    required BuildContext context,
    required Stream<int> stream,
    required int current,
    required TextStyle style,
    required Function func,
  }) {
    final ordersBloc = GetIt.I.get<OrdersBloc>();
    Duration _duration = Duration(seconds: 5);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: _duration,
            width: 360,
            backgroundColor: Color(0xffFAE2E1),
            content: SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'Товар будет удален через 5 сек',
                          style: style.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16),
                        );
                      }
                      return Text(
                        'Товар будет удален через ${snapshot.data} сек',
                        style: style.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      );
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        func();
                      },
                      child: Text('Отменить',
                          style: style.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 16)))
                ],
              ),
            )))
        .closed
        .then((value) =>
            ordersBloc.emit(ordersBloc.state.copyWith(isProdOnDelete: false)));
  }
}
