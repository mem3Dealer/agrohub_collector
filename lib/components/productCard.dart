import 'dart:async';
import 'dart:developer';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_state.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AnotherProductCard extends StatefulWidget {
  // String imageUrl, name, totalPrice, orderedWeight;
  Product product;

  AnotherProductCard({required this.product, Key? key}) : super(key: key);

  @override
  AnotherProductCardState createState() => AnotherProductCardState();
}

class AnotherProductCardState extends State<AnotherProductCard> {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Товара собрано',
                            style: _style.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        //ПОЛЕ ВВОДА
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16, bottom: 16),
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
                                  onDelete: setDeleteState,
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
                                  style: _style.copyWith(
                                      color: isActive
                                          ? Colors.white
                                          : Color(0xffA9C7D0)),
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
        width: 350,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xffCACED0),
            )),
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
              // suffixIconConstraints: BoxConstraints.tightForFinite(),
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
                  changeStatus(widget.product, 'collecting');
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
          child: Text(widget.text,
              textAlign: TextAlign.center, style: widget.style),
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
  final AnotherProductCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Цена:',
          style: _style.copyWith(fontSize: 16),
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

  final AnotherProductCard widget;
  final TextStyle _style;

  @override
  Widget build(BuildContext context) {
    double _wdt = MediaQuery.of(context).size.width;
    double _textW;
    if (_wdt > 360) {
      _textW = 150;
    } else {
      _textW = 110;
    }
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      height: 96,
      width: _textW,
      child: Text(
        widget.product.name ?? 'noname',
        softWrap: true,
        maxLines: 4,
        overflow: TextOverflow.fade,
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
    double _wdt = MediaQuery.of(context).size.width;
    double _picW;
    if (_wdt > 350) {
      _picW = 132;
    } else {
      _picW = 100;
    }
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
    return Container(width: _picW, height: _picW, child: image);
  }
}
