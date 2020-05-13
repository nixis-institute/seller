import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

// class DialogService {
//   Function _showDialogListener;
//   Completer _dialogCompleter;  /// Registers a callback function. Typically to show the dialog
//   void registerDialogListener(Function showDialogListener) {
//     _showDialogListener = showDialogListener;
//   }  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
//   Future showDialog() {
//     _dialogCompleter = Completer();
//     _showDialogListener();
//     return _dialogCompleter.future;
//   }  /// Completes the _dialogCompleter to resume the Future's execution call
//   void dialogComplete() {
//     _dialogCompleter.complete();
//     _dialogCompleter = null;
//   }
// }


class ShowDialogBoxWidget extends StatefulWidget{
  // String id;
  // String mrp;
  // String list;
  // String qty;
  Function(SubProduct) callback;
  SubProduct product;
  ShowDialogBoxWidget(this.product,this.callback);
  @override
  ShowDialogBoxWidgetState createState()=>ShowDialogBoxWidgetState();
}

class ShowDialogBoxWidgetState extends State<ShowDialogBoxWidget>{
  
  // DialogService _dialogService = locator<DialogService>();

  bool isSubmit = false;
  
  final _mrp = TextEditingController();
  final _list = TextEditingController();
  final _qty = TextEditingController();

  void _updateSubProduct(id,mrp,list,qty,SubProduct product) async{
    // print("work!!");
    // setState(() {
    //   isSubmit = true;
    // });    
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
        this.widget.product.qty = int.parse(qty);
        this.widget.product.mrp = double.parse(mrp);
        this.widget.product.listPrice = double.parse(list);
        
      });
      // setState(() {
      //   p
      // });
      Navigator.of(context).pop();
      setState(() {
        isSubmit = false;
        this.widget.callback(
          product = this.widget.product
        );
      });

    }

  }
  

  @override
  void initState(){

      _mrp.text = this.widget.product.mrp.toString();
      _list.text = this.widget.product.listPrice.toString();
      _qty.text = this.widget.product.qty.toString();
      this.widget.product.qty = 20;
    // _showDialog(this.widget.product);
  }

  
  Widget build(BuildContext context){
    return AlertDialog(
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
                SizedBox(height:15),
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
                  _updateSubProduct(this.widget.product.id,_mrp.text,_list.text,_qty.text,this.widget.product);

                },
                child: Text("Update",style: TextStyle(color: Colors.green),)
                ):SizedBox(width:1),


              !isSubmit?FlatButton(
                // onPressed: null,
                onPressed: ()
                {
                  // setState(() {
                  //   this.widget.product.qty = 4;    
                  // });
                
                Navigator.of(context).pop();
                },

                child: Text("Cancel",style: TextStyle(color: Colors.grey),)
                ):SizedBox(width: 1,)
            ],

          );
  }
}