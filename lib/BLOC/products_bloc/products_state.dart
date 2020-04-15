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
  final List<TypeProduct> productType;

  const LoadTypeProduct({
    this.productType
  });

    LoadTypeProduct copyWith({
    List<TypeProduct> productType,
  }) {
    return LoadTypeProduct(
      productType: productType ?? this.productType,
    );
  }
  @override
  List<Object> get props => [productType];  
}




class LoadProducts extends ProductsState{
  final List<Product> products;

  const LoadProducts({
    this.products
  });

    LoadProducts copyWith({
    List<Product> products,
  }) {
    return LoadProducts(
      products: products ?? this.products,
    );
  }
  @override
  List<Object> get props => [products];  
}


// class LoadProducts extends ProductsState{
//   final List<Product> products;
//   const LoadProducts({this.products});
//   LoadProducts copyWith({
//     List<Product> products,
//   }){
//     return LoadProducts(
//       products:products??this.products
//     );
//   } 

//   @override
//     List<Product> get props => [products];
// }