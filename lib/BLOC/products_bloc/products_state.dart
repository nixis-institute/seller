part of 'products_bloc.dart';

// @immutable
abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsLoading extends ProductsState{
    final List<Category> categories=[];
    List<Category> get props => null;
}

class ProductsInitial extends ProductsState {
    final List<Category> categories=[];
    List<Category> get props => null;
}

class LoadCateogry extends ProductsState{
  final List<Category> categories;
  
  const LoadCateogry({
    this.categories
  });
  
    LoadCateogry copyWith({
    List<Category> categories,
    // bool hasReachedMax,
  }) {
    return LoadCateogry(
      categories: categories ?? this.categories,
      // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  // print("lading");
  @override
  List<Category> get props => null;
}




class LoadSubCategory extends ProductsState{
  // final List<Category> categories=[];
  final List<ProductSubCategory> subcategories;
  const LoadSubCategory({
    this.subcategories
  });
  
    LoadSubCategory copyWith({
    List<ProductSubCategory> subcategories,
  }) {
    return LoadSubCategory(
      subcategories: subcategories ?? this.subcategories,
    );
  }
    @override
  List<Object> get props => [subcategories];  
}




class LoadTypeProduct extends ProductsState{
final List<Category> categories=[];
    List<Category> get props => null;
}
class LoadProducts extends ProductsState{
  final List<Category> categories=[];
    List<Category> get props => null;
}