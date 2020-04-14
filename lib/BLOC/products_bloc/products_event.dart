part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class OnMainCategory extends ProductsEvent{
  @override
  String toString() => "on main category";
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnSubCategory extends ProductsEvent{
  String id;
  OnSubCategory(this.id);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnProductType extends ProductsEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Products extends ProductsEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}