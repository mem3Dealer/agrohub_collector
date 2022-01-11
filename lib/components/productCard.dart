import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductCard extends StatefulWidget {
  // String imageUrl, name, totalPrice, orderedWeight;
  Product product;

  ProductCard(
      {required this.product,
      // required this.name,
      // required this.orderedWeight,
      // required this.totalPrice,
      Key? key})
      : super(key: key);

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  bool _isCollapsed = true;
  bool isActive = false;
  bool isOnDelete = false;

  final ordersBloc = GetIt.I.get<OrdersBloc>();
  late var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.product.status == 'collected'
          ? '${widget.product.collected_quantity}'
          : '',
    );
    _controller.addListener(() {
      final _isActive = _controller.text.isNotEmpty;
      setState(() => this.isActive = _isActive);
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

  final TextStyle _style = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      color: Color(0xff363B3F),
      fontSize: 18);

  @override
  Widget build(BuildContext context) {
    bool isItCollected = widget.product.status == 'collected';
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _expandCard(),
          child: Container(
              width: 382,
              height: _isCollapsed ? 164 : 400,
              foregroundDecoration: isOnDelete
                  ? const BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    )
                  : null,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        //картинка
                        ImagePlacer(widget: widget),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //имя продукта
                            ProductName(widget: widget, style: _style),
                            // Text(isOnDelete.toString()),
                            //общий вес
                            OrderedWeight()
                          ],
                        ), //имя и вес
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                alignment: Alignment.topRight,
                                onPressed: () {},
                                icon: _isCollapsed
                                    ? Icon(Icons.arrow_forward_ios_sharp)
                                    : RotatedBox(
                                        quarterTurns: 1,
                                        child:
                                            Icon(Icons.arrow_forward_ios_sharp),
                                      )),
                          ],
                        )
                      ],
                    ),
                    if (_isCollapsed == false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            // height: 2,
                            thickness: 1.5,
                            color: Color(0xff69A8BB),
                          ),
                          // ЦЕНА ------ ЦЕНА
                          PriceRow(style: _style, widget: widget),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Товара собрано',
                            style: _style.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          //ПОЛЕ ВВОДА
                          _TextField(),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //
                                //'удалить'
                                Expanded(
                                  child: MyButton(
                                    isOnDelete: isOnDelete,
                                    product: widget.product,
                                    // changeStatus: () {
                                    //   print('does it?');
                                    //   changeStatus(widget.product, 'deleted');
                                    // },
                                    style: _style,
                                    color: const Color(0xffE14D43),
                                    text: 'Удалить',
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: MyButton(
                                    collectedQuantity:
                                        double.tryParse(_controller.text),
                                    isActive: isItCollected ? true : isActive,
                                    // controller: _controller,
                                    product: widget.product,
                                    // changeStatus: () =>
                                    //     changeStatus(widget.product, 'collected'),

                                    // changeStatus(widget.product, 'collected'),
                                    style: _style,
                                    color: isActive || isItCollected
                                        ? const Color(0xff69A8BB)
                                        : null,
                                    text: widget.product.status == 'to_collect'
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
                ),
              )
              // ignore: dead_code

              ),
        );
      },
    );
  }

  Container _TextField() {
    return Container(
        width: 350,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xffCACED0),
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: TextFormField(
            // initialValue:
            // textAlignVertical:
            //     TextAlignVertical.top,
            style: _style,
            autofocus: true,
            maxLines: 1,
            // maxLength: 5,
            controller: _controller,
            keyboardType: TextInputType.number,
            // cursorHeight: 30,
            decoration: InputDecoration(
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.clear_sharp,
                          color: Color(0xffE14D43),
                        ),
                        onPressed: () => _controller.clear(),
                      )
                    : null,
                suffixText:
                    widget.product.product_type == 'per_kilo' ? 'кг.' : 'шт',
                // contentPadding: const EdgeInsets.only(left: 12, top: 10),
                hintStyle: _style.copyWith(color: Color(0xff999999)),
                hintText: 'Введите',
                border: InputBorder.none),
          ),
        ));
  }

  Container OrderedWeight() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Text(
        '${widget.product.ordered_quantity} кг',
        // state
        //   .listOfProducts!.first.ordered_quantity
        //   .toString(),
        style: _style.copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  Color? color;
  String text;
  TextStyle style;
  Product product;
  bool? isActive;
  bool? isOnDelete;
  double? collectedQuantity;
  MyButton({
    this.isOnDelete,
    this.collectedQuantity,
    required this.product,
    this.color,
    this.isActive,
    required this.text,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _ButtonState();
}

class _ButtonState extends State<MyButton> {
  num collectedQuantaty = 0.0;
  final ordersBloc = GetIt.I.get<OrdersBloc>();

  // final TextStyle _style;
  changeStatus(Product product, String newStatus) {
    ordersBloc.add(ChangeProductStatus(
        widget.collectedQuantity ?? 0.0, widget.isOnDelete ?? false,
        product: product, newStatus: newStatus));
  }

  @override
  Widget build(BuildContext context) {
    // bool isActive = widget.controller.text.isNotEmpty;
    return ElevatedButton(
      onPressed: widget.isActive ?? true
          ? () {
              // print('WT: ${widget.text}, incoming: ${widget.product.status}');
              setState(() {
                if (widget.text == 'Удалить') {
                  changeStatus(widget.product, 'deleted');
                  widget.isOnDelete = true;
                  print('pressed, ${widget.isOnDelete}');
                } else if (widget.text == 'Вернуть в Собрать') {
                  changeStatus(widget.product, 'to_collect');
                } else if (widget.text == 'Собрать') {
                  changeStatus(widget.product, 'collected');
                }
              });
            }
          : null,
      child: Container(
        // width: 182,
        height: 56,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: widget.style.copyWith(color: Colors.white),
          ),
        ),
      ),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(widget.color)),
    );
  }
}

class PriceRow extends StatelessWidget {
  const PriceRow({
    Key? key,
    required TextStyle style,
    required this.widget,
  })  : _style = style,
        super(key: key);

  final TextStyle _style;
  final ProductCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Цена:',
          style: _style,
        ),
        Text(
          "${widget.product.total_price} руб./кг",
          style: _style.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
        )
      ],
    );
  }
}

class ProductName extends StatelessWidget {
  const ProductName({
    Key? key,
    required this.widget,
    required TextStyle style,
  })  : _style = style,
        super(key: key);

  final ProductCard widget;
  final TextStyle _style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
      height: 96,
      width: 170,
      child: Text(
        widget.product.name!,
        maxLines: 4,
        overflow: TextOverflow.visible,
        style: _style,
      ),
    );
  }
}

class ImagePlacer extends StatelessWidget {
  const ImagePlacer({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ProductCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      width: 132,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(widget.product.image!))),
    );
  }
}
