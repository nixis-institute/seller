import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/createProduct.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/searchPage.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/subProductList.dart';

import '../AddProductScreen.dart';

class ProductScreen extends StatefulWidget{
  // String id,name;
  // ProductScreen(this.id);
  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin
{

  ProductsBloc _productsBloc;
  TabController tabController;
  List<ProductWithStatus> duplicate = [];
  List<ProductWithStatus> all_duplicate = [];
  void initState()
  {

    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(
      // OnProductType(this.widget.id)
      OnProducts()
    );
    // _productsBloc = ProductsBloc();
    // _productsBloc.add(
    // OnProducts()
    // );

    int _currentIndex = 0;
    LoadProductsWithStatus p;
    tabController = TabController(vsync:this, length: 3);
    // final state = (_productsBloc.state as LoadProductsWithStatus);
    // print(p);
    // tabController = TabController(vsync:this, length: state.products.length);
    
    // tabController = TabController(vsync:this, length: p.products.length);
  
  
  }
  Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
// void filterSearchResult(query){
//   List<Product> searchList= [];
//   searchList.addAll(duplicate);
//   if(query.empty){
//     List<Product> listData = [];
//     searchList.forEach((item){
//       if(item.name.contains(query)){
//         listData.add(item);
//       }
//     });

//     setState(() {
//       all_duplicate.clear();
//       all_duplicate.addAll(listData);
//     });
//     return;
//   }
//   else{
//     setState(() {
//       all_duplicate.clear();
//       all_duplicate.addAll(duplicate);
//     });
//   }

// }

_showSheet(context, Product pd){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context){
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit"),
            ),


            ListTile(
              onTap: (){
                // pd.inStock?
                BlocProvider.of<ProductsBloc>(context).add(
                  pd.isActive==false && pd.inStock == false ? MakeItOutOfStock(pd):
                  pd.isActive==false && pd.inStock == true ?MakeItOutOfStock(pd):
                  pd.isActive==false && pd.inStock==false?
                  MakeItInStock(pd):MakeItInActive(pd)
                );
                Navigator.pop(context);
              },
              leading: Icon(
                // pd.inStock?Icons.subdirectory_arrow_right:Icons.subdirectory_arrow_left
                pd.isActive==false && pd.inStock ==false ?Icons.arrow_upward:
                pd.isActive==false && pd.inStock == true?Icons.arrow_upward:
                pd.isActive==false && pd.inStock==false?Icons.arrow_downward:Icons.arrow_forward
                
                ),
                title: Text(
                  pd.isActive==false && pd.inStock ==false ?"Out Of Stock":
                pd.isActive==false && pd.inStock == true?"Out Of Stock":
                pd.isActive==false && pd.inStock==false?"In Stock":"In Active"
                
                ),
            ),

            ListTile(
              onTap: (){
                // pd.inStock?
                BlocProvider.of<ProductsBloc>(context).add(
                  pd.isActive==true && pd.inStock == false ?MakeItInStock(pd):
                  pd.isActive==true && pd.inStock==true?
                  MakeItOutOfStock(pd):MakeItInStock(pd)
                   
                  // pd.inStock?
                  // MakeItInActive(pd):MakeItInStock(pd)
                );
                Navigator.pop(context);
              },
              leading: Icon(
                pd.isActive==true && pd.inStock == false ?Icons.arrow_downward:
                pd.isActive==true && pd.inStock==true?Icons.arrow_upward:Icons.arrow_downward
                // pd.inStock?Icons.subdirectory_arrow_right:Icons.subdirectory_arrow_left
                
                ),
              title: Text(
                pd.isActive==true && pd.inStock == false?"In Stock":
                pd.isActive==true && pd.inStock==true?"Out of Stock":"InStock"
                // pd.isActive?"InActive ":"InStock"
                
                ),
            ),

            // ListTile(
            //   leading: Icon(Icons.edit),
            //   title: Text("InActive"),
            // ),            
          ],
        ),
      );
    }
  );
}




  @override
  Widget build(BuildContext context)
  {
  
  //  final StatsBloc statsBloc = BlocProvider.of<StatsBloc>(context);
   return BlocBuilder<ProductsBloc,ProductsState>(
     bloc: _productsBloc,
     builder: (context,state){
       if(state is ProductsLoading)
       {
         return 
         
         Container(
           color: Colors.white,
           child: Center(child:CircularProgressIndicator()));
       }
       if(state is LoadProductsWithStatus){
        // tabController = TabController(vsync:this, length: state.products.length);

      tabController.addListener(() {
        // print(tabController.index);
        // print(tabController.indexIsChanging);
        // setState(() {
        //   _currentIndex = tabController.index;
        //   endCursor = product[_currentIndex].endCursor;
        //   hasNextPage = product[_currentIndex].hasNextPage;
        //   id = product[_currentIndex].id;
        // });
      });
      // print("sdf-----------------------------------R"+state.products.length.toString());
         return 

         Scaffold(
          //  appBar: AppBar(
          //    title:Text("Product"),
          //    bottom: TabBar(
          //      controller: tabController,
          //      tabs: List.generate(state.products.length, (index)=>
          //       Tab(
          //         child: Text(state.products[index].status),
          //       ),
          //      ),
               
          //      ),


          //    ),
            
            
            
            // body: Center(child: Text("loaded..."),),

              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton.extended(

              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: 
                (_)=>AddProduct(
                
                // state.products[index].id,state.products[index].name
                )));  

              },
              tooltip: 'Add New Product',
              icon: Icon(Icons.add),
              label: Text("Add Product"),
              // child: Icon(Icons.add),
            ),


            body: DefaultTabController(
                  length: state.products.length,
                  child: NestedScrollView(
                  
                  // controller: ,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                    return <Widget>[
                      SliverAppBar(
                        actions: <Widget>[
                          IconButton(icon: Icon(Icons.search,color: Colors.white,), 
                            onPressed: ()=>Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (_)=>SearchPage())
                              )
                            
                          )
                        ],

                        snap: true,
                        title: Text("Products"),
                        pinned: true,
                        floating: true,                      
                        // forceElevated: innerBoxIsScrolled,
                        bottom: TabBar(
                        isScrollable: true,
                        controller: tabController,
                        tabs: List.generate(state.products.length, (index)=>
                          Tab(
                            child: Text(state.products[index].status+"("+state.products[index].products.length.toString()+")"),
                          ),
                        ),
                        
                        ),
                      )
                    ];
                  },
                  
                  body: TabBarView(
                  controller: tabController,
                  
                  children: List.generate(state.products.length, (index){

                    // setState(() {
                    //   duplicate = state.products[index] as List<Product>;
                    // });
                    var _allproducts = state.products[index].products;
                    // all_duplicate = _allproducts;
                    // setState(() {
                    //   duplicate = _allproducts;
                    //   all_duplicate = _allproducts;
                    // });

                    return  Container(
                      // color: Colors.green,
                      color:Colors.white,
                      alignment: Alignment.topCenter,
                      child: 
                      
                      Column(
                        children: <Widget>[
                          // Container(
                          //   color: Colors.white,
                          //   padding: EdgeInsets.only(left:5,right:5,top:5),
                          //   child: TextFormField(
                          //     // focusNode: true
                          //     onChanged: (value){
                          //       // filterSearchResult(value);
                          //     },

                          //     autofocus: false,
                          //     decoration: InputDecoration(
                          //       filled: true,
                                
                          //       prefixIcon: Icon(Icons.search),
                          //       contentPadding: const EdgeInsets.only(left: 1.0,top:15,),
                          //       fillColor: Colors.grey[100],
                          //       hintText: "Search..",
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(25.7),
                          //       ),

                          //       enabledBorder: UnderlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(25.7),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Text("sdf"),


                          Expanded(
                                  child: MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: 
                                ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) => Divider(
                                indent: 55,
                                endIndent: 0,
                                color: Colors.grey[400],
                                // height: 0,
                                ),
                                itemCount: _allproducts.length,
                                itemBuilder:(BuildContext context,int i){
                                
                                // setState(() {
                                //   duplicate = state.products;
                                // });
                                
                                  Product product =  _allproducts[i];
                                  return 
                                  Container(
                                    // margin: EdgeInsets.only(top:10),
                                    color: Colors.white,
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.push(context, 
                                          MaterialPageRoute(builder: (_)=>SubProductScreen(
                                            product.id,product.name,
                                            // product.imageLink
                                        )));
                                      },
                                      // trailing: Text(product.productSize.toString()),
                                      trailing: IconButton(
                                        icon: Icon(Icons.more_horiz), 
                                        onPressed: (){
                                          _showSheet(context,product);
                                        }
                                        ),

                                      leading: CachedNetworkImage(
                                        // height: 40,
                                        imageUrl:server_url+"/media/"+product.imageLink.toString() ),
                                      title: Text(product.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                      subtitle: Text(product.brand),
                                    ),
                                  );
                   
                                }
                                
                                ),
                            ),
                          ),
                        ],
                      ),
                  
                  
                  
                      );
                    // Center(child: Text(state.products[index].status));
                  })
                  
                  ),
              ),
            ),
         
         
         
         );



       }
       else{
         return Center(child: Text("someting went wrong"),);
       }
     },
   );
   
   
    // return Scaffold(
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //   floatingActionButton: FloatingActionButton.extended(

      //   onPressed: (){
      //     // Navigator.push(context, MaterialPageRoute(builder: 
      //     // (_)=>CreateProductScreen(
          
      //     // // state.products[index].id,state.products[index].name
      //     // )));  

      //   },
      //   tooltip: 'Increment',
      //   icon: Icon(Icons.add),
      //   label: Text("Add Product"),
      //   // child: Icon(Icons.add),
      // ),

    //   appBar: AppBar(
        
    //     title: Text("Products"),

        
    //     // BlocBuilder<ProductsBloc,ProductsState>(
    //     //   bloc: _productsBloc,
    //     //   builder: (context,state){
    //     //     if(state is LoadProductsWithStatus){
    //     //       return  
    //     //       TabBar(
    //     //       isScrollable: true,
    //     //       controller: tabController,
    //     //       tabs: List.generate(state.products.length , (index)=>
    //     //         Tab(
    //     //             child: Text(state.products[index].status),
    //     //           ),
    //     //         )          
    //     //       );
    //     //     }   
    //     //     else{
    //     //       return Text("loading...");
    //     //     } 
    //     //   },
    //     // )

        
        



    //   // body: 
    //   // BlocBuilder<ProductsBloc,ProductsState>(
    //   //   bloc: _productsBloc,
    //   //   builder: (context,state){
    //   //     if(state is ProductsLoading) {
    //   //       return Center(
    //   //         child: Text("loading...."),
    //   //       );
    //   //     }
    //   //     else if(state is LoadProductsWithStatus){
    //   //       // return Text("loadin...");
    //   //     return TabBarView(
    //   //       controller: tabController,
    //   //       children: List.generate(state.products.length, (index){
    //   //         return Center(child: Text(state.products[index].status));
    //   //       }
    //   //     )
    //   //     );

    //   //       // return Container(
    //   //       // color: Colors.white,
    //   //       // // height: 100,
    //   //       // child: ListView.separated(
    //   //       //   separatorBuilder: (context, index) => Divider(
    //   //       //   color: Colors.grey[400],
    //   //       //   height: 1,
    //   //       //   ),
    //   //       //   itemCount: state.products.length,
    //   //       //   itemBuilder: (context,index)
    //   //       //   {
    //   //       //     return InkWell(
                    
    //   //       //         onTap: (){
    //   //       //           Navigator.push(context, MaterialPageRoute(builder: 
    //   //       //           (_)=>SubProductScreen(
    //   //       //             state.products[index].id,state.products[index].name
    //   //       //           )));
    //   //       //         },
                    
                    
    //   //       //         child: Container(
    //   //       //         height: 100,
    //   //       //         child: Row(
    //   //       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //       //           children: <Widget>[

    //   //       //             Container(
    //   //       //               width: 50,
    //   //       //               child: 
    //   //       //               CachedNetworkImage(
    //   //       //                 // height: 100,
    //   //       //                 imageUrl: server_url+"/media/"+state.products[index].imageLink.toString()
    //   //       //                 )
    //   //       //               // Icon(Icons.shopping_cart),

    //   //       //             ),

    //   //       //             Expanded(
    //   //       //               child: 
    //   //       //               SingleChildScrollView(
    //   //       //                 physics: ScrollPhysics(),
    //   //       //                 // alignment:Alignment.center,
    //   //       //                 child: Column(
    //   //       //                   mainAxisAlignment: MainAxisAlignment.center,
    //   //       //                   crossAxisAlignment: CrossAxisAlignment.start,
    //   //       //                   children: <Widget>[
    //   //       //                     Text(
    //   //       //                       state.products[index].name,
    //   //       //                       overflow: TextOverflow.ellipsis, 
    //   //       //                       style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold),
    //   //       //                       ),
                                
    //   //       //                       // SizedBox(height: 50,
    //   //       //                       //      child: Row(
    //   //       //                       //        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //       //                       //        children: <Widget>[
    //   //       //                       //          Container(
    //   //       //                       //           //  color: Colors.red,
    //   //       //                       //            child: ListView.builder(
    //   //       //                       //            physics: NeverScrollableScrollPhysics(),
    //   //       //                       //            shrinkWrap: true,
    //   //       //                       //            scrollDirection: Axis.horizontal,
    //   //       //                       //            itemCount: state.products[index].sizes.length,
    //   //       //                       //            itemBuilder: (context,i)
    //   //       //                       //            {
    //   //       //                       //              return Container(
    //   //       //                       //               //  height: 30,
    //   //       //                       //               //  width: 30,
    //   //       //                       //                decoration: BoxDecoration(
    //   //       //                       //                 //  color: Colors.grey,
    //   //       //                       //                  borderRadius: BorderRadius.circular(50)
    //   //       //                       //                ),
    //   //       //                       //                padding: const EdgeInsets.only(right:8.0,top:8),

    //   //       //                       //                child: Text(
    //   //       //                       //                  state.products[index].sizes[i].toString(),
    //   //       //                       //                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),
    //   //       //                       //                  ),
    //   //       //                       //              );
    //   //       //                       //            }
    //   //       //                       //            ),
    //   //       //                       //          ),


    //   //       //                       //          Container(
    //   //       //                       //           //  color: Colors.red,
    //   //       //                       //            margin: EdgeInsets.only(right:10),
    //   //       //                       //            height: 30,
    //   //       //                       //           //  width: 20,
    //   //       //                       //            child: ListView.builder(
    //   //       //                       //            physics: NeverScrollableScrollPhysics(),
    //   //       //                       //            shrinkWrap: true,
    //   //       //                       //            scrollDirection: Axis.horizontal,
    //   //       //                       //            itemCount: state.products[index].colors.length,
    //   //       //                       //            itemBuilder: (context,i)
    //   //       //                       //            {
    //   //       //                       //              return Container(
    //   //       //                       //               //  height: 10,
    //   //       //                       //                width: 30,
    //   //       //                       //                decoration: BoxDecoration(
    //   //       //                       //                  border: Border.all(width:0.2,color:Colors.grey),
    //   //       //                       //                  color: Color(int.parse(state.products[index].colors[i].toString().replaceAll("#", "0xff"))),
    //   //       //                       //                  borderRadius: BorderRadius.circular(50)
    //   //       //                       //                ),
    //   //       //                       //                margin: EdgeInsets.only(left:5),

    //   //       //                       //              );
    //   //       //                       //            }
    //   //       //                       //            ),
    //   //       //                       //          ),

    //   //       //                       //        ],
    //   //       //                       //      ),
    //   //       //                       // ),
                                

    //   //       //                   ],
    //   //       //                 ),
    //   //       //               )),
                        
                        
    //   //       //             Container(
    //   //       //               width: 50,
    //   //       //                 child: Row(
    //   //       //                 children: <Widget>[
    //   //       //                   // Icon(Icons),
    //   //       //                   IconButton(
    //   //       //                     icon:Icon(Icons.edit,color: Colors.green[500],), 
    //   //       //                     onPressed: (){                                
    //   //       //                       // print("edit...");
    //   //       //                     }
    //   //       //                     ),
    //   //       //                 ],
    //   //       //               ),
    //   //       //             ),
    //   //       //           ],
    //   //       //         ),
    //   //       //       ),
    //   //       //     );
    //   //       //   } 
              
    //   //       //   ),
    //   //       //   );
        
    //   //     }
    //   //     else{
    //   //       return Center(
    //   //         child: Text("else "),
    //   //       );            
    //   //     }
    //   //   },
    //   // ),




    // );
  }
}