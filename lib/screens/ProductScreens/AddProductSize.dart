import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_bloc.dart';
// import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
class AddProductSizeScreen extends StatefulWidget{
  String id;
  AddProductSizeScreen(this.id);
  @override
  AddProductSizeScreenState createState() => AddProductSizeScreenState();
}

class AddProductSizeScreenState extends State<AddProductSizeScreen>
{
  // ProductsBloc _productsBloc;
  SubproductBloc _bloc;
  final _mrp = TextEditingController();
  final _size = TextEditingController();
  final _color = TextEditingController();
  final _qty = TextEditingController();
  final _id = TextEditingController();
  final _listPrice = TextEditingController();

  List<String> _locations = ['XL', 'XLL'];
  String _selectedSize;
  List<String> _colors = [];
  String _selectedColor;
  // OnAddVarient

  void initState(){
    colorsPicker.forEach((key,value){
      _colors.add(key);
    });
    
    // _productsBloc = ProductsBloc();
    // _productsBloc.add(
    //   OnAddVarient()
    //   // OnSubProducts(this.widget.id)
    // );

  }
  
  // colorsPicker;


  // colorsPickers

  @override 
  Widget build(BuildContext context){
    return 
      BlocListener<SubproductBloc,SubproductState>(
        // bloc: _productsBloc,
        bloc: _bloc,
        listener: (context,state){
          if(state is LoadSubProduct){
            Navigator.pop(context);
          }
          // Navigator.pop(context);
          // if(state is LoadSubProduct)
          // {
          //   Navigator.pop(context);
          // }
          // if(state is SubProductsLoading ){
          //   // Navigator.pop(context);
          // }
        },

        child: 
        BlocBuilder<SubproductBloc,SubproductState>(
          // bloc: ,
          builder: (context,state){
          if(state is NavigateToPrevious){
            return Center(child: Text("loading.."),);
          }
          
          if(state is LoadSubProduct){
            // var _selectedSize;
            // var _selectedColor;
            // setState(() {
              
            // });
            return Scaffold(
              appBar: AppBar(title: Text("Add Size"),),
                body: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left:30,right:30,top: 10),
                child: Column(
                  children: <Widget>[
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Size",
                          style: TextStyle(
                            fontSize: 17
                          ),
                        ),
                        DropdownButton(
                          hint: Text("Select Size"),
                          value: state.sizes.contains(_selectedSize)?_selectedSize:null,
                            items: state.sizes.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                            setState(() {
                                _selectedSize = _;
                            }); 
                            },
                          ),
                      ],
                    ),
                    
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     hintText: "Size"   
                    //   ),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Color",
                          style: TextStyle(
                              fontSize: 17
                            ),
                            
                        ),

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
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Quantity",
                          style: TextStyle(
                            fontSize: 17
                          ),
                          
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _qty,
                            decoration: InputDecoration(
                              hintText: "Qty"   
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("MRP",
                        style: TextStyle(
                            fontSize: 17
                          ),
                          
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(
                            controller: _mrp,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "MRP"   
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("List Price",
                        style: TextStyle(
                            fontSize: 17
                          ),
                          
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(
                            controller: _listPrice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "List Price"   
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    FlatButton(
                      // shape: ShapeBorder(),
                      color: Colors.blue,
                      onPressed: (){
                        BlocProvider.of<SubproductBloc>(context).add(
                            // OnSubProducts(this.widget.id)
                            OnAddSubProduct(
                              this.widget.id,
                              _selectedSize,
                              _selectedColor,
                              _qty.text,
                              _mrp.text,
                              _listPrice.text,
                              
                            ),
                            
      // OnSubProducts(this.widget.id)
                        );
                        setState(() {
                          _selectedColor = "";
                          _selectedSize = "";

                        });
                        // Navigator.pop(context);
                      }, 
                      child: Text("Create",
                        style: TextStyle(
                          color: Colors.white 
                        ),
                      )
                      )       
                  ],
                ),
              ),
            );  
            }
            else{
              return Scaffold(
                body: Center(child: CircularProgressIndicator(),),
              );
            }
          },
        ),
        
      
          // if(state is SubProductsLoading)
          // {
            
          // }
          // child:Scaffold(
          //   appBar: AppBar(title: Text("SDF"),),
          // );
            
