
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/product_repository.dart';
// import 'package:shopping_junction_seller/BLOC/products_bloc/products_state.dart';
// import 'package:shopping_junction_seller/BLOC/bloc/product_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/createProduct.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/productList.dart';

class AddProduct extends StatefulWidget{
  @override
  AddProductSate createState() => AddProductSate();
}

class AddProductSate extends State<AddProduct>
{

  // ProductBloc _productBloc;
  ProductRepository rep;
  ProductsBloc _productsBloc;
  @override

  void initState(){
    super.initState();
    _productsBloc = ProductsBloc(rep);
    _productsBloc.add(
      OnMainCategory()
    );

  }




  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title:Text("Add Product")),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){
          if(state is ProductsLoading) {
            return Center(
              child: Text("loading...."),
            );
          }
          else if(state is LoadCateogry ){
              return LList(state);
          }

          else if(state is LoadSubCategory){
            return LList(state);
          }

          
          else{
            return Center(
              child: Text("else "),
            );            
          }
        },
      )
    );
  }
}

  Widget LList(state) {
  // if(state is LoadProducts)
  var content = state is LoadCateogry
      ?state.categories
      :state is LoadSubCategory
      ?state.subcategories:
      state.productType;

  return Container(
    padding: EdgeInsets.all(10),
    child: ListView.separated(
      separatorBuilder: (context, index) => Divider(
      color: Colors.grey[400],
      height: 1,
      ),
      itemCount:content.length,
      // itemCount: state.,
      itemBuilder: (context,index)
      {
        return Container(
          height: 50,
          child: InkWell(
              onTap: (){

                state is LoadCateogry?
                  Navigator.push(context, MaterialPageRoute(builder: 
                  (_)=>SubCategoryScreen(content[index].id,content[index].name)
                  ))
                  :state is LoadSubCategory?
                  Navigator.push(context, MaterialPageRoute(builder: 
                  (_)=>TypeScreen(content[index].id,content[index].name)
                  )):Navigator.push(context, MaterialPageRoute(builder: 
                  (_)=>CreateProductScreen(content[index].id)
                  ));
                  
                  
                  
                  

                // state is LoadCateogry
                // ? _productsBloc.add(OnSubCategory(content[index].id)):
                // state is LoadSubCategory
                // ? _productsBloc.add(OnProductType()):
                // null;
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(content[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Row(
                  children: <Widget>[
                    // Icon(Icons),
                    IconButton(
                      icon:Icon(Icons.mode_edit,color: Colors.green[500],), 
                      onPressed: (){
                        print("edit...");
                      }
                      ),
                  ],
                ),
              ],
            ),
          ),
        );


      }
      
      )
  );
  }


// Widget listOfContent(){

// }







class SubCategoryScreen extends StatefulWidget{
  String id,name;
  SubCategoryScreen(this.id,this.name);
  @override
  SubCategoryScreenState createState() => SubCategoryScreenState();
}
class SubCategoryScreenState extends State<SubCategoryScreen>
{
  ProductRepository rep;
  ProductsBloc _productsBloc;
  void initState()
  {
    super.initState();
    _productsBloc = ProductsBloc(rep);
    _productsBloc.add(
      OnSubCategory(this.widget.id)
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title:Text(this.widget.name)),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){
          if(state is ProductsLoading) {
            return Center(
              child: Text("loading...."),
            );
          }
          else if(state is LoadSubCategory){
            return LList(state);
          }
          else{
            return Center(
              child: Text("else "),
            );            
          }
        },
      )
    
    );

  
  }
}




class TypeScreen extends StatefulWidget{
  String id,name;
  TypeScreen(this.id,this.name);
  @override
  TypeScreenState createState() => TypeScreenState();
}
class TypeScreenState extends State<TypeScreen>
{

  ProductsBloc _productsBloc;
  ProductRepository rep;
  void initState()
  {

    super.initState();
    _productsBloc = ProductsBloc(rep);
    _productsBloc.add(
      OnProductType(this.widget.id)
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title:Text(this.widget.name)),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){
          if(state is ProductsLoading) {
            return Center(
              child: Text("loading...."),
            );
          }
          else if(state is LoadTypeProduct){
            // return Text("loadin...");
            return LList(state);
          }
          else{
            return Center(
              child: Text("else "),
            );            
          }
        },
      )
    
    );

  }
}
