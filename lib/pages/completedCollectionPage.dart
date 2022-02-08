import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedCollectionPage extends StatelessWidget {
  Order order;
  CompletedCollectionPage({required this.order, Key? key}) : super(key: key);
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final ordRep = OrdersRepository();

  void _finishCollecting(BuildContext context) {
    ordersBloc.add(FinishCollecting(context: context));
  }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/images/done.svg';
    final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'Done!');
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        ordRep.getThisOrder(order.id!);
        // print('{ORDER FROM FINISH: ${state.currentOrder}}');
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 148,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38, right: 37),
                  child: Container(
                    child: Text(
                      'Отлично, заказ №${order.agregatorOrderId} собран!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff363B3F),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 32),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 128,
                  width: 128,
                  child: svg,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(75, 0, 75, 56),
                  child: Container(
                    width: 290,
                    height: 56,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff69A8BB))),
                        onPressed: () async {
                          // print(state.currentOrder);
                          _finishCollecting(context);
                        },
                        child: const Text(
                          'Собрать следующий заказ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
