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

class OnCreateParentProduct extends ProductsEvent{
  String id;
  String prdName;
  String brand;
  String sortDesc;
  String longDesc;
  @override
  OnCreateParentProduct(this.id,this.prdName,this.brand,this.sortDesc,this.longDesc);
}

class OnSubCategory extends ProductsEvent{
  String id;
  OnSubCategory(this.id);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnProductType extends ProductsEvent{
  String id;
  OnProductType(this.id);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnProducts extends ProductsEvent{
  // String id;
  OnProducts();
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnSubProducts extends ProductsEvent{
  String id;
  OnSubProducts(this.id);
  @override
  // TODO: implement props
  List<Object> get props => null;
}

