import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction_seller/BLOC/login_bloc/login_bloc.dart';
import 'package:shopping_junction_seller/BLOC/search_bloc/search_repository.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository;
  SearchBloc({this.repository});
  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is OnSearching){
        yield SearchLoading();
        final product =  await repository.searcByProduct(event.search);
        yield SearchResult(products: product,category: []);
        final category = await repository.searchByCategory(event.search);
        // print(product);
        yield SearchResult(products: product,category: category);
        
    }
  }
}
