import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CollectedOrderProductList extends StatelessWidget {
  const CollectedOrderProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: context.read<CollectingListsBloc>().collectedListOrder,
        ),
      ),
    );
  }
}

class CollectedProductTiles extends StatelessWidget {
  const CollectedProductTiles({
    Key? key,
    required this.stringPrice,
    required this.price,
  }) : super(key: key);
  final String stringPrice;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20.0),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
