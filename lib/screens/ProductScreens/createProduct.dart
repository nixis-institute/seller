import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';

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
  
  
  void createProduct(){
    // _productsBloc = ProductsBloc();
    print("clicked!");
    _productsBloc.add(
      OnCreateParentProduct(this.widget.typeId,prdName.text, brand.text, sortDesc.text, longDesc.text)
    );
  }



  ProductsBloc _productsBloc;
  
  @override
  void initState(){
    super.initState();
    _productsBloc = ProductsBloc();
  }  
  
  Widget build(BuildContext context)
  {
    return  
    Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          subhead: TextStyle(color:Colors.grey),
          headline: TextStyle(color:Colors.grey),
          title: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
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
            return Center(child: Text("Product is Loaded"),);
          }
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


            ],
          ),
        );
      
        }
          

      ),
    );
  }
}