        //     if(state is LoadSubProduct)
        //     {
        //       // print(state.sizes);
        //       Scaffold(
        //         appBar: AppBar(title: Text("Add Size"),),
        //           body: Container(
        //           color: Colors.white,
        //           padding: EdgeInsets.only(left:30,right:30,top: 10),
        //           child: Column(
        //             children: <Widget>[
        //                 Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Text("Size",
        //                     style: TextStyle(
        //                       fontSize: 17
        //                     ),
        //                   ),
        //                   DropdownButton(
        //                     hint: Text("Select Size"),
        //                     value: _selectedSize,
        //                       items: state.sizes.map((String value) {
        //                         return new DropdownMenuItem<String>(
        //                           value: value,
        //                           child: new Text(value),
        //                         );
        //                       }).toList(),
        //                       onChanged: (_) {
        //                       setState(() {
        //                           _selectedSize = _;
        //                       }); 
        //                       },
        //                     ),
        //                 ],
        //               ),
                      
        //               // TextFormField(
        //               //   decoration: InputDecoration(
        //               //     hintText: "Size"   
        //               //   ),
        //               // ),

        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Text("Color",
        //                     style: TextStyle(
        //                         fontSize: 17
        //                       ),
                              
        //                   ),

        //                   DropdownButton(
        //                     hint: Text("Select Color"),
        //                     value: _selectedColor,
        //                       items: _colors.map((value) {
        //                         return DropdownMenuItem<String>(
        //                           value: value , //select value
        //                           child: 
                                  
        //                           Row(
        //                             children: <Widget>[
        //                               Container(
        //                                   padding: EdgeInsets.all(3),
        //                                   height: 20,
        //                                   width: 20,
        //                                   decoration: BoxDecoration(
        //                                     border: Border.all(width:0.2,color:Colors.grey),
        //                                     color: Color(int.parse(value.toString().replaceAll("#", "0xff"))),
        //                                     borderRadius: BorderRadius.circular(50)
        //                                     ),
        //                                 // child:
        //                                 ),

        //                               SizedBox(width: 10,),
        //                               Text(colorsPicker[value],style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),),
        //                             ],
        //                           ),
                                
        //                         );
        //                       }).toList(),
        //                       onChanged: (_) {
        //                         print(_);
        //                       setState(() {
        //                           _selectedColor = _;
        //                       }); 
        //                       },
        //                     ),
        //                 ],
        //               ),


        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Text("Quantity",
        //                     style: TextStyle(
        //                       fontSize: 17
        //                     ),
                            
        //                   ),
        //                   Container(
        //                     width: 100,
        //                     child: TextFormField(
        //                     keyboardType: TextInputType.number,
        //                     controller: _qty,
        //                       decoration: InputDecoration(
        //                         hintText: "Qty"   
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),

        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Text("MRP",
        //                   style: TextStyle(
        //                       fontSize: 17
        //                     ),
                            
        //                   ),
        //                   Container(
        //                     width: 100,
        //                     child: TextFormField(
        //                       controller: _mrp,
        //                       keyboardType: TextInputType.number,
        //                       decoration: InputDecoration(
        //                         hintText: "MRP"   
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),

        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Text("List Price",
        //                   style: TextStyle(
        //                       fontSize: 17
        //                     ),
                            
        //                   ),
        //                   Container(
        //                     width: 100,
        //                     child: TextFormField(
        //                       controller: _listPrice,
        //                       keyboardType: TextInputType.number,
        //                       decoration: InputDecoration(
        //                         hintText: "List Price"   
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //               FlatButton(
        //                 // shape: ShapeBorder(),
        //                 color: Colors.blue,
        //                 onPressed: (){
        //                   BlocProvider.of<SubproductBloc>(context).add(
        //                       // OnSubProducts(this.widget.id)
        //                       OnAddSubProduct(
        //                         this.widget.id,
        //                         _selectedSize,
        //                         _selectedColor,
        //                         _qty.text,
        //                         _mrp.text,
        //                         _listPrice.text,
                                
        //                       ),
        // // OnSubProducts(this.widget.id)
        //                   );
        //                   // Navigator.pop(context);
        //                 }, 
        //                 child: Text("Create",
        //                   style: TextStyle(
        //                     color: Colors.white 
        //                   ),
        //                 )
        //                 )       
        //             ],
        //           ),
        //         ),
        //       );
        //     }


        //     else {
        //       Scaffold(
        //           body: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //       // return Text("sdf");
        //     }
            // else{
            //   return Navigator.pop(context);
            // }
            
          
        );
      
          
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Add Size"),
    //   ),
    //   body: 
      

    //   );  
    }
}