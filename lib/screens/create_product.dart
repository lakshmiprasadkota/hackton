import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hackathon_one/model/model_for_products/create_product.dart';
import 'package:hackathon_one/screens/home_screen.dart';

import 'package:image_picker/image_picker.dart';




class AddProducts extends StatefulWidget {
  AddProducts({this.indx });
  final int indx ;
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Dio dio = new Dio();
  var data= "";
  dynamic res ;
  CreteProduct createcatg= CreteProduct();
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


    // File image;
    // var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);

    try {
      // String filename= image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name" : text,
        "description" : desc,
        "price" : double.parse(price),
        "discount" : double.parse(disc),
        "rating" : double.parse(rating),
        "category_id" : widget.indx,
        "image" : await MultipartFile.fromFile( imge.path )


      });
      Response response =
      await Dio().post("http://jayanthigaddameedi.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = creteProductFromMap(jsonEncode(response.data));

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

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async{
        // ),
        appBar: AppBar(
         backgroundColor: Colors.orange,
          elevation: 0,
          leading:  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          },),
          title:  Text("Create Product"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(

                padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: TextController,
                        decoration: InputDecoration(
                            hintText: "Enter Name"
                        ),
                      ),
                    ),
SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: descriptionContoller,
                        decoration: InputDecoration(
                            hintText: "Enter Description"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: priceCotroller,
                        decoration: InputDecoration(
                            hintText: "Enter Price"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: discountcontroller,
                        decoration: InputDecoration(
                            hintText: "Enter discount"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: ratingController,
                        decoration: InputDecoration(

                            hintText: "Enter rating "
                        ),
                      ),
                    ),SizedBox(height: 15,),
                   SizedBox(height: 15,),

                    Container(

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors :[
                            Colors.orange,
                            // Color(0xffda5053),
                            Colors.white
                          ],
                        ) ,
                      ),
                      alignment: Alignment.center,
                      child: FlatButton(

                        child: Text('Click to Upload Image'),
                        onPressed: (){
                          setState(() {
                            GalleryClick();
                          },
                          );

                        },

                      ),
                    ),
                    SizedBox(height: 15,),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors :[
                            Colors.orange,
                            // Color(0xffda5053),
                            Colors.white
                          ],
                        ) ,
                      ),
                      alignment: Alignment.center,
                      child: FlatButton(
                          child: Text("Create Product " , style: TextStyle(color: Colors.black , ),),
                          onPressed: (){
                            Create();
                         Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
                            setState(() {

                            });

                          },
                   ),

                    ),

                    //
                    // img.path == null ? Text("no data")  :    Text("test --- ${img.path}"),
                    //
                    res == null ?Text("   ")  :    Text(res["message"]),

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