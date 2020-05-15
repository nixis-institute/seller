import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/product_repository.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  GraphQLClient client = clientToQuery();
  final ProductRepository _productRepository;
  ProductsBloc(this._productRepository);

  // ProductRepository _productRepository = new ProductRepository();

  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event,) async* {
    var currentState = state;
    if(event is OnMainCategory)
    {
      // print("category....");
      yield ProductsLoading();
      final category = await _fetchMainCategory();
      // print("loaded...");
      yield LoadCateogry(categories: category);
      return;
    }


    if(event is MakeItInActive){
        List<ProductWithStatus> x = (state as LoadProductsWithStatus).products;
        // yield ProductsLoading();
        await _productRepository.activatedProduct(event.product.id, 0 );
        List<ProductWithStatus> prd = [];
        
        List<Product> temp =[];
        for(int i=0;i<x.length;i++){
            temp = [];
            for(int j=0;j<x[i].products.length;j++){
              if(x[i].products[j].id != event.product.id ){
                // x[i].products[j].inStock = true;
                temp.add(
                  x[i].products[j]
                );
              }
            }
            // print(temp.length);
            prd.add(
              ProductWithStatus(x[i].status, temp)
            );
        }
        event.product.isActive = false;
        prd = prd..map((e){
          return e.status == "InActive"?
          e.products.insert(0,event.product):null;
        }).toList();
        yield LoadProductsWithStatus(products:prd);
      
    }

    // if(event is MakeItActive){
    //   if(state is LoadProductsWithStatus)
    //   { 
    //     List<ProductWithStatus> prd = [];
    //     List<ProductWithStatus> x = (state as LoadProductsWithStatus).products;
    //     List<Product> temp =[];
    //     for(int i=0;i<x.length;i++){
    //         temp = [];
    //         for(int j=0;j<x[i].products.length;j++){
    //           if(x[i].products[j].id != event.product.id ){
    //             // x[i].products[j].inStock = true;
    //             temp.add(
    //               x[i].products[j]
    //             );
    //           }
    //         }
    //         print(temp.length);
    //         prd.add(
    //           ProductWithStatus(x[i].status, temp)
    //         );
    //     }
    //     event.product.isActive = false;
    //     prd = prd..map((e){
    //       return e.status == "Active"?
    //       e.products.add(event.product):null;
    //     }).toList();
    //     yield LoadProductsWithStatus(products:prd);
    //   }
    // }







    if(event is MakeItInStock){
      if(state is LoadProductsWithStatus)
      { 
        List<ProductWithStatus> x = (state as LoadProductsWithStatus).products;
        // yield ProductsLoading();
        await _productRepository.inStockProduct(event.product.id, 1);
        List<ProductWithStatus> prd = [];
        
        List<Product> temp =[];
        for(int i=0;i<x.length;i++){
            temp = [];
            for(int j=0;j<x[i].products.length;j++){
              if(x[i].products[j].id != event.product.id ){
                // x[i].products[j].inStock = true;
                temp.add(
                  x[i].products[j]
                );
              }
            }
            print(temp.length);
            prd.add(
              ProductWithStatus(x[i].status, temp)
            );
        }
        event.product.inStock = true;
        event.product.isActive = true;
        prd = prd..map((e){
          return e.status == "Instock"?
          e.products.insert(0,event.product):null;
        }).toList();
        yield LoadProductsWithStatus(products:prd);
      }
    }
    
    if(event is MakeItOutOfStock){
      if(state is LoadProductsWithStatus)
      {
        List<ProductWithStatus> x = (state as LoadProductsWithStatus).products;
        // yield ProductsLoading();
        await _productRepository.inStockProduct(event.product.id, 0);
        List<ProductWithStatus> prd = [];
        
        List<Product> temp =[];
        for(int i=0;i<x.length;i++){
            temp = [];
            for(int j=0;j<x[i].products.length;j++){
              if(x[i].products[j].id != event.product.id ){
                // x[i].products[j].inStock = false;
                temp.add(
                  x[i].products[j]
                );
              }
            }
            print(temp.length);
            prd.add(
              ProductWithStatus(x[i].status, temp)
          );
        }
        event.product.inStock = false;
        event.product.isActive = true;
        prd = prd..map((e){
          return e.status == "Out of Stock"?
          e.products.insert(0,event.product):null;
        }).toList();
        yield LoadProductsWithStatus(products:prd);
      }
    }


    if(event is OnProductType)
    {
      yield ProductsLoading();
      final productType = await _fetchTypeProduct(event.id);
      yield LoadTypeProduct(productType: productType);

    }

    if(event is OnSubCategory)
    {
      // yield ProductLoading();
      yield ProductsLoading();
      final category = await _fetchSubCategory(event.id);
      yield LoadSubCategory(subcategories: category);
      // yield LoadSubCateogry(subcategories: category);
      return;
    }

    if(event is OnProducts)
    {
      yield ProductsLoading();
      // print(event.id);
      // print("k_");
      final products = await _fetchAllProducts();
      // print(event.id);
      // print("*******");
      yield LoadProductsWithStatus(products: products);
      // yield LoadProducts(products: products);
      // yield LoadSubCateogry(subcategories: category);
      return;      
    }

    if(event is OnCreateParentProduct){
      yield ParentUploadLoading();
      final data = await _uploadParentProduct(event.id,event.brand,event.prdName,event.sortDesc,event.longDesc);

      yield ParentProductLoaded(id: data["id"],name:data["name"]);
      // print("after loaded...");
      return;
    }

    // if(event is UpdateSubProduct){
    //   final data = await _updateSubProduct();
    // }

    if(event is OnSubProductForm){
      yield LoadVarientForm();
    }
    // currentState = LoadSubProduct;
    
    if(event is OnAddVarient){
      // print(currentState.products);
      if(currentState is LoadSubProduct){
        print(currentState.products);
      }
      // currentState = LoadSubProduct;
      // currentState = currentState as LoadProducts;
      
      // if(currentState is LoadSubProduct){
      //   List<String> s = [];
        
      //   // currentState.products.map((e)=>{
      //   //   s.add(e.size)
      //   // });
      //   yield LoadRemainedSized(sizes:s);
      //   // LoadRemainedSized(:s);
      //   // currentState.products[0].
      // }
      // else{
      //   print(currentState);
      //   List<String> d=["S","P"];
      //   yield LoadRemainedSized(sizes:d);
      // }
    }

    if(event is OnSubProducts)
    {
      yield ProductsLoading();
      // print(event.id);
      // final products = await _productRepository.getSubProductByRepository(event.id);
      final products = await _fetchSubProduct(event.id);
      // print(event.id);
      yield LoadSubProduct(products: products);
      // print(event);
      print(currentState);
      return;
      // if(currentState is )
      // yield LoadSubCateogry(subcategories: category);
      
    
    }
  }









  Future<List<Category>> _fetchMainCategory() async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getCategoryQuery)
        )
      );

      if(!result.hasException){
        var data = result.data["allCategory"]["edges"];
        List<Category> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            Category(
               data[i]["node"]["id"], 
               data[i]["node"]["name"], 
               data[i]["node"]["image"],
               data[i]["node"]["productSize"]
               )
          );
        }
        return category;
      }
  }

  Future<List<ProductSubCategory>> _fetchSubCategory(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getSubCategoryQuery),
          variables: {
            "CateogryId":id
          }
        )
      );

      if(!result.hasException){
        var data = result.data["subcateogryByCategoryId"]["edges"];
        List<ProductSubCategory> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            ProductSubCategory(
            data[i]["node"]["id"], 
            data[i]["node"]["name"],
            data[i]["node"]["productSize"]
            ),
            
          );
        }
        return category;
      }
  }

  Future<dynamic> _uploadParentProduct(id,brand,prdName,shortDesc,longDesc) async{
    QueryResult result = await client.mutate(
      MutationOptions(
        documentNode: gql(uploadParentProductQuery),
        variables: {
            "id": id,
            "brand": brand,
            "prdName": prdName,
            "shortDesc": shortDesc,
            "longDesc": longDesc
        }
      )
    );

    if(!result.hasException){
      var data = result.data["createParentProduct"]["prd"];
      // print(data);
      return data;
    }


  }
  Future<List<ProductWithStatus>> _fetchAllProducts() async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getAllProductsQuery),
          fetchPolicy: FetchPolicy.networkOnly
        )
      );
      // print("__");
      // print(result.exception.toString());
      if(!result.hasException)
      {
        // print("__");
        
        List<ProductWithStatus> prdWS =[];
        List data = result.data["allProducts"]["edges"];
        List<Product> _inStockprd =[];
        List<Product> _inActive =[];
        List<Product> _outStockprd =[];
        List<String> size = [];
        List<String> color=[];
        for(int i=0;i<data.length;i++)
        {
          data[i]["node"]["sizes"].forEach((f)=>{
            // print(f),
            size.add(f.toString()),
            // print("done")
          });
          data[i]["node"]["color"].forEach((f)=>{
            // print(f),
            color.add(f)
          });
          // data[i]["node"]["color"]



          // print(data[i]["node"]["color"].length);
          if(data[i]["node"]["isActive"]==false){
            _inActive.add(
              Product(
              data[i]["node"]["id"], 
              data[i]["node"]["brand"], 
              data[i]["node"]["name"], 
              0, 
              !data[i]["node"]["productimagesSet"]["edges"].isEmpty
              ?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
              data[i]["node"]["productSize"],
              inStock: data[i]["node"]["instock"],
              isActive:false
              )
            );
          }
          else if(data[i]["node"]["instock"]==true)
          {
            _inStockprd.add(
              Product(
              data[i]["node"]["id"], 
              data[i]["node"]["brand"], 
              data[i]["node"]["name"], 
              0, 
              !data[i]["node"]["productimagesSet"]["edges"].isEmpty
              ?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
              data[i]["node"]["productSize"],
              inStock: data[i]["node"]["instock"],
              isActive: true
              )
            );
            // print("done...");
          }
          else{
            _outStockprd.add(


              Product(
              data[i]["node"]["id"], 
              data[i]["node"]["brand"],
              data[i]["node"]["name"], 
              0, //listprice
              !data[i]["node"]["productimagesSet"]["edges"].isEmpty
              ?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null, 
              // ["S"],
              // ["M"],
              // data[i]["node"]["sizes"] as List<String>, 
              
              // data[i]["node"]["color"] as List<String>, 
              data[i]["node"]["productSize"],
              inStock: data[i]["node"]["instock"],
              isActive: true
              )
            );
          }
        }

//         data.forEach((d)=>{

//           if(d["node"]["instock"]==true){
                  
//             _inStockprd.add(
//               Product(
//               d["node"]["id"], 
//               d["node"]["name"], 
//               0, 
//               0, 
// "",
//               // d["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"],
//               ["M"],
//               // d["node"]["sizes"] as List, 
//               ["E"],
//               // d["node"]["color"] as List, 

//               d["node"]["productSize"]
//               )
//             ),  
//           print(d["node"]["sizes"]),  
//           }


//           else{
              
//             _outStockprd.add(
//               Product(
//               d["node"]["id"], 
//               d["node"]["name"], 
//               d["node"]["listPrice"], 
//               d["node"]["mrp"], 
// "",
//               // d["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"], 

//               d["node"]["sizes"] as List, 
//               d["node"]["color"] as List, 
//               d["node"]["productSize"]
//               )
//             ),            
//           }
//         });



        // print("...........");
        prdWS.add(ProductWithStatus("Instock",_inStockprd));
        prdWS.add(ProductWithStatus("Out of Stock",_outStockprd));
        prdWS.add(ProductWithStatus("InActive",_inActive));
        // print(prdWS);
        return prdWS;
      }
  }

  Future<List<TypeProduct>> _fetchTypeProduct(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getTypeProductQuery),
          variables: {
            "id":id
          }
        )
      );

      if(!result.hasException){
        var data = result.data["sublistBySubcategoryId"]["edges"];
        List<TypeProduct> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            TypeProduct(
            data[i]["node"]["id"], 
            data[i]["node"]["name"],
            data[i]["node"]["productSize"]
            ),
            
          );
        }
        return category;
      }
  }

  Future<List<SubProductModel>> _fetchSubProduct(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getProductByParentId),
          variables: {
            "id":id
          }
        )
      );
      if(!result.hasException)
      {
        var data = result.data["productByParentId"]["edges"];
        List<SubProduct> prd=[];
        List<ProductImage> img=[];
        
        List<SubProductModel> prdModelList=[];
        // SubProductModel p = new SubProductModel();

        Map e = new Map();
        // SubProductModel
        
        for(int i=0;i<data.length;i++)
        {
          img=[];
          data[i]["node"]["productimagesSet"]["edges"].forEach((e)=>{
              img.add(
                ProductImage(
                  e["node"]["id"],
                  e["node"]["largeImage"], 
                  e["node"]["normalImage"], 
                  e["node"]["thumbnailImage"]
                  
                  )
              )
          });

          // prd.add(
          //   SubProduct(data[i]["node"]["id"], 
          //   "", 
          //   data[i]["node"]["listPrice"], 
          //   data[i]["node"]["mrp"],
          //   data[i]["node"]["instock"], 
          //   data[i]["node"]["qty"],
          //   img,
          //   data[i]["node"]["size"], 
          //   data[i]["node"]["color"])
          // );

          if(e.containsKey(data[i]["node"]["size"]))
          {
            e[data[i]["node"]["size"]].add(
              SubProduct(data[i]["node"]["id"], 
              "", 
              data[i]["node"]["listPrice"], 
              data[i]["node"]["mrp"],
              data[i]["node"]["instock"], 
              data[i]["node"]["qty"],
              img,
              data[i]["node"]["size"], 
              data[i]["node"]["color"])
            );
          }
          else{
            e[data[i]["node"]["size"]] = [
              SubProduct(data[i]["node"]["id"], 
              "", 
              data[i]["node"]["listPrice"], 
              data[i]["node"]["mrp"],
              data[i]["node"]["instock"], 
              data[i]["node"]["qty"],
              img,
              data[i]["node"]["size"], 
              data[i]["node"]["color"])
            ];
          }

          // if(p.size.isEmpty || p.size !=data[i]["node"]["size"])
          // {
          //   p.size = data[i]["node"]["size"];
          // }
          // else
        }

        e.forEach((key,value)=>{
          prdModelList.add(
            SubProductModel(
              size: key,
              product: value
            )
          )
        });

        // print(prdModelList[0].product);
        return prdModelList;
      }
  }


  //   Future<List<Product>> _fetcheProducts(id) async{
  //     QueryResult result = await client.query(
  //       QueryOptions(
  //         documentNode: gql(getProductByTypeId),
  //         variables: {
  //           "id":id
  //         }
  //       )
  //     );

  //     if(!result.hasException){
  //       var data = result.data["productBySublistId"]["edges"];
  //       List<Product> products = [];
  //       List<String> sizes=[];
  //       List<String> color=[];
        
  //       for(int i=0;i<data.length;i++)
  //       {
  //         // print(data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]);
  //         sizes=[];
  //         color=[];
  //         // for(int j=0;j<data[i]["node"]["subproductSet"]["edges"].length;j++)
  //         // {
  //         //   sizes.add(data[i]["node"]["subproductSet"]["edges"][j]["node"]["size"]);
  //         // }
  //         // sizes=[];
  //         // sizes.addAll(data[i]["node"]["sizes"]);
  //         // color.addAll(data[i]["node"]["color"]);
  //         // print(sizes);
  //         data[i]["node"]["sizes"].forEach((f)=>{
  //             sizes.add(f)
  //             // print(f)
  //         });
  //         data[i]["node"]["color"].forEach((f)=>{
  //             color.add(f)
  //             // print(f)
  //         });          
  //         // print(data[i]["node"]["sizes"]);
  //         // print(data[i]["node"]["color"]);
  //         products.add(
  //           Product(
  //             data[i]["node"]["id"], 
  //             data[i]["node"]["name"], 
  //             0, 
  //             0, 
  //             !data[i]["node"]["productimagesSet"]["edges"].isEmpty
  //             ?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
              
  //             // !data[i]["node"]["subproductSet"]["edges"].isEmpty?

  //             // data[i]["node"]["sizes"],
  //             // data[i]["node"]["color"],
  //             // data[i]["node"]["sizes"],
  //             // [],
  //             sizes,
  //             color,
  //             // data[i]["node"]["color"].toList(),
  //             data[i]["node"]["productSize"]
  //             // data[i]["node"]["productimagesSet"]["edges"]?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
  //             )
  //           );
  //         //   TypeProduct(
  //         //   data[i]["node"]["id"], 
  //         //   data[i]["node"]["name"])
  //         // );
  //       }
  //       return products;
  //     }
  // }


}
