import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/models/productModel.dart';


class SubProductScreen extends StatefulWidget{
  String id,name;
  SubProductScreen(this.id,this.name);
  @override
  _SubProductScreen createState() => _SubProductScreen();
}

class _SubProductScreen extends State<SubProductScreen>
{
  ProductsBloc _productsBloc;
  void initState()
  {
    super.initState();
    _productsBloc = ProductsBloc();
    _productsBloc.add(
      OnSubProducts(this.widget.id)
    );
  }

  @override


  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.name),),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        bloc: _productsBloc,
        builder: (context,state){
          if(state is ProductsLoading)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadSubProduct){
            List<SubProduct>  products = state.products; 
            print(products);
            // return Text("loaded");

            return Container(
              child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
              color: Colors.grey[400],
              height: 1,
              ),                
                itemCount: products.length,  
                itemBuilder: (context,i)
                {
                  return Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              products[i].size.toString(),
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                            ),

                            Row(
                              children: <Widget>[
                                Text(products[i].color.toString()),
                                Text(products[i].mrp.toString()),
                              ],
                            )


                          ],
                        ),

                        // Text(
                        //   products[i].mrp.toString()
                        // ),                
                        // Text(
                        //   products[i].size
                        // ),
                        // Text(
                        //   products[i].qty.toString()
                        // ),
                      ],
                    ),
                  );
                }
                ),
            );

          }
          else{
            return Text("error");
          }
        }
      
      )
    );

  }
}