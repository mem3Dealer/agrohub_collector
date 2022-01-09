import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:agrohub_collector_flutter/components/collected_order_product_list.dart';
import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:agrohub_collector_flutter/components/uncollected_order_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/order_info_page.dart';

class CollectingOrderPage extends StatelessWidget {
  const CollectingOrderPage(
      {Key? key, required this.number, required this.time})
      : super(key: key);
  static const String routeName = '/collectingOrder';
  final String number;
  final String time;

  //Экран сбора заказа
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Заказ №$number',
                        style: orderTitle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    OrderInfoPage(number, time),
                              ));
                        },
                        child: const Icon(
                          Icons.adjust,
                          color: Colors.red,
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      time,
                      style: orderTime,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButtonSizer(
                    buttonTitle: 'Собрать',
                    onPressed: () {
                      context
                          .read<CollectingListsBloc>()
                          .add(UnCollectingListPressed());
                    },
                    list: context
                        .read<CollectingListsBloc>()
                        .uncollectedListOrder,
                  ),
                  OutlinedButtonSizer(
                    buttonTitle: 'Собрано',
                    onPressed: () {
                      context
                          .read<CollectingListsBloc>()
                          .add(CollectingListPressed());
                      print(context
                          .read<CollectingListsBloc>()
                          .collectedListOrder);
                    },
                    list:
                        context.read<CollectingListsBloc>().collectedListOrder,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<CollectingListsBloc, CollectingListsState>(
                builder: (context, state) => state is CollectingListState
                    ? const CollectedOrderProductList()
                    : const ExpandableProductTiles()),
          ],
        ),
      ),
    );
  }
}

class OutlinedButtonSizer extends StatelessWidget {
  const OutlinedButtonSizer({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
    required this.list,
  }) : super(key: key);
  final String buttonTitle;
  final Function onPressed;
  final List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 173,
      height: 82,
      child: OutlinedButton(
        onPressed: () {
          onPressed.call();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonTitle,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '${list.length}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
