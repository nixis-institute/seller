class Category{
  String id;
  String name;
  String imageUrl;
  int productSize;
  List<Slider> slider;
  Category(this.id,this.name,this.imageUrl,this.productSize,{this.slider});
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
  int productSize;
  ProductSubCategory(this.id,this.name,this.productSize);
}

// class SubCategory{
//   String name;
//   List<Product> products;
//   // SubCategory({this.name,this.products});
// }

class TypeProduct{
  String id;
  String name;
  int productSize;
  TypeProduct(this.id,this.name,this.productSize);
}

class ProductWithStatus{
  String status;
  List<Product> products;
  ProductWithStatus(this.status,this.products);
}

// class ColorsPicker{
//   Map code;
//   ColorsPicker(this.code);
// }
// Map colorsPicker = new Map();

// colorsPicker
// ColorsPicker c = ColorsPicker(
  
// );

dynamic sizePicker ={
  "S":"Small",
  "M":"Medium",
  "L":"Large",
  "XL":"Extra Large",
  "XXL":"Double Large",
};

dynamic colorsPicker ={
"#FFFFFF":"White",
"#C0C0C0":"Silver",
"#808080":"Gray", 
"#000000":"Black",
"#FF0000":"Red",
"#800000":"Maroon",
"#FFFF00":"Yellow",
"#808000":"Olive",
"#00FF00":"Lime" ,
"#008000":"Green", 
"#00FFFF":"Aqua",
"#008080":"Teal",
"#0000FF":"Blue",
"#000080":"Navy",
"#FF00FF":"Fuchsia",
"#800080":"Purple",
};





class Product{
  String id;
  String name;
  double listPrice;
  double mrp;
  // List sizes;
  // List colors;
  bool isInCart;
  String imageLink;
  List<String> sizes;
  List<String> colors;
  List<ProductImage> images;
  bool inStock;
  int qty;
  int productSize;
  // String endcursor;
  // bool hasNext
  Product(this.id,this.name,this.listPrice,this.mrp,this.imageLink,this.sizes,this.colors,this.productSize,{this.isInCart=false});
}

class SubProductModel{
  String size;
  List<SubProduct> product;
  SubProductModel({this.size,this.product});
}

// class SProduct{
//   String id;
//   String name;
// }

class SubProduct{
  String id;
  String name;
  double listPrice;
  double mrp;
  String size;
  String color;
  bool inStock;
  int qty;
  // List imageLink;
  List<ProductImage> images;
  SubProduct(this.id,this.name,this.listPrice,this.mrp,this.inStock,this.qty,this.images,this.size,this.color);  
}

class ProductImage{
  String id;
  String largeImage;
  String normalImage;
  String thumImage;
  ProductImage(this.id,this.largeImage,this.normalImage,this.thumImage);
}
