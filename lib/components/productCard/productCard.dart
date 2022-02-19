import 'dart:async';
import 'package:agrohub_collector_flutter/shared/myWidgets.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'imagePlacer.dart';
import 'productName.dart';
import 'priceRow.dart';
import 'button.dart';

class AnotherProductCard extends StatefulWidget {
  Product product;
  AnotherProductCard({required this.product, Key? key}) : super(key: key);
  @override
  AnotherProductCardState createState() => AnotherProductCardState();
}

class AnotherProductCardState extends State<AnotherProductCard> {
  bool _isCollapsed = true;
  bool isActive = false;
  bool isOnDelete = false;
  int _start = 5;
  Timer? t;
  final formKey = GlobalKey<FormState>();
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.product.status == 'collected'
          ? '${widget.product.collected_quantity}'
          : '',
    );

    _controller.addListener(() {
      double? input = double.tryParse(_controller.text);
      final _isActive = _controller.text.isNotEmpty;

      setState(() {
        if (input != 0.0) {
          this.isActive = _isActive;
        } else {
          this.isActive = false;
        }
      });
      if (_controller.text.startsWith(RegExp(r'[.,]'))) {
        _controller.text = '0.';
        _controller.selection = TextSelection.collapsed(offset: 2);
      }
      if (_controller.text.contains(',')) {
        _controller.text = _controller.text.replaceAll(RegExp('[,]'), '.');
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _expandCard() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  bool get mounted => super.mounted;

  final TextStyle _style = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      color: Color(0xff363B3F),
      fontSize: 18);

  void setDeleteState() async {
    setState(() {
      isOnDelete = true;
      _isCollapsed = true;
    });
    ordersBloc.emit(ordersBloc.state.copyWith(isProdOnDelete: true));
    t = Timer(Duration(seconds: 5), () {
      ordersBloc.add(ChangeProductStatus(0.1,
          product: widget.product, newStatus: 'deleted'));
    });
  }

  Stream<int> kindaTimer() async* {
    const oneSec = const Duration(seconds: 1);
    for (int i = 4; i >= 0; i--) {
      await Future.delayed(oneSec);
      yield i;
      if (i == 0) {
        t?.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isItCollected = widget.product.status == 'collected';
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AbsorbPointer(
            absorbing: isOnDelete,
            child: Container(
                foregroundDecoration: isOnDelete
                    ? BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.7),
                        // backgroundBlendMode: BlendMode.color,
                      )
                    : null,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: ExpansionTileCard(
                  finalPadding: EdgeInsets.zero,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 6),
                        child: ImagePlacer(
                          url: widget.product.image!,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductName(widget: widget, style: _style),
                          OrderedWeight(),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: const Divider(
                            // height: 2,
                            thickness: 1.5,
                            color: Color(0xff69A8BB),
                          ),
                        ),
                        // ЦЕНА ------ ЦЕНА
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: PriceRow(style: _style, widget: widget),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Товара собрано',
                              style: _style.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        //ПОЛЕ ВВОДА
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          child: _TextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MyButton(
                                  //  / isActive: isActive,
                                  product: widget.product,
                                  onDelete: () {
                                    setDeleteState();
                                    MyWidgets.buildSnackBarOnDelete(
                                        stream: kindaTimer(),
                                        context: context,
                                        current: _start,
                                        style: _style,
                                        func: () {
                                          ordersBloc.emit(ordersBloc.state
                                              .copyWith(isProdOnDelete: false));
                                          mounted
                                              ? setState(() {
                                                  isOnDelete = false;
                                                  t?.cancel();
                                                  _isCollapsed = true;
                                                })
                                              : null;
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        });
                                  },
                                  style: _style.copyWith(color: Colors.white),
                                  color: const Color(0xffE14D43),
                                  text: 'Удалить',
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: 170,
                                height: 56,
                                child: MyButton(
                                  controller: _controller,
                                  collectedQuantity:
                                      double.tryParse(_controller.text),
                                  isActive: isItCollected ? true : isActive,
                                  product: widget.product,
                                  style: !isItCollected
                                      ? _style.copyWith(
                                          color: isActive
                                              ? Colors.white
                                              : Color(0xffA9C7D0))
                                      : _style.copyWith(color: Colors.white),
                                  color: isActive || isItCollected
                                      ? const Color(0xff69A8BB)
                                      : const Color(0xffE1EBEE),
                                  text: widget.product.status == 'collecting'
                                      ? 'Собрать'
                                      : 'Вернуть в Собрать',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Container _TextField() {
    bool _isCollected = widget.product.status == 'collected';
    return Container(
        // width: 350,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xffCACED0),
            )),
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d*')),
          ],
          key: formKey,
          onEditingComplete: _isCollected ? () => _expandCard() : null,
          onChanged: _isCollected
              ? (text) {
                  double? _cQ = double.tryParse(text);
                  if (text.isNotEmpty && _cQ != 0.0) {
                    widget.product.collected_quantity = _cQ;
                  }
                }
              : null,
          style: _isCollected
              ? _style.copyWith(
                  fontWeight: FontWeight.w900, color: Colors.green)
              : _style,
          autofocus: true,
          maxLines: 1,
          maxLength: 6,
          controller: _controller,
          keyboardType: TextInputType.number,
          // cursorHeight: 30,

          decoration: InputDecoration(
              counter: const SizedBox.shrink(),
              suffixText:
                  widget.product.product_type == 'per_kilo' ? 'кг' : 'шт',
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 9),
              hintStyle: _style.copyWith(color: Color(0xff999999)),
              hintText: 'Введите',
              border: InputBorder.none),
        ));
  }

  Container OrderedWeight() {
    bool _isCollected = widget.product.status == 'collected';
    double _collectedQuantity = widget.product.collected_quantity ?? 0.0;
    double _orderedQuantity = widget.product.ordered_quantity!;

    RichText _richText = RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$_collectedQuantity ',
          style: _style.copyWith(
              fontWeight: FontWeight.w900, color: Colors.green)),
      TextSpan(
          text: widget.product.product_type == 'per_kilo'
              ? '/ $_orderedQuantity кг'
              : '/ $_orderedQuantity шт',
          style: _style.copyWith(fontWeight: FontWeight.w900))
    ]));

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: _isCollected
          ? _richText
          : Text(
              widget.product.product_type == 'per_kilo'
                  ? '$_orderedQuantity кг'
                  : '$_orderedQuantity шт',
              // : '$_orderedQuantity шт',
              // state
              //   .listOfProducts!.first.ordered_quantity
              //   .toString(),
              style: _style.copyWith(fontWeight: FontWeight.w900),
            ),
    );
  }
}
