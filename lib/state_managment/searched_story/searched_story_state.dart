part of 'searched_story_bloc.dart';

class SearchedStoryState extends Equatable {

  @override
  List<Object> get props => [];
}

class SearchedStoryInitial extends SearchedStoryState {}



class SearchListState extends SearchedStoryState{
  final List<String> JCodeList;
  SearchListState({required this.JCodeList});

  @override
  List<Object> get props => [JCodeList];
}
