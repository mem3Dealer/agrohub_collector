import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/components/productCard/productCard.dart';
import 'package:agrohub_collector_flutter/model/order.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:agrohub_collector_flutter/pages/allOrdersPage.dart';
import 'package:agrohub_collector_flutter/pages/completedCollectionPage.dart';
import 'package:agrohub_collector_flutter/repositories/orders_rep.dart';
import 'package:agrohub_collector_flutter/shared/myScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class CollectingOrderPage extends StatefulWidget {
  Order order;
  static const String routeName = '/collectingOrder';
  CollectingOrderPage(this.order, {Key? key}) : super(key: key);

  @override
  State<CollectingOrderPage> createState() => _CollectingOrderPageState();
}

class _CollectingOrderPageState extends State<CollectingOrderPage>
    with SingleTickerProviderStateMixin {
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final ordRep = OrdersRepository();
  bool toCollect = true;
  bool isCollected = false;
  late TabController _tabController;

  // final String _pageStatus = 'to_collect';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final TextStyle _style = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      color: Color(0xff363B3F),
      fontSize: 18);

  @override
  void dispose() {
    // ordersBloc.emit(ordersBloc.state.copyWith(listOfProducts: []));
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = true;
    bool _isSnackOn = true;
    DateFormat format = DateFormat('HH:MM');
    String _time = format.format(widget.order.deliveryTime!);

    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 2,
        child: MyScaffold(
          false,
          true,
          title: "Заказ №${widget.order.agregatorOrderId}",
          deliveryTime: _time,
          body: BlocBuilder<OrdersBloc, OrdersState>(
              bloc: ordersBloc,
              builder: (context, state) {
                // print('THIS IS STATE`S FIRST: ${state.listOfProducts!.first}');
                int totalCollected = 0;
                int totalToCollect = 0;
                if (state.loading == false) {
                  if (state.listOfProducts != null) {
                    for (Product p in state.listOfProducts ?? []) {
                      if (p.status == 'collecting') {
                        totalToCollect++;
                      } else if (p.status == 'collected') {
                        totalCollected++;
                      }
                      // print("${p.name}: ${p.collected_quantity}, ${p.status}");
                    }
                  }

                  if (totalToCollect == 0) {
                    _tabController.animateTo(1);
                  } else if (totalCollected == 0) {
                    _tabController.animateTo(0);
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                          controller: _tabController,
                          labelColor: const Color(0xff363B3F),
                          labelStyle:
                              _style.copyWith(fontWeight: FontWeight.w500),
                          indicatorColor: const Color(0xffE14D43),
                          indicatorPadding:
                              EdgeInsets.only(left: 16, right: 16),
                          tabs: [
                            Tab(
                              text: 'Собрать ($totalToCollect)',
                            ),
                            Tab(
                              text: 'Собрано ($totalCollected)',
                            )
                          ]),
                      Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                          Container(
                            child: _TabToCollect(
                              state: state,
                              pageStatus: 'collecting',
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
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffE14D43),
                    ),
                  );
                }
              }),
          fab: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              _isSnackOn = state.isProdOnDelete == false;
            },
            builder: (context, state) {
              showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

              state.listOfProducts?.any((prod) {
                prod.collected_quantity == 0.0
                    ? {isCollected = false}
                    : {isCollected = true};
                return !isCollected;
              });

              // print('this is snack: $_isSnackOn, this is showfab: $showFab');
              return Visibility(
                visible: showFab,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: FloatingActionButton(
                      tooltip: 'Завершить заказ',
                      child: isCollected
                          ? Icon(
                              Icons.check,
                              size: 40,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check,
                              size: 40,
                              color: Color(0xffAACB9C),
                            ),
                      backgroundColor:
                          isCollected ? Color(0xff7FB069) : Color(0xffD6E5CF),
                      onPressed: isCollected
                          ? () {
                              // print(isCollected);
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      CompletedCollectionPage(
                                    order: widget.order,
                                  ),
                                ),
                              );
                            }
                          : null),
                ),
              );
            },
          ),
        ),
      ),
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
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.grey,
                child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: widget.state.listOfProducts!.length,
                    itemBuilder: (context, int index) {
                      Product product = widget.state.listOfProducts![index];
                      if (product.status == widget._pageStatus) {
                        return AnotherProductCard(
                          product: product,
                        );
                      } else {
                        return Container();
                      }
                    })));
      },
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
