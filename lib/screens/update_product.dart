import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



import 'package:hackathon_one/model/get_products.dart';
import 'package:hackathon_one/model/model_for_products/update_product.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';




class UpdateProdutClass extends StatefulWidget {
  UpdateProdutClass({this.getProdctForSecondScreen , this.catIndx , this.indx});
  Products getProdctForSecondScreen = Products();
  final int indx ; final int catIndx ;
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
 bool indicator = false;


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
  void update_product_fun() async {
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
        "price" : (price),
        "discount" : (disc),
        "rating" : (rating),

        "category_id"  : widget.catIndx,
        "product_id": widget.indx,
        "image" : await MultipartFile.fromFile( imge.path )


      });
      Response response =
      await Dio().patch("http://jayanthigaddameedi.pythonanywhere.com/product/" , data: formData);
      setState(() {
        updateProduct = updateProductFromMap(jsonEncode(response.data));

        print(response.data);
        res=response.data;
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
    update_product_fun();
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
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
          },),
          title:  Text("Update Product"),
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

                            hintText: "description"
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
                    ),SizedBox(height: 30,),
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
                        child: Text(" Upload Image" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
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
                      alignment: Alignment.center,
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
                      child: FlatButton(
                        child: Text("Click to Update" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),

                        onPressed: (){
                          update_product_fun();
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
                          setState(() {

                          });

                        },
                     ),

                    ),

                    //
                    // img.path == null ? Text("no data")  :    Text("test --- ${img.path}"),
                    //
                    // res == null ?Text("   ")  :    Text("test --- ${res}"),
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