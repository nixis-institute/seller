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
  bool isNew = false;
  String _size;
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

  
  void _showDialog({SubProduct product = null}){
    // _productsBloc.add(
    //   OnAddVarient());
    // OnAddVarient
    print("called");
    
    String _selectedColor;
    List<String> _colors =[];
    colorsPicker.forEach((key,value){
      _colors.add(key);
    });
    
    setState(() {
      dup = product as SubProduct;
    });
    final _id = product==null?this.widget.id:product.id;
    final _mrp = TextEditingController();
    final _list = TextEditingController();
    final _qty = TextEditingController();
    print(_id);
    setState(() {
      _mrp.text = product==null?null:product.mrp.toString();
      _list.text = product==null?null:product.listPrice.toString();
      _qty.text = product==null?null:product.qty.toString();
    });


    showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return 
        BlocListener<SubproductBloc,SubproductState>(
          listener: (context,state){
            if(state is LoadSubProduct){
              setState(() {
                isSubmit = false;
              });
              Navigator.pop(context);
            }
          },
          child: 
          // builder: (context,state){
          //   if(state is NavigationPop)

          // },
          
          

         StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
          return AlertDialog(
          title:isNew?Text("Add New Color"): Text("Update"),
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

                        Center(
                          child: 
                          Container(
                            width: 70,
                            child: TextFormField(
                              
                              keyboardType: TextInputType.number,
                              controller: _qty,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Qty"
                              ),
                              
                            ),
                          )

                          // ),
                        ),
                        

                      ],
                    ),
                
                
                ],
              ),

              SizedBox(height:15),
              isNew?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Color"),
                  DropdownButton(
                    hint: Text("Select Color"),
                    value: _colors.contains(_selectedColor)?_selectedColor:null,
                      items: _colors.map((value) {
                        return DropdownMenuItem<String>(
                          value: value , //select value
                          child: 
                          
                          Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(3),
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(width:0.2,color:Colors.grey),
                                    color: Color(int.parse(value.toString().replaceAll("#", "0xff"))),
                                    borderRadius: BorderRadius.circular(50)
                                    ),
                                // child:
                                ),

                              SizedBox(width: 10,),
                              Text(colorsPicker[value],style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),),
                            ],
                          ),
                        
                        );
                      }).toList(),
                      onChanged: (_) {
                        print(_);
                      setState(() {
                          _selectedColor = _;
                      }); 
                      },
                    ),                  
                ],
              ):SizedBox()

            ],
          ),

          actions: <Widget>[
            !isSubmit?
            FlatButton(
              onPressed: (){
                    setState(() {
                      isSubmit = true;
                    });
                isNew?
                BlocProvider.of<SubproductBloc>(context).add(
                  OnAddSubProductColor(this.widget.id,_size,_selectedColor,_qty.text,_mrp.text,_list.text)
                )
                :
                _updateSubProduct(_id,_mrp.text,_list.text,_qty.text,product);

              },
              child:isNew?Text("Add New"): Text("Update",style: TextStyle(color: Colors.green),)

              ):SizedBox(width:1),


            !isSubmit?FlatButton(
              // onPressed: null,
              onPressed: ()=>Navigator.of(context).pop(),
              child: Text("Cancel",style: TextStyle(color: Colors.grey),)
              ):SizedBox(width: 1,)
          ],

        );
        },
        ));
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
                        // padding: EdgeInsets.only(top:20,bottom:15,left:10,right:10),
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
                                              padding: EdgeInsets.only(top:15,bottom:15,left:10,right:10),
                                              // padding: EdgeInsets.all(10),
                                              // color: Colors.red,
                                              child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[


                                                // Text(products[i].product[j].color),




                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.,
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
                                                      style: TextStyle(color: Colors.black,fontSize: 18),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Text("("+products[i].product[j].qty.toString()+")",style: TextStyle(fontSize: 17,color: Colors.grey),)
                                                    // SizedBox(width: 10,),
                                                    // Icon(Icons.add_circle_outline,color: Colors.grey,)
                                                  ],
                                                ),







                                                Row(
                                                  children: <Widget>[
                                                    Text("\u20B9 "+ products[i].product[j].mrp.toString(),
                                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
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
                                Center(child: 
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        _size = products[i].size;
                                        isNew = true;
                                      });
                                      
                                      // products[j];
                                      _showDialog();
                                    },
                                    child: Text('Add Color',style: TextStyle(color: Colors.green),))
                                  
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
                  setState(() {
                    isNew = false;
                  });
                  Navigator.pop(context);
                  _showDialog(product:prd);
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