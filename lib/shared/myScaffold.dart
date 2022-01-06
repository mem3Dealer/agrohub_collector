import 'package:agrohub_collector_flutter/pages/orderInfo.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  Widget body;
  String title;
  bool isItInfo;
  String? deliveryTime;
  MyScaffold(this.isItInfo,
      {required this.title, required this.body, this.deliveryTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // deliveryTime = '12:00-15:00';

    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: Column(
        children: [
          Padding(
            padding: deliveryTime == null
                ? const EdgeInsets.fromLTRB(16, 64, 40, 0)
                : const EdgeInsets.fromLTRB(16, 64, 16, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isItInfo == true)
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined)),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 40),
                ),
                deliveryTime == null
                    ? Container()
                    : IconButton(
                        iconSize: 35,
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  OrderInfoPage(deliveryTime!, title),
                            ),
                          );
                        },
                        icon: const Icon(Icons.info_outline))
              ],
            ),
          ),
          if (deliveryTime != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    deliveryTime!,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Color(0xffE14D43)),
                  ),
                ),
              ],
            ),
          body
        ],
      ),
    );
  }
}
