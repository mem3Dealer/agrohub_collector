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
import 'package:intl/intl.dart';

class CollectingOrderPage extends StatefulWidget {
  // Product order; TODO это нужно сделать через блок с полем Product collecting;
  Order order;

  static const String routeName = '/collectingOrder';
  CollectingOrderPage(this.order, {Key? key}) : super(key: key);

  @override
  State<CollectingOrderPage> createState() => _CollectingOrderPageState();
}

class _CollectingOrderPageState extends State<CollectingOrderPage> {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  bool toCollect = true;

  // final String _pageStatus = 'to_collect';
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
    DateFormat format = DateFormat('HH:MM');
    String _time = format.format(widget.order.delivery_time!);
    // print(orderNumber);
    TextStyle _style = const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Color(0xff363B3F),
        fontSize: 18);

    return DefaultTabController(
      length: 2,
      child: MyScaffold(false, true,
          title: "Заказ №${widget.order.agregator_order_id}",
          deliveryTime: _time,
          body: BlocBuilder<OrdersBloc, OrdersState>(
              bloc: ordersBloc,
              builder: (context, state) {
                int totalCollected = 0;
                int totalToCollect = 0;

                if (state.listOfProducts != null &&
                    state.listOfProducts?.isNotEmpty == true) {
                  for (Product p in state.listOfProducts!) {
                    if (p.status == 'to_collect') {
                      totalToCollect++;
                    } else if (p.status == 'collected') {
                      totalCollected++;
                    }
                  }
                  return SizedBox(
                    height: 10000,
                    child: Column(
                      children: [
                        TabBar(
                            labelColor: const Color(0xff363B3F),
                            labelStyle:
                                _style.copyWith(fontWeight: FontWeight.w500),
                            indicatorColor: const Color(0xffE14D43),
                            tabs: [
                              Tab(
                                text: 'Собрать $totalToCollect',
                              ),
                              Tab(
                                text: 'Собрано $totalCollected',
                              )
                            ]),
                        Expanded(
                          child: TabBarView(children: [
                            Container(
                              child: _TabToCollect(
                                state: state,
                                pageStatus: 'to_collect',
                              ),
                            ),
                            Container(
                              child: _TabToCollect(
                                state: state,
                                pageStatus: 'collected',
                              ),
                            ),
                          ]),
                        ),
                        // Expanded(
                        //   child: Container(
                        //       child: _TabToCollect(pageStatus: _pageStatus, state: state,)),
                        // ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xffE14D43),
                  ));
                }
              })),
    );
  }
}

class _TabToCollect extends StatefulWidget {
  OrdersState state;
  _TabToCollect({
    required this.state,
    required String pageStatus,
    Key? key,
  })  : _pageStatus = pageStatus,
        super(key: key);

  final String _pageStatus;

  @override
  State<_TabToCollect> createState() => _TabToCollectState();
}

class _TabToCollectState extends State<_TabToCollect>
    with AutomaticKeepAliveClientMixin {
  @override
  bool wantKeepAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        itemCount: widget.state.listOfProducts!.length,
        itemBuilder: (context, int index) {
          Product product = widget.state.listOfProducts![index];
          // print(product.status);
          // double height = MediaQuery.of(context).size.height / 4;
          if (product.status == widget._pageStatus) {
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
            return
                // index == 0
                //     ? Padding(
                //         padding: EdgeInsets.only(top: height, right: 50, left: 50),
                //         child: const Text(
                //           'Было бы замечательно если работа выполнялась сама собой.\nНо чтобы здесь что-то появилось, надо что-то собрать',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontFamily: 'Roboto',
                //               fontWeight: FontWeight.w400,
                //               color: Color(0xff363B3F),
                //               fontSize: 15),
                //         ),
                //       )
                //     :

                Container();
          }
        });
  }
}

class ButtonsPanel extends StatelessWidget {
  final int totalToCollect;
  final int totalCollected;
  String pageStatus;

  ButtonsPanel({
    required this.pageStatus,
    required this.totalCollected,
    required this.totalToCollect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //КНОПКИ
        children: [
          Button(
            onTap: () {
              print('yas');
              pageStatus = 'to_collect';
            },
            text: 'Собрать $totalToCollect',
          ),
          Button(
            onTap: () {
              print('nah');
              pageStatus = 'collected';
            },
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
    required VoidCallback onTap,
    required String text,
  })  : _onTap = onTap,
        _text = text,
        super(key: key);

  final double _buttonHeight = 54.6;
  final double _buttonWidth = 122;
  final VoidCallback _onTap;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
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
