import 'dart:io';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_bloc.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

class ImageScreen extends StatefulWidget{
  SubProduct subProduct;
  ImageScreen(this.subProduct);
  @override
  ImageScreen_ createState() => ImageScreen_();
}

class ImageScreen_ extends State<ImageScreen>{
  @override



  File _image;
  bool isSubmit = false;
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  // List<Asset> images = List<Asset>();

  // Future getImage() async{
  //   List<Asset> resultList = List<Asset>();
  //   try{
  //   resultList = await MultiImagePicker.pickImages(
  //     maxImages: 5,
  //     // enableCamera: true,
      
  //     selectedAssets: images,
  //     cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //     // materialOptions: MaterialOptions(
  //     //   actionBarColor: "#abcdef",
  //     //   actionBarTitle: "Example App",
  //     //   allViewTitle: "All Photos",
  //     //   useDetailsView: false,
  //     //   selectCircleStrokeColor: "#000000",
  //     // )
  //   );
  //   }catch(e){
  //     print(e.toString());
  //   }

  //     setState(() {
  //       images = resultList;
  //     });
    
  // }

  Future<FormData> ImageForm() async{
    // Dio dio = new Dio();
    var formData = FormData();
    formData.fields..add(MapEntry("product_id", this.widget.subProduct.id));
    formData.files.add(
      MapEntry("large_image", await  MultipartFile.fromFile(_image.path) )
    );
    return formData;
  }


  void Uploading() async{
    setState(() {
      isSubmit = true;
    });
    Dio dio = new Dio();
    dio.options.baseUrl = server_url;
    dio.interceptors.add(LogInterceptor());
    Response response;

    var formData = await ImageForm();
    var byte1 = formData.readAsBytes();
    
    response = await dio.post(
      "$server_url/api/subproduct/",
      data: await ImageForm(),
    );

    print(response);
    print(response.data);
    print(response.data["id"] );
    
    String relative_url = response.data["large_image"].replaceAll(server_url+"/media/","");

  setState(() {
    this.widget.subProduct.images.add(
      ProductImage(
        response.data["id"].toString(), 
        relative_url, 
        relative_url.replaceAll("/large/", "/normal/"), 
        relative_url.replaceAll("/large/", "/thumbnail/")
        )
    );    
  });


    BlocProvider.of<SubproductBloc>(context).add(
        OnUpdateSubProductImages(this.widget.subProduct,)
      // OnSubProducts(this.widget.id)
    );
    setState(() {
      isSubmit = false;
      _image = null;
    });
    // Navigator.pop(context);

  }




  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    
      appBar: AppBar(
        title: Text(this.widget.subProduct.size),
      ),
      
      body: 
      ListView(
        children: <Widget>[
        _image ==null?SizedBox():
        Container(
          margin: EdgeInsets.only(left:20,right:20,top:10,bottom:150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                // padding: EdgeInsets.all(10),
                child: Image.file(_image,fit: BoxFit.fitHeight,),
              ),
              InkWell(
                    onTap: (){
                      Uploading();
                      // Navigator.pop(context);
                      },
                    child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:
                    isSubmit?
                    Container(
                      height: 15,
                      width: 15,
                      child:                     
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),strokeWidth: 1.6)
                      ):Text("Upload",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 18),),
                        
                        ),
              ),
              // Container(
              //   padding: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: Colors.green
              //   ),
              //   child: Text("Upload"),
              // )
              // FlatButton(onPressed: null, child: Text("Upload"),splashColor: Colors.green,)

            ],
          ),
        ),
        // GridView.count(
        //   shrinkWrap: true,
        //   childAspectRatio: 2/2,
        //   crossAxisCount: 2,
        //   children: List.generate(1, (index)  {
        //     return Container(
        //       child: Image.file(_image),
        //     );
        //   }),          
        // ),




        this.widget.subProduct.images.isEmpty?Center(child: Text("No Images"),):
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: 2/2,
          crossAxisCount: 2,
          children: List.generate(this.widget.subProduct.images.length, (index)  {
            List<ProductImage> img = this.widget.subProduct.images;
            return Card(
              // elevation: 0,
              child: 
                CachedNetworkImage(
                  imageUrl: server_url+"/media/"+img[index].normalImage
                  )
                // Text(img[index].normalImage)
              ,
            );
          }),
          )
        ],
    )
      




    );
  }
}