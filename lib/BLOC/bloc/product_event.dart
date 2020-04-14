part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AppStarted extends ProductEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class Fetch extends ProductEvent{
  @override
  String toString() => "fetch";

  @override
  // TODO: implement props
  List<Object> get props => null;
}
