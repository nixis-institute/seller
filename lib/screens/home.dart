import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_junction_seller/BLOC/login_bloc/login_bloc.dart';
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
          child: ListView(
              // separatorBuilder: (context, index) => Divider(),
              
              // crossAxisCount: 2,
              // shrinkWrap: true,
              // childAspectRatio: 2/2,
              
              
              children: <Widget>[
                InkWell(
                  onTap: (){
                  Navigator.of(context).pushNamed('/productList');
                //   Navigator.push(context, 
                //   MaterialPageRoute(builder: (_)=>ProductScreen(
                // )));
                  },
                  child: Container(
                    color:Colors.white,
                    

                    child: ListTile(
                      leading: Icon(Icons.add_shopping_cart),
                      title: Text("Stock"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    // child: Center(child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text("Create Products",style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
                    //     Icon(FontAwesomeIcons.plusSquare)
                    //   ],
                    // )),
                  ),
                ),


                InkWell(
                  onTap: (){
                    Navigator.push(context, 
                  MaterialPageRoute(builder: (_)=>ImageScreen(
                )));                          
                    },
                    child: Container(
                      color:Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.card_giftcard),
                      title: Text("Orders"),
                      trailing: Icon(Icons.chevron_right),
                      ),
                    
                  ),
                ),
                Container(
                  color:Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.shopping_basket),
                    title: Text("Shipment"),
                    trailing: Icon(Icons.chevron_right),
                    ),
                ),
                Container(
                  color:Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.message),
                    title: Text("Message"),
                    trailing: Icon(Icons.chevron_right),
                    ),
                ),  
                Container(
                  color:Colors.white,
                  child: ListTile(
                    onTap: (){
                      BlocProvider.of<AuthenticateBloc>(context).add(LoggedOut());
                    },
                    leading: Icon(Icons.power_settings_new,color: Colors.red,),
                    title: Text("Logout",style: TextStyle(color: Colors.red),),
                    trailing: Icon(Icons.subdirectory_arrow_left,color: Colors.red,),
                  ),
                )
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