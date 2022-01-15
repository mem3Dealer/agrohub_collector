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
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      builder: (context, state) {
        ordRep.getThisOrder(order.id!);
        // print('{ORDER FROM FINISH: ${state.currentOrder}}');
        return MyScaffold(false, false,
            title: '',
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 38, right: 37, bottom: 40),
                  child: Text(
                    'Отлично, заказ №${order.agregator_order_id} собран!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 40),
                  ),
                ),
                Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/done.png')),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(75, 0, 75, 56),
                  child: Container(
                    width: 265,
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
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                )
              ],
            ));
      },
    );
  }
}
