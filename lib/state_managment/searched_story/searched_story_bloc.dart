import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tada/helper/helper_function.dart';

part 'searched_story_event.dart';
part 'searched_story_state.dart';

class SearchedStoryBloc extends Bloc<SearchedStoryEvent, SearchedStoryState> {
  SearchedStoryBloc() : super(SearchedStoryInitial()) {
    on<AddItemToListEvent>(AddItemToListMethod);
    on<DeleteItemToListEvent>(DeleteItemToListMethod);
  }

  AddItemToListMethod(AddItemToListEvent event, Emitter<SearchedStoryState> emit){
    HelperFunction().saveLastSearchUserName(event.JCode);
    HelperFunction().getLastSearchUserNames().then((value){
      emit(SearchListState(JCodeList: value));
    });

  }

  DeleteItemToListMethod(DeleteItemToListEvent event, Emitter<SearchedStoryState> emit){
    HelperFunction().removeItemFromIndex(event.JCode);
    print('--------------- ${event.JCode}');
    HelperFunction().getLastSearchUserNames().then((value){
      emit(SearchListState(JCodeList: value));
    });
  }

}
