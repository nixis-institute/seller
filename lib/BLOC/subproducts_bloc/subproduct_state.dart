part of 'subproduct_bloc.dart';

@immutable
abstract class SubproductState {
  const SubproductState();
}

class SubproductInitial extends SubproductState {}

class SubProductsLoading extends SubproductState{}
class NavigateToPrevious extends SubproductState{}

class FailureSubProduct extends SubproductState{}
class NavigationPop extends SubproductState{}


class LoadSubProduct extends SubproductState{
  final List<String> sizes;
  final List<SubProductModel> products;

  const LoadSubProduct({
    this.products,
    this.sizes
  });

  @override
  List<Object> get props => [products,sizes];  
}