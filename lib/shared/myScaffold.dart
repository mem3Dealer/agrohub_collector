import 'package:agrohub_collector_flutter/pages/orderInfo.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  Widget body;
  String title;
  bool isItInfo, isCollecting;

  String? deliveryTime;
  MyScaffold(this.isItInfo, this.isCollecting,
      {required this.title, required this.body, this.deliveryTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // deliveryTime = '12:00-15:00';

    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HeadColumn(
            deliveryTime: deliveryTime,
            isItInfo: isItInfo,
            title: title,
            isCollecting: isCollecting,
          ),
          Expanded(child: body)
        ],
      ),
    );
  }
}

class HeadColumn extends StatelessWidget {
  const HeadColumn({
    Key? key,
    required this.deliveryTime,
    required this.isItInfo,
    required this.isCollecting,
    required this.title,
  }) : super(key: key);

  final String? deliveryTime;
  final bool isItInfo;
  final bool isCollecting;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(deliveryTime: deliveryTime, isItInfo: isItInfo, title: title),
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
                      fontSize: 21,
                      color: Color(0xffE14D43)),
                ),
              ),
            ],
          ),
        // isCollecting == true ?  ButtonsPanel() : const SizedBox.shrink(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.deliveryTime,
    required this.isItInfo,
    required this.title,
  }) : super(key: key);

  final String? deliveryTime;
  final bool isItInfo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: deliveryTime == null
          ? const EdgeInsets.fromLTRB(16, 64, 40, 0)
          : const EdgeInsets.fromLTRB(16, 64, 16, 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
            textAlign: TextAlign.left,
            softWrap: true,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 30),
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
    );
  }
}
