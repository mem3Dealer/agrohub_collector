import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/components/productCard.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ordersBloc.emit(ordersBloc.state.copyWith(listOfProducts: []));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _buttonHeight = 82.0;
    double _buttonWidth = 183.0;

    // print(orderNumber);
    TextStyle _style = const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Color(0xff363B3F),
        fontSize: 18);

    return MyScaffold(false,
        title: "Заказ №${widget.agregatorOrderId}",
        deliveryTime: widget.deliveryTime,
        body: BlocBuilder<OrdersBloc, OrdersState>(
            bloc: ordersBloc,
            builder: (context, state) {
              return Center(
                child: state.listOfProducts != null &&
                        state.listOfProducts?.isNotEmpty == true
                    ? Column(
                        children: <Widget>[
                          ButtonsPanel(
                              buttonHeight: _buttonHeight,
                              buttonWidth: _buttonWidth),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.listOfProducts!.length,
                              itemBuilder: (BuildContext context, int index) {
                                Product product = state.listOfProducts![index];
                                return ProductCard(
                                    imageUrl: product.image!,
                                    name: product.name!,
                                    orderedWeight:
                                        product.ordered_quantity.toString(),
                                    totalPrice: product.total_price.toString());
                              })
                        ],
                      )
                    : const CircularProgressIndicator(),
              );
            }));
  }
}

showToCollect() {}
showCollected() {}

class ButtonsPanel extends StatelessWidget {
  const ButtonsPanel({
    Key? key,
    required double buttonHeight,
    required double buttonWidth,
  })  : _buttonHeight = buttonHeight,
        _buttonWidth = buttonWidth,
        super(key: key);

  final double _buttonHeight;
  final double _buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //КНОПКИ
        children: [
          Button(
            buttonHeight: _buttonHeight,
            buttonWidth: _buttonWidth,
            onTap: () {},
            text: 'Собрать\n(10)',
          ),
          Button(
            buttonHeight: _buttonHeight,
            buttonWidth: _buttonWidth,
            onTap: () {},
            text: 'Собрано\n(0)',
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required double buttonHeight,
    required double buttonWidth,
    required Function onTap,
    required String text,
  })  : _buttonHeight = buttonHeight,
        _buttonWidth = buttonWidth,
        _onTap = onTap,
        _text = text,
        super(key: key);

  final double _buttonHeight;
  final double _buttonWidth;
  final Function _onTap;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap,
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
                fontSize: 18),
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
