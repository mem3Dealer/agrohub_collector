part of 'collecting_lists_bloc.dart';

@immutable
abstract class CollectingListsEvent {}

class CollectingListPressed extends CollectingListsEvent {}

class UnCollectingListPressed extends CollectingListsEvent {}
