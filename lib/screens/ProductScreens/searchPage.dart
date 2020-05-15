import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/search_bloc/search_bloc.dart';
import 'package:shopping_junction_seller/BLOC/search_bloc/search_repository.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/subProductList.dart';


class SearchPage extends StatefulWidget{
  @override
  _SearchPage createState() => _SearchPage();
}
class _SearchPage extends State<SearchPage>
{
  SearchRepository repository = SearchRepository();
  
  final _searchTerm = TextEditingController();
  bool isFound = false;
  List<Product> prdList = [];
  List<Product> pList = [];
  List<CategoryName> catList =[];
  bool searching = false;
  // repository = SearchRepository();

  void initState(){
    super.initState();
  }

Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                key: key,
                backgroundColor: Colors.black54,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10,),
                      Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                    ]),
                  )
                ]));
        });
  }

    // searchForProduct(id) async{
    //   setState(() {
    //     searching = true;
    //   });
    //   var p = await repository.searchProductBySubListId(id);
    //   setState(() {
    //     pList = p;
    //     searching = false;
    //   });
    // }
    // repository.searchProductBySubListId(int)


    _showSheet(context){
      // searching?
      // showModalBottomSheet(
        
      //   context: context, 
      //   builder: (context){
      //     return Container(
      //       child: Wrap(
      //         children: <Widget>[
      //           ListTile(title: Text("Loading..."),)
      //         ],
      //       ),
      //     );
      //   }
      // ):
      
      showModalBottomSheet(
        // useRootNavigator: true,
        // isDismissible: true,
        
        // barrierColor: Colors.red,
        // enableDrag: true,
        // backgroundColor: Colors.red,
        // isScrollControlled: true,
        // isScrollControlled: true,
      // showCupertinoModalPopup(
        context: context,
        builder: (context){
          return  
          // Text(searching.toString());
          
          StatefulBuilder(
              builder: (context, state){
                print(searching.toString());
                return Container(
              // margin: EdgeInsets.only(top:100),
              child: 
              // searching?Wrap(children: <Widget>[ListTile(title: Text("loading..."),)],):
               
               Wrap(
                children: <Widget>[
                  // Text(searching.toString())
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context,index)=>Divider(),
                  itemCount: pList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      leading: CachedNetworkImage(imageUrl: server_url+"/media/"+pList[index].imageLink),
                      title: Text(pList[index].name),
                      subtitle: Text(pList[index].brand),

                    );
                  }
                  
                  ),
                ],
              )
            );
          }
                      
                      
,
          );
        }
      );
    }

final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context){
    // print(searching);
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
            controller: _searchTerm,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.w400 ),
              border: InputBorder.none
            ),
            style:  TextStyle(color:Colors.white,fontWeight: FontWeight.w700 ),
            onChanged: (text){
              if(text.length>2)
              {
                setState(() {
                  isFound = false;
                });
                
                BlocProvider.of<SearchBloc>(context).add(
                      // OnProductType(this.widget.id)
                  OnSearching(text)
                );
                // print(text);
                
              // _searching(text);
              
              }
              else if(text.length==0){
                setState(() {
                  isFound = false;
                  // plist=[];
                });
              }
            },
          ),
          actions: <Widget>[
            BlocBuilder<SearchBloc,SearchState>(
              builder: (context,state){
                if(state is SearchLoading){
                  return 
                      Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height:20,
                          child:CircularProgressIndicator(strokeWidth: 2,valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        ),
                        SizedBox(width: 12,)
                      ],
                    );
                }
                else{
                  return IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      _searchTerm.clear();
                    },
                  );
                }
              },
            )
            
            
            ,

            SizedBox(width: 17,)
          ],
        ),


        // body: ,
        // bottomSheet: BottomSheet(
        //   onClosing: null, builder: null
          
        //   ),







        body: 
        
        BlocListener<SearchBloc,SearchState>(
          listener: (context,state){
            if(state is SearchResult){
              setState(() {
                prdList = state.products;
                catList = state.category;
              });
            }
          },
          
          child: BlocBuilder<SearchBloc,SearchState>(
            builder: (context,state){
                // print(state.products);
                return Container(
                  color: Colors.white,
                  child: state is SearchInitial?Center(child: Icon(Icons.search,color: Colors.grey,size: 50,),):
                  prdList.isEmpty?Center(child: Text("Not Found"),):
                  
                  ListView(
                    children: <Widget>[
                      ListView.separated(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: catList.length,
                        separatorBuilder: (context, index) => Divider(), 
                        itemBuilder: (context,index){
                          // print(catList[index].id);
                          return ListTile(
                            onTap: (){

                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (_)=>ShowProduct(
                                    catList[index].id,
                                    catList[index].name,
                                )));                                 
                                // }
                              // _showSheet(context);
                            },
                            title: Text(catList[index].name),
                            subtitle: Text("Category"),
                            trailing: Container(
                              height: 30,
                              
                              width: 30,
                              alignment: Alignment.center,
                              // padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(catList[index].productSize,style: TextStyle(color:Colors.white),)
                              ),
                          );
                        }, 
                        
                        ),
                        SizedBox(height:10),
                      // Divider(color: Colors.green,),
                      ListView.separated(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(
                          indent: 80,
                        ),
                        itemCount: prdList.length,
                        // itemCount: 2,
                        itemBuilder: (context,index){
                          return Container(
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (_)=>SubProductScreen(
                                    prdList[index].id,
                                    prdList[index].name,
                                    // prdList[index].imageLink
                                )));
                              },
                              leading: CachedNetworkImage(
                                imageUrl: server_url+"/media/"+prdList[index].imageLink
                                
                                ),
                              title: Text(prdList[index].name),
                              subtitle: Text(prdList[index].brand),
                              // trailing: Text(prdList[index].inStock==true?"In":"Out"),
                            ),
                          );
                        }
                        ),
                    ],
                  ),
                );
              
              
            },
          ),
        )

    );
  }
}

class ShowProduct extends StatefulWidget{
  String id;
  String name;
  ShowProduct(this.id,this.name);
  @override 
  _ShowProduct createState() => _ShowProduct();
}

class _ShowProduct extends State<ShowProduct>{
  SearchRepository repository = SearchRepository();
  
  searchForProduct(id) async{
    setState(() {
      searching = true;
    });
    var p = await repository.searchProductBySubListId(id);
    setState(() {
      pList = p;
      searching = false;
    });
  }

  bool searching = true;
  List<Product> pList =[];

  void initState(){
    super.initState();
    searchForProduct(this.widget.id);
  }

  @override
  Widget build(BuildContext content){
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.name),
      ),
      body: searching?Container(child: Center(child: CircularProgressIndicator(),),):
      Container(
        color: Colors.white,
        child: ListView.separated(
          separatorBuilder: (context,index)=>Divider(), 
          itemCount: pList.length,
          itemBuilder: (context,index){
            return Container(
              color: Colors.white,
              child: ListTile(
                  onTap: (){
                    // Navigator.pop(context);
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (_)=>SubProductScreen(
                        pList[index].id,
                        pList[index].name,
                        // pList[index].imageLink
                    )));
                  },
                  leading: CachedNetworkImage(imageUrl: server_url+"/media/"+pList[index].imageLink),
                  title: Text(pList[index].name),
                  subtitle: Text(pList[index].brand),

                ),
            );
          }, 
        ),
      )
    );
  }
}