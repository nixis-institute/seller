class Category{
  String id;
  String name;
  String imageUrl;
  List<Slider> slider;
  Category(this.id,this.name,this.imageUrl,{this.slider});
}


class Slider{
  String id;
  String title;
  String image;
  Slider(this.id,this.title,this.image);
}

class ProductSubCategory{
  String id;
  String name;
  ProductSubCategory(this.id,this.name);
}

// class SubCategory{
//   String name;
//   List<Product> products;
//   // SubCategory({this.name,this.products});
// }

class TypeProduct{
  String id;
  String name;
  TypeProduct(this.id,this.name);
}




class Product{
  String id;
  String name;
  double listPrice;
  double mrp;
  // List sizes;
  // List colors;
  bool isInCart;
  String imageLink;
  List<ProductImage> images;
  Product(this.id,this.name,this.listPrice,this.mrp,this.imageLink,{this.isInCart=false});
}

class SubProduct{
  String id;
  String name;
  double listPrice;
  double mrp;
  List sizes;
  List imageLink;
  List<ProductImage> images;
  SubProduct(this.id,this.name,this.listPrice,this.mrp,this.images,this.sizes,this.imageLink);  
}

class ProductImage{
  String id;
  String largeImage;
  String normalImage;
  String thumImage;
  ProductImage(this.id,this.largeImage,this.normalImage,this.thumImage);
}
