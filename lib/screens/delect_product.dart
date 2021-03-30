import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:hackathon_one/model/get_category.dart';
import 'package:hackathon_one/model/model_for_products/update_product.dart';
import 'package:hackathon_one/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';




class UpdateProdutClass extends StatefulWidget {
  UpdateProdutClass({this.getProdctForSecondScreen , this.catIndx , this.indx});
  Product getProdctForSecondScreen = Product();
  final indx ; final catIndx ;
  @override
  _UpdateProdutClassState createState() => _UpdateProdutClassState();
}

class _UpdateProdutClassState extends State<UpdateProdutClass> {
  Dio dio = new Dio();
  var data= "";
  dynamic res ;
  UpdateProduct updateProduct= UpdateProduct();
  final TextController = TextEditingController();
  final descriptionContoller = TextEditingController();
  final priceCotroller = TextEditingController();
  final discountcontroller = TextEditingController();
  final ratingController = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  File imge ;


  void GalleryClick ()  async{
    File image;

    var galleryPicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if( galleryPicker != null){
      setState(() {
        image=galleryPicker;
        imge = galleryPicker;
        print(imge.path);
      });
    }

  }
  void cameraClick ()  async{
    File image;
    var cameraPicker = await ImagePicker.pickImage(source: ImageSource.camera);

    if( cameraPicker != null){
      setState(() {
        image=cameraPicker;
        imge = cameraPicker;
        print(imge.path);
      });
    }

  }
  void Create() async {
    String  text = TextController.text.trim();
    String  desc = descriptionContoller.text.trim();
    String  price = priceCotroller.text.trim();
    String  disc = discountcontroller.text.trim();
    String  rating = ratingController.text.trim();
    String  category = categoryIdcontoller.text.trim();

    // File image;
    // var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);

    try {
      // String filename= image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name" : text,
        "description" : desc,
        "price" : price,
        "discount" : (disc),
        "rating" : (rating),

        "category_id"  : "${widget.catIndx}",
        "product_id":"${widget.indx}",
        "image" : await MultipartFile.fromFile( imge.path )


      });
      Response response =
      await Dio().patch("http://jayanthigaddameedi.pythonanywhere.com/product/" , data: formData);
      setState(() {
        updateProduct = updateProductFromMap(jsonEncode(response.data));

        print(response.data);
        res=response.statusMessage;
        Fluttertoast.showToast(msg: response.data["message"]);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  // void Createone() async{
  //   File image;
  //       var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
  //       if(imagePicker != null){
  //         setState(() {
  //           image=imagePicker;
  //         });
  //       }
  //       try{
  //         String filename= image.path.split('/').last;
  //         FormData formData=new FormData.fromMap({
  //           "imageUrl":
  //          await MultipartFile.fromFile(image.path,filename: filename,
  //            contentType: MediaType('imageUrl','png')
  //          ),
  //           // "type":"image/png"
  //
  //         });
  //         Response response = await dio.post("http://sowmyamatsa.pythonanywhere.com/category/",data: formData);
  //         setState(() {
  //           createcatg = getpostFromJson(jsonEncode(response.data));
  //
  //           print(response.data);
  //         });
  //       }
  //       catch(e){
  //         print(e);
  //       }
  // }
  // void delete()async{
  //   String id = TextController.text.trim();
  //   try{
  //     Response response;
  //     Dio dio = new Dio();
  //     response = await dio.delete("http://sowmyamatsa.pythonanywhere.com/category?id=$id");
  //     print(response.data.toString());
  //   }
  //   catch (e){
  //     setState(() {
  //       print(e);
  //     });
  //   }
  // }
  @override
  void initState() {
    Create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //     File image;
    //     var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    //     if(imagePicker != null){
    //       setState(() {
    //         image=imagePicker;
    //       });
    //     }
    //     try{
    //       String filename= image.path.split('/').last;
    //       FormData formData=new FormData.fromMap({
    //         "image":
    //        await MultipartFile.fromFile(image.path,filename: filename,
    //          contentType: MediaType('image','png')
    //        ),
    //         "type":"image/png"
    //
    //       });
    //       Response response = await dio.post("http://sowmyamatsa.pythonanywhere.com/category/",data: formData,options: Options(
    //         headers: {
    //           "accept":"/",
    //           "Authorization":"Bearer accesstoken",
    //           "content-type":"multipart/form-data"
    //         }
    //       ));
    //     }
    //     catch(e){
    //       print(e);
    //     }
    //   },
    return MaterialApp(
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async{
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(

                padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Update Product"),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: TextController,
                        decoration: InputDecoration(
                            hintText:"name"
                          // hintText: widget.getProdctForSecondScreen.productName
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: descriptionContoller,
                        decoration: InputDecoration(
                            hintText:"description"
                          // hintText: widget.getProdctForSecondScreen.productDescription
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: priceCotroller,
                        decoration: InputDecoration(
                            hintText: "price"
                          // hintText: "${widget.getProdctForSecondScreen.productPrice}"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: discountcontroller,
                        decoration: InputDecoration(
                            hintText: "discount"
                          // hintText: "${widget.getProdctForSecondScreen.productDiscount}"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: ratingController,
                        decoration: InputDecoration(
                            hintText: "rating"
                          // hintText: "${widget.getProdctForSecondScreen.productRating}"
                        ),
                      ),
                    ),SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        child: Text('Click toUpload Image'),
                        onPressed: (){
                          setState(() {
                            GalleryClick();
                          },
                          );
                        },
                        color: Colors.blueGrey[50],
                      ),
                    ),
                    SizedBox(height: 15,),

                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        child: Text("click to update"),
                        onPressed: (){
                          Create();Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
                          setState(() {

                          });

                        },
                        color: Colors.blueGrey[50],),

                    ),

                    //
                    // img.path == null ? Text("no data")  :    Text("test --- ${img.path}"),
                    //
                    res == null ?Text("   ")  :    Text("test --- ${res}"),
                    res == null ?Text("   ")  :    Text("test --- ${res["status"]}"),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: TextField(
                    //     onChanged: (id) {
                    //       print("delete id: $id");
                    //     },
                    //   ),
                    // ),
                    // Center(
                    //   child: RaisedButton(
                    //     child: Text('delete Here'),
                    //     onPressed: (){
                    //       setState(() {
                    //         print("'successful");
                    //         delete();
                    //       });
                    //     },
                    //   ),
                    // ),
                    // imge == null ? Text("uploading"):   Text( " File     ${imge}"),
                    // SizedBox(height: 10,),
                    // imge == null ? Text("uploading"):   Text("File with Path     ${imge.path}"),
                    Container(
                      height: 200,
                      width: 200,
                      child:  imge == null ? Text("  "):   Image.file(imge),
                    )


                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}