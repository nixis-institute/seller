import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shopping_junction_seller/BLOC/bloc/product_bloc.dart';
import 'package:shopping_junction_seller/screens/AddProductScreen.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/ImageUploadScreen.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/productList.dart';
// import 'package:shopping_junction_seller/BLOC/Bloc/login_bloc.dart';
// import 'package:shopping_junction_seller/BLOC/event/login_event.dart';
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  // ProductBloc _productBloc;

  @override
  void initState(){
    
    // _productBloc = ProductBloc();
    // _productBloc = BlocProvider.of<ProductBloc>(context);
    // _productBloc.add(AppStarted());
    // p = ProductBloc();
  }


  Widget build(BuildContext context){
        return Scaffold(
        appBar:AppBar(
          title: Text("Seller"),
        ) ,

        body: Container(
              child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 2/2,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                      Navigator.of(context).pushNamed('/productList');
                    //   Navigator.push(context, 
                    //   MaterialPageRoute(builder: (_)=>ProductScreen(
                    // )));
                      },
                      child: Card(
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Create Products",style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
                            Icon(FontAwesomeIcons.plusSquare)
                          ],
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, 
                      MaterialPageRoute(builder: (_)=>ImageScreen(
                    )));                          
                        },
                        child: Card(
                        child: Center(child: Text("Orders")),
                      ),
                    ),
                    Card(
                      child: Center(child: Text("Shipment")),
                    ),
                    Card(
                      child: Center(child: Text("Message")),
                    ),                                                            
  
                  ]

                ),
              
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: state.products.length,
              //   itemBuilder: (context,index){
              //     return ListTile(
              //       title: Text(
              //         state.products[index].name
              //       ),
              //     );
              //   }
              //   ),
            ),
          

        // body: BlocBuilder<ProductBloc,ProductState>(
        //     bloc: _productBloc,
        //     builder: (context,state){

        //     if(state is ProductLoading)
        //     {
        //       return Center(child: CircularProgressIndicator() );
        //     }
        //     else if(state is ProductLoaded)
        //     {

        //     return Container(
        //       child: GridView.count(
        //           crossAxisCount: 2,
        //           shrinkWrap: true,
        //           childAspectRatio: 2/2,
        //           children: <Widget>[
        //             InkWell(
        //               onTap: (){
        //               Navigator.of(context).pushNamed('/productList');
        //             //   Navigator.push(context, 
        //             //   MaterialPageRoute(builder: (_)=>ProductScreen(
        //             // )));
        //               },
        //               child: Card(
        //                 child: Center(child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     Text("Create Products",style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
        //                     Icon(FontAwesomeIcons.plusSquare)
        //                   ],
        //                 )),
        //               ),
        //             ),
        //             InkWell(
        //               onTap: (){
        //                 Navigator.push(context, 
        //               MaterialPageRoute(builder: (_)=>ImageScreen(
        //             )));                          
        //                 },
        //                 child: Card(
        //                 child: Center(child: Text("Orders")),
        //               ),
        //             ),
        //             Card(
        //               child: Center(child: Text("Shipment")),
        //             ),
        //             Card(
        //               child: Center(child: Text("Message")),
        //             ),                                                            
  
        //           ]

        //         ),
              
        //       // child: ListView.builder(
        //       //   shrinkWrap: true,
        //       //   itemCount: state.products.length,
        //       //   itemBuilder: (context,index){
        //       //     return ListTile(
        //       //       title: Text(
        //       //         state.products[index].name
        //       //       ),
        //       //     );
        //       //   }
        //       //   ),
        //     );
          
          
        //   }
        //   else if(state is FetchProduct){
        //     return Center(child: 
        //     InkWell(
        //       onTap: (){
        //         _productBloc.add(AppStarted());
        //       },
        //       child: Text("product Fetch")),);
        //   }

        //   else{
        //     return Center(child: Text("product uninitialied"),);
        //   }
            
            

        //     }

       
        // ),
      
      
      );
  }
}