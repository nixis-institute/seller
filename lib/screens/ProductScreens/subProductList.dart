import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_bloc.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/AddProductSize.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/imageScreen.dart';


class SubProductScreen extends StatefulWidget{
  String id,name;
  SubProductScreen(this.id,this.name);
  @override
  _SubProductScreen createState() => _SubProductScreen();
}

class _SubProductScreen extends State<SubProductScreen>
{
  // ProductsBloc _productsBloc;
  bool isSubmit = false;
  SubProduct dup;
  SubproductBloc _bloc;
  void initState()
  {
    super.initState();
    BlocProvider.of<SubproductBloc>(context).add(
      OnSubProducts(this.widget.id)
        
        // OnSubProducts(this.widget.id)
    );
    // _productsBloc = ProductsBloc();
    // _productsBloc.add(
    //   OnSubProducts(this.widget.id)
    // );
    isSubmit = false;
  }


  void _updateSubProduct(id,mrp,list,qty,SubProduct product) async{
    GraphQLClient _client = clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(updateSubProductQuery),
        variables: {
          "id":id,
          "mrp":mrp,
          "list":list,
          "qty":qty
        }
      )
    );

    if(!result.hasException){
      setState(() {
        product.qty = int.parse(qty);
        product.mrp = double.parse(mrp);
        product.listPrice = double.parse(list);
        
      });
      
      // setState(() {
      //   p
      // });
      Navigator.of(context).pop();
      setState(() {
        isSubmit = false;
      });

    }

  }
  
  void _showDialog(SubProduct product){
    // _productsBloc.add(
    //   OnAddVarient());
    // OnAddVarient
    
    setState(() {
      dup = product as SubProduct;
    });
    final _id = product.id;
    final _mrp = TextEditingController();
    final _list = TextEditingController();
    final _qty = TextEditingController();
    print(_id);
    setState(() {
      _mrp.text = product.mrp.toString();
      _list.text = product.listPrice.toString();
      _qty.text = product.qty.toString();
    });


    showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return         AlertDialog(
          title:Text("Update"),
          content: 
          isSubmit?
          Container(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ):

          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              // SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("MRP",style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal),),
                  
                  Container(
                    width: 70,
                    child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mrp,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "MRP"   
                    ),
                      ),
                  )
                 
                  // Text(product.mrp.toString(),style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Price"),
                  Container(
                    width: 70,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                    controller: _list,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "List" ,
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.grey),
                              //   borderRadius: BorderRadius.circular(25.7),
                              // ),

                              // enabledBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.grey),
                              //   borderRadius: BorderRadius.circular(25.7),
                              // ),                        
                      // contentPadding: const EdgeInsets.only(left: 5.0,top:0,bottom:0),
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 1
                      //   )
                      // )
                    ),
                      ),
                  )
                  // Text(product.listPrice.toString())
                ],
              ),
              SizedBox(height: 15,),              
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Qty"),
                    Row(
                      children: <Widget>[
                      // InkWell(
                      //     onTap: (){
                            
                      //       if( (int.parse(_qty.text)) >1){
                      //         setState(() {
                      //           _qty.text = (int.parse(_qty.text)-1).toString();
                      //             dup.qty-=1;
                      //         });
                      //         // this.widget.callback(this.widget.total- dup[index].listPrice);
                      //         }
                      //     },
                      //     child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey[200]
                      //     ),
                      //     child: Icon(Icons.remove,color: Colors.grey, )
                      //     ),
                      //   ),
                        
                        
                        // SizedBox(width: 10,),

                        Center(
                          child: 
                          Container(
                            width: 70,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _qty,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                
                              ),
                              
                            ),
                          )
                          // Text(_qty.text.toString(),
                          // // style: TextStyle(fontWeight: FontWeight.bold,),
                          // ),
                        ),
                        
                        // SizedBox(width: 10,),
                        
                      //   InkWell(
                      //     onTap: (){
                      //     if(int.parse(_qty.text)>0)
                      //     {
                      //       setState(() {
                      //         _qty.text = (int.parse(_qty.text)+1).toString();
                      //           // dup.qty+=1; 
                      //         // this.widget.callback(this.widget.total+ product[index].listPrice);
                      //       });
                      //       }
                      //     // this.widget.callback(this.widget.total+ product[index].listPrice);
                          
                      //     },
                      //     child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey[200]
                      //     ),
                      //     child: Icon(Icons.add,color: Colors.grey, )
                      //     ),
                      // ),


                      ],
                    ),
                
                
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text("InStock"),
              //     Text(product.inStock.toString())
              //   ],
              // ),



            ],
          ),

          // Text("Do you want to delete this address?"),
      



          actions: <Widget>[
            !isSubmit?
            FlatButton(
              onPressed: (){
                    setState(() {
                      isSubmit = true;
                    });
                  // _deleteAddress(id,index);
                _updateSubProduct(_id,_mrp.text,_list.text,_qty.text,product);
                // _productsBloc.add(
                //   UpdateSubProduct(
                //     _id,_mrp.text,_list.text,_qty.text
                //   )
                // );



              },
              child: Text("Update",style: TextStyle(color: Colors.green),)
              ):SizedBox(width:1),


            !isSubmit?FlatButton(
              // onPressed: null,
              onPressed: ()=>Navigator.of(context).pop(),
              child: Text("Cancel",style: TextStyle(color: Colors.grey),)
              ):SizedBox(width: 1,)
          ],

        );
        },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.name),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: 
          (_)=>AddProductSizeScreen(
            this.widget.id
        )));        
        // _productsBloc.add(
        //   OnVarientSize()
        //   // OnSubProducts(this.widget.id)
        
        // );

      // BlocBuilder<ProductsBloc,ProductsState>(
      //   bloc: _productsBloc,
      //   builder: (context,state){
      //     if(state is LoadSubProduct){

      //         Navigator.push(context, MaterialPageRoute(builder: 
      //           (_)=>AddProductSizeScreen(
            
      //       )));
      //     }
      //   },
      // );
  
      },
      
      tooltip: 'Add Size',
      icon: Icon(Icons.add),
      label: Text("Add Size")
      ),



      body: BlocBuilder<SubproductBloc,SubproductState>(
        // bloc: _productsBloc,
        bloc:_bloc,
        builder: (context,state){
          if(state is SubProductsLoading)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadSubProduct){
            List<SubProductModel>  products = state.products; 
            // print("main length "+products.length.toString());
            // return Text("loaded");

            return Container(
              // padding: EdgeInsets.all(10),
              child: ListView.builder(
              
              // separatorBuilder: (context, index) => Divider(
              // color: Colors.grey[0],
              // height: 0,
              // ),


                itemCount: products.length,  
                itemBuilder: (context,i)
                {
                  return Container(
                    padding: EdgeInsets.only(right:5,left:5,bottom: 5),
                    child: Card(
                      // elevation: 0,
                      child: Container(
                        // height: 100,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                
                                Text(
                                  sizePicker[products[i].size.toString()],
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),

                                
                                ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey[0],
                                    height: 0,
                                    ),
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: products[i].product.length,
                                  itemBuilder: (context,j){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[  
                                        // SizedBox(height: 10,),
                                        InkWell(
                                            onTap: (){
                                              // _showDialog(products[i].product[j]);
                                            _showSheet(context,products[i].product[j]);

                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              // color: Colors.red,
                                              child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[


                                                // Text(products[i].product[j].color),




                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.all(3),
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width:0.2,color:Colors.grey),
                                                        color: Color(int.parse(products[i].product[j].color.toString().replaceAll("#", "0xff"))),
                                                        borderRadius: BorderRadius.circular(50)
                                                        ),
                                                    // child:
                                                    ),
                                                    SizedBox(width: 10,),
                                                      Text(
                                                      colorsPicker[products[i].product[j].color.toString()],
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text("("+products[i].product[j].qty.toString()+")")
                                                    // SizedBox(width: 10,),
                                                    // Icon(Icons.add_circle_outline,color: Colors.grey,)
                                                  ],
                                                ),







                                                Row(
                                                  children: <Widget>[
                                                    Text("\u20B9 "+ products[i].product[j].mrp.toString(),
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),



                                              ],
                                          ),
                                            ),
                                        ),
                                      // Divider()  
                                      ],
                                    );
                                  },
                                ),

                                
                                Divider(height: 0,),
                                SizedBox(height:15),
                                Center(child: Text('Add Color',style: TextStyle(color: Colors.green),))




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
                      ),
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

  // _showS(context){
  //   showCupertinoModalPopup(
  //     context: context, builder: (BuildContext bc){
  //       return 
  //     }
      
  //     );
  // }
  _showSheet(context,SubProduct prd){
    showModalBottomSheet(
    // showCupertinoModalPopup(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit"),
                onTap: (){
                  // Navigation.pop
                  Navigator.pop(context);
                  _showDialog(prd);
                },
              ),
              Divider(),

              ListTile(
                onTap: (){
                  // Navigator.push(context, route)
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: 
                    (_)=>ImageScreen(
                      prd
                  )));

                },
                leading: Icon(Icons.image),
                // subtitle: Text(prd.images.length.toString() ),
                title: Text(prd.images.length.toString() +" Images"),
              ),                
            ],
          ),
        );
      }
    );
  }
}