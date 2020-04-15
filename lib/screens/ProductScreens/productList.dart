import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';

class ProductScreen extends StatefulWidget{
  String id,name;
  ProductScreen(this.id);
  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen>
{

  ProductsBloc _productsBloc;
  void initState()
  {

    super.initState();
    _productsBloc = ProductsBloc();
    _productsBloc.add(
      OnProducts(this.widget.id)
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Products"),),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){
          if(state is ProductsLoading) {
            return Center(
              child: Text("loading...."),
            );
          }
          else if(state is LoadProducts){
            // return Text("loadin...");
            return Container(
              color: Colors.white,
              // height: 100,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
                height: 1,
                ),
                itemCount: state.products.length,
                itemBuilder: (context,index)
                {
                  return Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          width: 50,
                          child: 
                          CachedNetworkImage(
                            height: 100,
                            imageUrl: server_url+"/media/"+state.products[index].imageLink.toString()
                            )
                          // Icon(Icons.shopping_cart),

                        ),

                        Expanded(
                          child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(state.products[index].name,overflow: TextOverflow.ellipsis, style: TextStyle( fontSize: 18,fontWeight: FontWeight.normal),),
                            ],
                          )),
                        
                        
                        Container(
                          width: 50,
                            child: Row(
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
                        ),
                      ],
                    ),
                  );
                } 
                
                ),
            );
          }
          else{
            return Center(
              child: Text("else "),
            );            
          }
        },
      ),
    );
  }
}