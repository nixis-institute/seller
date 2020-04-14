part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  // ProductState([List props = const []]):super();
  // PostState([List props = const []]):super(props);
}

class ProductLoading extends ProductState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class FetchProduct extends ProductState {
  @override
  List<Object> get props => [];
}
class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded({
    this.products
  });
  
    ProductLoaded copyWith({
    List<Product> products,
    bool hasReachedMax,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }


  @override
  String toString() => 'product Loaded ${products.length}';

  @override
  List<Object> get props => [];
  // List<Object> get props => [];
}