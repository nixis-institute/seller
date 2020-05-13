// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  ProductsBloc _productsBloc;
  @override

  void initState(){
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(
      // OnProductType(this.widget.id)
      OnMainCategory()
    );
    // _productsBloc = ProductsBloc();
    // _productsBloc.add(
    //   OnMainCategory()
    // );

  }




  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title:Text("Select Product Category")),
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
                  (_)=>
                  CreateProductScreen(content[index].id)
                  // ProductScreen()
                  
                  
                  ));
              },
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(content[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(width:20),
                    Text("("+content[index].productSize.toString()+")",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),)
                  ],
                ),
                
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

  ProductsBloc _productsBloc;
  void initState()
  {
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(
      // OnProductType(this.widget.id)
      OnSubCategory(this.widget.id)
    );
    // _productsBloc = ProductsBloc();
    // _productsBloc.add(
    //   OnSubCategory(this.widget.id)
    // );
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
  void initState()
  {

    super.initState();
    // _productsBloc = ProductsBloc();
    BlocProvider.of<ProductsBloc>(context).add(
      OnProductType(this.widget.id)
    );
    // _productsBloc.add(
    //   OnProductType(this.widget.id)
    // );
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

