part of 'searched_story_bloc.dart';

class SearchedStoryEvent extends Equatable {
  const SearchedStoryEvent();
  @override
  List<Object?> get props => [];
}


class AddItemToListEvent extends SearchedStoryEvent{
  final String JCode;
  AddItemToListEvent({required this.JCode});

  @override
  List<Object?> get props => [JCode];
}

class DeleteItemToListEvent extends SearchedStoryEvent{
  final String JCode;
  DeleteItemToListEvent({required this.JCode});

  @override
  List<Object?> get props => [JCode];
}


