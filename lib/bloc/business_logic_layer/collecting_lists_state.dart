part of 'collecting_lists_bloc.dart';

@immutable
abstract class CollectingListsState {}

class CollectingListState extends CollectingListsState {}

class UnCollectingListState extends CollectingListsState {}

class MovingListsState extends CollectingListsState {
  MovingListsState(this.item);
  final ExpandableProductTiles item;
}
