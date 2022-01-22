import 'dart:async';
import 'dart:developer';

import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final formKey = GlobalKey<FormState>();

  final ordersBloc = GetIt.I.get<OrdersBloc>();
  late var _controller = TextEditingController();
  late Timer t;

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

  void setDeleteState() {
    Duration _duration = const Duration(seconds: 5);
    setState(() {
      isOnDelete = true;
      _isCollapsed = true;
      t = Timer(_duration, () {
        ordersBloc.add(ChangeProductStatus(0.1,
            product: widget.product, newStatus: 'deleted'));
      });

      SnackBar _snackBarOnDelete = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: _duration,
          width: 360,
          backgroundColor: Color(0xffFAE2E1),
          content: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Товар будет удален через 5 сек',
                  style: _style.copyWith(
                      fontWeight: FontWeight.w300, fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      mounted == true
                          ? setState(() {
                              isOnDelete = false;
                              t.cancel();
                              _isCollapsed = true;
                            })
                          : null;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Text('Отменить',
                        style: _style.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16)))
              ],
            ),
          ));
      ScaffoldMessenger.of(context).showSnackBar(_snackBarOnDelete);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isItCollected = widget.product.status == 'collected';
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return InkWell(
          onTap: isOnDelete
              ? null
              : () {
                  _expandCard();
                },
          child: Container(
              width: 382,
              height: _isCollapsed ? 164 : 400,
              foregroundDecoration: isOnDelete
                  ? BoxDecoration(
                      color: Colors.grey.shade400.withOpacity(0.7),
                      // backgroundBlendMode: BlendMode.color,
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
                        ImagePlacer(
                          url: widget.product.image!,
                        ),
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
                                    ? const Icon(Icons.arrow_forward_ios_sharp)
                                    : const RotatedBox(
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
                                    product: widget.product,
                                    onDelete: setDeleteState,
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
                                    controller: _controller,
                                    collectedQuantity:
                                        double.tryParse(_controller.text),
                                    isActive: isItCollected ? true : isActive,
                                    product: widget.product,
                                    style: _style,
                                    // &&
                                    //             double.tryParse(
                                    //                     _controller.text) ==
                                    //                 0.0
                                    color:
                                        isActive || //TODO не работает ничерта! я про невидимость кнопки когда введен ноль
                                                isItCollected
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
              )),
        );
      },
    );
  }

  Container _TextField() {
    bool _isCollected = widget.product.status == 'collected';
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
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            key: formKey,
            // initialValue:
            // textAlignVertical:
            //     TextAlignVertical.top,
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
                // errorText: 'Поле не может быть пустым',
                suffixIconConstraints: BoxConstraints.tightForFinite(),
                // suffixIcon: _controller.text.isNotEmpty
                //     ? IconButton(
                //         iconSize: 10,
                //         padding: EdgeInsets.zero,
                //         icon: const Icon(
                //           Icons.clear_sharp,
                //           color: Color(0xffE14D43),
                //         ),
                //         onPressed: () => _controller.clear(),
                //       )
                //     : null,
                suffixText:
                    widget.product.product_type == 'per_kilo' ? 'кг.' : 'шт',
                contentPadding: const EdgeInsets.only(left: 12, top: 10),
                hintStyle: _style.copyWith(color: Color(0xff999999)),
                hintText: 'Введите',
                border: InputBorder.none),
          ),
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
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
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

class MyButton extends StatefulWidget {
  Color? color;
  String text;
  TextStyle style;
  Product product;
  bool? isActive;
  VoidCallback? onDelete;
  double? collectedQuantity;
  TextEditingController? controller;
  MyButton({
    this.controller,
    this.onDelete,
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
  void changeStatus(Product product, String newStatus) async {
    ordersBloc.add(ChangeProductStatus(widget.collectedQuantity ?? 0.0,
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
                  // changeStatus(widget.product, 'deleted');
                  widget.onDelete!();
                } else if (widget.text == 'Вернуть в Собрать') {
                  changeStatus(widget.product, 'to_collect');
                } else if (widget.text == 'Собрать') {
                  changeStatus(widget.product, 'collected');
                  widget.controller!.clear();
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
          widget.product.product_type == 'per_kilo'
              ? '${widget.product.unit_price} руб./кг'
              : '${widget.product.unit_price} руб./шт',
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
        widget.product.name ?? 'noname',
        maxLines: 4,
        overflow: TextOverflow.visible,
        style: _style,
      ),
    );
  }
}

class ImagePlacer extends StatefulWidget {
  String url;
  ImagePlacer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<ImagePlacer> createState() => _ImagePlacerState();
}

class _ImagePlacerState extends State<ImagePlacer> {
  @override
  Widget build(BuildContext context) {
    //однажды я это решу :)
// проблема была в том, что он выкидывал ошибку битой ссылки (badUrl) в моменты когда я нажимал на кнопку
// чтобы перейти на экран инфы. В общем - так работает.
    String badUrl = 'https://storage.yandexcloud.net/goods-images/media/';
    String _ph =
        'https://www.fwhealth.org/wp-content/uploads/2017/03/placeholder-500x500.jpg';
    Image image = Image.network(
      widget.url == badUrl ? _ph : widget.url,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: const Color(0xffE14D43),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        inspect(error);
        return Image.asset('assets/images/placeholder.jpg');
      },
    );

    // FadeInImage image = FadeInImage.assetNetwork(
    //   placeholder: 'assets/images/placeholder.jpg',
    //   image: widget.url,
    //   imageErrorBuilder: (context, object, stackTrace) {
    //     return Image.asset('assets/images/placeholder.jpg');
    //   },

    // );

    return SizedBox(height: 132, width: 132, child: image);
  }
}
