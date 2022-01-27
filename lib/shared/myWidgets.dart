import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        // () {

        //   // Future.delayed(const Duration(seconds: 3), () {
        //   //   // Navigator.pop(context);
        //   //   // print('ahoi');
        //   // });
        // },
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: secs),
        width: 360,
        backgroundColor: const Color(0xffFAE2E1),
        content: SizedBox(
          height: 50,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(content,
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
                      child: const Text('¯\_(ツ)_/¯',
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
}
