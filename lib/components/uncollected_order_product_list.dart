import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class ExpandableProductTiles extends StatelessWidget {
  const ExpandableProductTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = context.read<CollectingListsBloc>().uncollectedListOrder;

    return BlocBuilder<CollectingListsBloc, CollectingListsState>(
        builder: (context, state) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpandablePanel(
                theme: const ExpandableThemeData(
                  hasIcon: false,
                ),
                collapsed: Container(),
                expanded: Column(
                  children: [
                    const Divider(
                      color: Colors.blue,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('widget.stringPrice'),
                        Text('{widget.price} р/кг')
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      child: Text(
                        'Товара собрано',
                      ),
                      alignment: Alignment.bottomLeft,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CollectingListsBloc>().add(
                            ProductCollectingPressed(context
                                .read<CollectingListsBloc>()
                                .uncollectedListOrder[index]));
                      },
                      child: const Text('Собрать'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                header: const ProductTiles(
                  title: orange,
                  weight: weight,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class ProductTiles extends StatelessWidget {
  const ProductTiles({Key? key, required this.title, required this.weight})
      : super(key: key);
  final String title;
  final double weight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          const Placeholder(
            fallbackHeight: 150.0,
            fallbackWidth: 150.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 40.0,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '$weight кг',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
