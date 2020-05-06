import 'dart:io';
// import ''
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';

class ImageScreen extends StatefulWidget{
  @override
  ImageScreenState createState() => ImageScreenState();
}

class ImageScreenState extends State<ImageScreen>
{
  File _image;
  
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }


  Future<FormData> ImageForm() async{
    // Dio dio = new Dio();
    var formData = FormData();
    formData.fields..add(MapEntry("parent_id", "45"));
    formData.files.add(
      MapEntry("large_image", await  MultipartFile.fromFile(_image.path) )
    );

    return formData;
  }


  void Uploading() async{
    Dio dio = new Dio();
    dio.options.baseUrl = "http://localhost:8000/";
    dio.interceptors.add(LogInterceptor());
    Response response;

    var formData = await ImageForm();
    var byte1 = formData.readAsBytes();
    
    response = await dio.post(
      "http://localhost:8000/api/upload/",
      data: await ImageForm(),
    );

    print(response.statusCode);


  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
      appBar: AppBar(title: Text("Upload"),),
      body:Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _image==null?Text("nothing"):
            Container(
              height: 200,
              child: Image.file(_image),
            ),
            InkWell(
              onTap: ()=>Uploading(),
              child: Text("UPload.."))
          ],
          
        ),
      )
    );
  }
}