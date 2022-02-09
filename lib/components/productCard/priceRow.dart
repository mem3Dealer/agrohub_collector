import 'package:agrohub_collector_flutter/components/productCard/productCard.dart';
import 'package:flutter/material.dart';

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
