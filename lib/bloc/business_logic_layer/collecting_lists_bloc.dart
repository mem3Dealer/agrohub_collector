import 'package:agrohub_collector_flutter/components/uncollected_order_product_list.dart';
import 'package:agrohub_collector_flutter/cont/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collecting_lists_event.dart';
part 'collecting_lists_state.dart';

class CollectingListsBloc
    extends Bloc<CollectingListsEvent, CollectingListsState> {
  //пока пользуемся готовым листом
  final List<ExpandableProductTiles> uncollectedListOrder = [
    const ExpandableProductTiles(),
    const ExpandableProductTiles(),
    const ExpandableProductTiles(),
    const ExpandableProductTiles(),
  ];
  final List<ExpandableProductTiles> collectedListOrder = [];

  CollectingListsBloc() : super(UnCollectingListState()) {
    on<CollectingListPressed>((event, emit) => emit(CollectingListState()));
    on<UnCollectingListPressed>((event, emit) => emit(UnCollectingListState()));
    on<ProductCollectingPressed>((_movingItems));
  }

  void _movingItems(
      ProductCollectingPressed event, Emitter<CollectingListsState> state) {
    removeItemFromUncollectedList(event.item);
    addItemToNewCollectedList(event.item);
  }

  void addItemToNewCollectedList(ExpandableProductTiles item) =>
      collectedListOrder.add(item);

  void removeItemFromUncollectedList(ExpandableProductTiles item) =>
      uncollectedListOrder.remove(item);
}
