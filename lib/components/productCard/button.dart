import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_bloc.dart';
import 'package:agrohub_collector_flutter/bloc/bloc/orders/orders_event.dart';
import 'package:agrohub_collector_flutter/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
              setState(() {
                if (widget.text == 'Удалить') {
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
