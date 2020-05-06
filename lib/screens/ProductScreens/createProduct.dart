import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/productList.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/subProductList.dart';
import 'package:shopping_junction_seller/screens/home.dart';

import 'ImageUploadScreen.dart';

class CreateProductScreen extends StatefulWidget{
  @override
  final typeId;
  CreateProductScreen(this.typeId);
  _CreateProduct createState() => _CreateProduct();  
}

class _CreateProduct extends State<CreateProductScreen>
{

  final prdName = TextEditingController();
  final brand = TextEditingController();
  final sortDesc = TextEditingController();
  final longDesc = TextEditingController();
  
  File _image;
  
  
  
  Future<FormData> ImageForm(id) async{
    var formData = FormData();
    formData.fields..add(MapEntry("parent_id", id));
    formData.files.add(
      MapEntry("large_image", await  MultipartFile.fromFile(_image.path) )
    );
    return formData;
  }

  void UploadImage(id,name) async{
    Dio dio = new Dio();

    // dio.options.baseUrl = "http://localhost:8000/";
    dio.options.baseUrl = "http://shoppingjunction.pythonanywhere.com";
    dio.interceptors.add(LogInterceptor());
    Response response;

    response = await dio.post(
      "http://shoppingjunction.pythonanywhere.com/api/upload/",
      data: await ImageForm(id),
    );
    
    if(response.statusCode == 201){
      setState(() {
        imageUploaded = true;
        pid = id;
        prd = name;
      });
      // print("navigation......");
      // Navigator.pushAndRemoveUntil(context,
      //  MaterialPageRoute(builder: (_)=>SubProductScreen(pid, prd)), 
      //  ModalRoute.withName("/")
      //  );
      
      // Navigator.push(context, MaterialPageRoute(builder: 
      //   (_)=>SubProductScreen(pid,prd)
      // )); 
    }
    
    // print(response);

  }
  
  
  
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }


  void createProduct(){
    // _productsBloc = ProductsBloc();
    // print("clicked!");
    setState(() {
      swipBack = false;
    });
    _productsBloc.add(
      OnCreateParentProduct(this.widget.typeId,prdName.text, brand.text, sortDesc.text, longDesc.text)
    );
  }



  ProductsBloc _productsBloc;
  String title="Create New Product";
  bool imageUploaded = false;
  var pid;
  String prd;
  bool swipBack = true;

  @override
  void initState(){
    super.initState();
    _productsBloc = ProductsBloc();
  }  
  
  Widget build(BuildContext context)
  {
    return  


    WillPopScope(
      onWillPop:() async=> swipBack,
      
      
      // onWillPop: ()=>{
      //   Navigator.popUntil(context, ModalRoute.withName("/productList"));
      // },
      
        child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            subhead: TextStyle(color:Colors.grey),
            headline: TextStyle(color:Colors.grey),
            title: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 20
              
              ),
            
            ),

          title: Text("Create New Product",
          // style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
          ),
          backgroundColor: Colors.white,
        elevation: 0,
        ),
        body: BlocBuilder<ProductsBloc,ProductsState>(
          bloc: _productsBloc,
          builder: (context,state){
            if(state is ParentUploadLoading)
            {
              return Center(child: Text("loading....."),);
            }


            if(state is ParentProductLoaded)
            {
              // setState(() {
              //   pid = state.id;
              //   prd = state.name;
              // });
              return Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:20),
                    Text(state.name ,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height:20),
                  
                    _image!=null?
                    InkWell(
                      onTap: ()=>getImage(),
                      child: Text("Add another",style: TextStyle(fontSize: 20),)):SizedBox(),
                    
                    SizedBox(height: 20,),

                    Container(
                      // color: Colors.white,
                      height: 200,
                      child: 
                      _image==null?
                      IconButton(icon: Icon(Icons.add_a_photo),iconSize: 50,color: Colors.grey, onPressed:()=> getImage()):
                      // IconButton(icon:Icons.add_a_photo , size: 50,color: Colors.grey):


                      Image.file(_image)
                      
                      ),
                    
                    SizedBox(height:20),
                    
                    // Text("Upload")
                  
                  _image==null?SizedBox():
                  InkWell(
                      onTap: ()=>UploadImage(state.id,state.name),
                      child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal,width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child:
                      
                      (state is ParentUploadLoading)?
                      Container(
                        height: 15,
                        width: 15,
                        child:                     
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),strokeWidth: 1.6)
                        ):Text("Upload",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),),
                    
                    ),
                  ),



                  ],
                ),
              );
            }

            // if(imageUploaded){
            //   Navigator.push(context, MaterialPageRoute(builder: 
            //   (_)=>SubProductScreen(pid,prd)
            //   ));
            // }

            else
            return 
            Container(
            color: Colors.white,
            padding: EdgeInsets.only(left:15,right:15,top:10),
            child: ListView(
              children: <Widget>[
                // Text("Create New Product",
                // style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 25
                // ),
                // ),
                TextFormField(
                  keyboardType: TextInputType.text,
                    controller: prdName,
                    decoration: InputDecoration(
                      
                      labelText: "Product Name",
                      // border: OutlineInputBorder(
                      //   // borderSide: BorderSide(width: 0.1),
                      //   // borderRadius: BorderRadius.all(Radius.circular(12))
                      // )
                      // hintText: "Product Name",
                      // errorText: _hn?"Please Enter House Number":null,
                    ),
                ),

                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: brand,
                    decoration: InputDecoration(
                      labelText: "Brand",
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 1),
                      //   // borderRadius: BorderRadius.all(Radius.circular(12))
                      // )
                      // hintText: "Brand",
                      // errorText: _hn?"Please Enter House Number":null,
                    ),
                ),

                SizedBox(height: 20,),
                TextFormField(
                  maxLines: null,
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                    controller: sortDesc,
                    decoration: InputDecoration(
                      labelText: "Short Description",
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 1),
                      //   // borderRadius: BorderRadius.all(Radius.circular(12))
                      // )
                      // errorText: _hn?"Please Enter House Number":null,
                    ),
                ),

                SizedBox(height: 20,),
                TextFormField(
                  maxLines: null,
                  minLines: 5,
                  keyboardType: TextInputType.text,
                  controller: longDesc,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Description",
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(width: 1),
                      //   // borderRadius: BorderRadius.all(Radius.circular(12))
                      // )
                      // errorText: _hn?"Please Enter House Number":null,
                    ),
                ),   
                SizedBox(height:20),
                InkWell(
                    onTap: ()=>createProduct(),
                    child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:
                    
                    (state is ParentUploadLoading)?
                    Container(
                      height: 20,
                      width: 20,
                      // color: Colors.red,
                      child: 
                      
                      // if(state is ParentUploadLoading)
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),strokeWidth: 1.6)
                      ):
                    Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  
                  ),
                )
                // FloatingActionButton.(
                  
                //   onPressed: null
                //   )
                ,
                
                InkWell(
                  onTap: (){
                    final PageRouteBuilder _homeRoute = new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return ProductScreen();
                        }
                    );
                    
                    // Navigator.pushAndRemoveUntil(context, _homeRoute, (Route<dynamic> r) => true);

                    
                    Navigator.popUntil(context, ModalRoute.withName("/productList"));


                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    // int count = 0;
                    // Navigator.popUntil(context, (route) {
                    //     return count++ == 4;
                    // });

                    // print(Navigator.defaultRouteName);
                    
                    // Navigator.popUntil(context, ModalRoute.withName("/productList"));

                    // Navigator.popUntil(context, ModalRoute.withName('/home'));

                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //   '/image', 
                          
                        //   ModalRoute.withName('/productList'),
                          
                        //   );
                        // Navigator.pushAndRemoveUntil(context,
                        // MaterialPageRoute(builder: (_)=>
                        // ImageScreen()                      
                        // ), 
                        // (Route<dynamic> route) =>true
                        // );
                  },
                  child: Text("data"))

              ],
            ),
          );
        
          }
            

        ),
      ),
    );
  }
}