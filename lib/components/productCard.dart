import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
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
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  final _controller = TextEditingController();

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
    return InkWell(
      onTap: () => _expandCard(),
      child: Container(
          width: 382,
          height: _isCollapsed ? 164 : 400,
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
                                    child: Icon(Icons.arrow_forward_ios_sharp),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            //'удалить'
                            Button(
                              product: widget.product,
                              // changeStatus: () {
                              //   print('does it?');
                              //   changeStatus(widget.product, 'deleted');
                              // },
                              style: _style,
                              color: const Color(0xffE14D43),
                              text: 'Удалить',
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Button(
                              product: widget.product,
                              // changeStatus: () =>
                              //     changeStatus(widget.product, 'collected'),

                              // changeStatus(widget.product, 'collected'),
                              style: _style,
                              color: const Color(0xff69A8BB),
                              text: 'Собрать',
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
        child: TextField(
          // textAlignVertical:
          //     TextAlignVertical.top,
          style: _style,
          // autofocus: true,
          maxLines: 1,
          // maxLength: 5,
          controller: _controller,
          keyboardType: TextInputType.number,
          cursorHeight: 30,
          decoration: InputDecoration(
              hintStyle: _style.copyWith(color: Color(0xff999999)),
              hintText: 'Введите', //TODO КРИВО!
              border: InputBorder.none),
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

class Button extends StatelessWidget {
  Color color;
  String text;
  TextStyle style;
  Product product;
  Button({
    required this.product,
    required this.color,
    required this.text,
    required this.style,
    Key? key,
  }) : super(key: key);
  final ordersBloc = GetIt.I.get<OrdersBloc>();
  // final TextStyle _style;
  changeStatus(Product product, String newStatus) {
    ordersBloc.add(ChangeProductStatus(product: product, newStatus: newStatus));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (text == 'Собрать') {
            changeStatus(product, 'collected');
          } else if (text == 'Удалить') {
            changeStatus(product, 'deleted');
          }
        },
        child: Container(
          // width: 182,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: color),
          child: Center(
            child: Text(
              text,
              style: style.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
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
