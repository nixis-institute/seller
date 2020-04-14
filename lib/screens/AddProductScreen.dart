import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shopping_junction_seller/BLOC/products_bloc/products_state.dart';
// import 'package:shopping_junction_seller/BLOC/bloc/product_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';

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
    _productsBloc = ProductsBloc();
    _productsBloc.add(
      OnMainCategory()
    );

  }



  Widget LList(state) {
  // if(state is LoadProducts)
  var content = state is LoadCateogry
      ?state.categories
      :state is LoadSubCategory
      ?state.subcategories:
      state.type;

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
                state is LoadCateogry
                ? _productsBloc.add(OnSubCategory(content[index].id)):
                state is LoadSubCategory
                ? _productsBloc.add(OnProductType()):
                null;
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


  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title:Text("Add Product")),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){


          if(state is ProductsLoading) {
            return Center(
              child: Text("loading...."),
              // child: CircularProgressIndicator(),
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