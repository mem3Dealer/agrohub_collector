import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/components/productCard.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CollectingOrderPage extends StatefulWidget {
  // Product order; TODO это нужно сделать через блок с полем Product collecting;
  int agregatorOrderId;
  String deliveryTime;

  static const String routeName = '/collectingOrder';
  CollectingOrderPage(this.agregatorOrderId, this.deliveryTime, {Key? key})
      : super(key: key);

  @override
  State<CollectingOrderPage> createState() => _CollectingOrderPageState();
}

class _CollectingOrderPageState extends State<CollectingOrderPage> {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  bool toCollect = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ordersBloc.emit(ordersBloc.state.copyWith(listOfProducts: []));
    super.dispose();
  }

  void _switcher() {
    setState(() {
      toCollect = !toCollect;
    });
    print('hehe');
  }

  @override
  Widget build(BuildContext context) {
    // print(orderNumber);
    TextStyle _style = const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Color(0xff363B3F),
        fontSize: 18);

    return MyScaffold(false, true,
        title: "Заказ №${widget.agregatorOrderId}",
        deliveryTime: widget.deliveryTime,
        body: BlocBuilder<OrdersBloc, OrdersState>(
            bloc: ordersBloc,
            builder: (context, state) {
              int totalCollected = 0;
              int totalToCollect = 0;

              for (Product p in state.listOfProducts!) {
                if (p.status == 'to_collect') {
                  totalToCollect++;
                } else if (p.status == 'collected') {
                  totalCollected++;
                }
              }

              return Column(
                children: [
                  ButtonsPanel(
                      switcher: _switcher,
                      totalCollected: totalCollected,
                      totalToCollect: totalToCollect),
                  Expanded(
                    child: Container(
                      child: state.listOfProducts != null &&
                              state.listOfProducts?.isNotEmpty == true
                          ? ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              itemCount: state.listOfProducts!.length,
                              itemBuilder: (context, int index) {
                                Product product = state.listOfProducts![index];
                                // print(product.status);
                                if (product.status == 'to_collect') {
                                  return Column(
                                    children: [
                                      ProductCard(
                                        product: product,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              })
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              );
            }));
  }
}

class ButtonsPanel extends StatelessWidget {
  final int totalToCollect;
  final int totalCollected;
  final Function switcher;

  const ButtonsPanel({
    required this.switcher,
    required this.totalCollected,
    required this.totalToCollect,
    Key? key,
  }) : super(key: key);

  final double _buttonHeight = 82.0;
  final double _buttonWidth = 183.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //КНОПКИ
        children: [
          Button(
            onTap: switcher,
            text: 'Собрать $totalToCollect',
          ),
          Button(
            onTap: switcher,
            text: 'Собрано $totalCollected',
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required Function onTap,
    required String text,
  })  : _onTap = onTap,
        _text = text,
        super(key: key);

  final double _buttonHeight = 54.6;
  final double _buttonWidth = 122;
  final Function _onTap;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTap;
      },
      child: Container(
        height: _buttonHeight,
        width: _buttonWidth,
        child: Center(
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xff69A8BB), width: 1),
          color: const Color(0xffE7F1F4),
        ),
      ),
    );
  }
}
