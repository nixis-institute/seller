part of 'subproduct_bloc.dart';

@immutable
abstract class SubproductEvent {}

class OnSubProducts extends SubproductEvent{
  String id;
  OnSubProducts(this.id);
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class OnUpdateSubProductImages extends SubproductEvent{
  SubProduct product;
  OnUpdateSubProductImages(this.product);
}

class OnAddSubProduct extends SubproductEvent{
  String id;
  String size;
  String color;
  String qty;
  String mrp;
  String listPrice;
  OnAddSubProduct(this.id,this.size,this.color,this.qty,this.mrp,this.listPrice);
  @override
  // TODO: implement props
  List<Object> get props => [null];  
}
