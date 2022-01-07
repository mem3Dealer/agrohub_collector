import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collecting_lists_event.dart';
part 'collecting_lists_state.dart';

class CollectingListsBloc
    extends Bloc<CollectingListsEvent, CollectingListsState> {
  CollectingListsBloc() : super(UnCollectingListState()) {
    on<CollectingListPressed>((event, emit) {
      emit(CollectingListState());
    });
    on<UnCollectingListPressed>((event, emit) {
      emit(UnCollectingListState());
    });
  }
}
