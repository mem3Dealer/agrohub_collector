import 'package:agrohub_collector_flutter/bloc/data_provider/products_provider.dart';
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
    const ExpandableProductTiles(stringPrice: strPrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strPrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strPrice, price: 113.8),
    const ExpandableProductTiles(stringPrice: strPrice, price: 113.8),
  ];
  final List<ExpandableProductTiles> collectedListOrder = [];

  CollectingListsBloc() : super(UnCollectingListState()) {
    on<CollectingListPressed>((event, emit) {
      emit(CollectingListState());
    });
    on<UnCollectingListPressed>((event, emit) {
      emit(UnCollectingListState());
    });
  }
}
