import 'package:agrohub_collector_flutter/components/productCard/productCard.dart';
import 'package:flutter/material.dart';

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
