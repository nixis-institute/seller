part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState{}

class SearchResult extends SearchState{
  final List<Product> products;
  final List<CategoryName> category;
  
  const SearchResult({this.products,this.category});
  // List<
  // const SearchResult(this.products);
  @override
  List<Object> get props =>null;
}
