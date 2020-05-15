part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnSearching extends SearchEvent{
  String search;
  OnSearching(this.search);
}

// class SearchLoading extends SearchEvent