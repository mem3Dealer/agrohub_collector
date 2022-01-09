import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:agrohub_collector_flutter/components/uncollected_order_product_list.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class CollectedOrderProductList extends StatelessWidget {
  const CollectedOrderProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = context.read<CollectingListsBloc>().collectedListOrder;

    return BlocBuilder<CollectingListsBloc, CollectingListsState>(
        builder: (context, state) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return const ProductTiles(
                title: orange,
                weight: weight,
              );
            },
          ),
        ),
      );
    });
  }
}
