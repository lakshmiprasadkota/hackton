import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon_one/model/create_category.dart';
import 'package:hackathon_one/model/delect_category.dart';

import 'package:hackathon_one/model/get_category.dart';
import 'package:hackathon_one/model/get_products.dart';
import 'package:hackathon_one/model/model_for_products/del_product.dart';
import 'package:hackathon_one/model/update_category.dart';
import 'package:hackathon_one/screens/hero_profile_details.dart';
import 'package:hackathon_one/screens/single_screen.dart';
import 'package:hackathon_one/screens/update_product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_color/random_color.dart';
import 'dart:io';


import 'create_product.dart';

class HomePage extends StatefulWidget {
  HomePage({this.profilePicVar });
  final File profilePicVar ;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Getcategory> getCategory = List();
  Getproduct getProducts = Getproduct();
  Products getProductsForShare = Products() ;
  DelCategory delCategoryItem = DelCategory();
  DelProduct  delProductvar = DelProduct();
  CreateCategory createProduct = CreateCategory();
  String categoryIndex ;

  UpdateCategory updateCategory = UpdateCategory();
  int delIndex;
  int deleteProductIndex;
  bool indicator = false;
  final createController = TextEditingController();
  final updateNumberController = TextEditingController();
  final updateTextController = TextEditingController();
  dynamic res;
  int pageCount = 0;
  int productCount = 1;
  String showNoOfPageCount = " ";
  int productIndexPass = 1;
  int categoryIndexPass = 1;
  int variIndex;

  // ${variIndex}
  String restwo;

  //controller for create product

  File imageForCreateCategory ;
  File imageForUpdate ;  File profilePicVarHome ;
  String resOfUpdateCategory ;

  void getHttp() async {
    setState(() {
      indicator = true;
    });
    try {
      Response response = await Dio().get(
          "http://jayanthigaddameedi.pythonanywhere.com/category_details/");
      setState(() {
        indicator = false;
        getCategory = getcategoryFromMap(jsonEncode(response.data));
        res = response;
          imageForCreateCategory = null;
        profilePicVarHome  = widget.profilePicVar ;

        variIndex = getCategory[0].categoryId ;
    categoryIndex = getCategory[0].categoryName;
        getHttpTwo();

        print(res);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }

  void getHttpTwo() async {
    setState(() {
      indicator = true;
    });
    try {
      FormData formData = FormData.fromMap({"page": pageCount});
      Response response = await Dio().post(
          "http://jayanthigaddameedi.pythonanywhere.com/products/?category_id=${variIndex}",
          data: formData);
      setState(() {
        indicator = false;
        getProducts = getproductFromMap(jsonEncode(response.data));
        restwo = response.statusMessage;
        print(restwo);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  void createCategory() async {
    String name = createController.text.trim();

    try {

      FormData formData = FormData.fromMap({"name":name ,"image": await MultipartFile.fromFile( imageForCreateCategory.path ) });
      Response response = await Dio().post(
          "http://jayanthigaddameedi.pythonanywhere.com/category/",
          data: formData);
      setState(() {
        delProductvar = delProductFromMap(jsonEncode(response.data));
        restwo = response.data["message"];
        print(restwo);
        Fluttertoast.showToast(msg: restwo);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  void delect_Product() async {
    try {

      FormData formData = FormData.fromMap({"product_id": productIndexPass});
      Response response = await Dio().delete(
          "http://jayanthigaddameedi.pythonanywhere.com/product/",
          data: formData);
      setState(() {
        delProductvar = delProductFromMap(jsonEncode(response.data));
        restwo = response.data["message"];
        print(restwo);
        Fluttertoast.showToast(msg: restwo);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  void deleteCategory() async {
    try {
      FormData formData = FormData.fromMap({"category_id":delIndex });
      Response response = await Dio().delete(
          "http://jayanthigaddameedi.pythonanywhere.com/category/",
          data: formData);
      setState(() {
        delCategoryItem = delCategoryFromMap(jsonEncode(response.data));
        restwo = response.data["message"];
        print(restwo);

      });
      if(response?.statusCode == 200){
       Fluttertoast.showToast(msg: restwo);
      }
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }

  void updateCategoryFunc() async {
    String text = updateTextController.text.trim();

    try {
      FormData formData =
          FormData.fromMap({"category_id": delIndex, "name": text});
      Response response = await Dio().patch(
          "http://jayanthigaddameedi.pythonanywhere.com/category/",
          data: formData);
      setState(() {
        updateCategory = updateCategoryFromMap(jsonEncode(response.data));
        restwo = response.data["message"];

        print(res.data["message"]);
        print("response.statusCode");
        Fluttertoast.showToast(msg: restwo);
        // print("check ---------------- ${response.data["message"]}");
      });
      Fluttertoast.showToast(msg: restwo);
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }



  // void createProductsFunc() async {
  //   String  text = TextController.text.trim();
  //   String  desc = descriptionContoller.text.trim();
  //   String  price = priceCotroller.text.trim();
  //   String  disc = discountcontroller.text.trim();
  //   String  rating = ratingController.text.trim();
  //   String  category = categoryIdcontoller.text.trim();
  //
  //   // File image;
  //   // var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
  //
  //   try {
  //     // String filename= image.path.split('/').last;
  //     FormData formData = FormData.fromMap({
  //       "name" : text,
  //       "description" : desc,
  //       "price" : price,
  //       "discount" : (disc),
  //       "rating" : (rating),
  //       "category_id" : (category),
  //       "image" : await MultipartFile.fromFile( imageForcreateCategory.path )
  //
  //
  //     });
  //     Response response =
  //     await Dio().post("http://jayanthigaddameedi.pythonanywhere.com/product/" , data: formData);
  //     setState(() {
  //       createProductsDioVar = creteProductFromMap(jsonEncode(response.data));
  //
  //       print(response.data);
  //       res=response.statusMessage;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print("error ---> $e");
  //     });
  //     print(e);
  //   }
  // }
  void updateImageCategory ()  async{


    var galleryPicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if( galleryPicker != null){
      setState(() {

      imageForUpdate = galleryPicker;
        print(imageForCreateCategory.path);
      });
    }

  }


  void createImageCategory ()  async{


    var galleryPicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if( galleryPicker != null){
      setState(() {

        imageForCreateCategory = galleryPicker;
        print(imageForCreateCategory.path);
      });
    }

  }
  @override
  void initState() {
    getHttp();




    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(0xff87878e),
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "New York , Usa ",
                    style: TextStyle(
                        color: Color(0xff87878e),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),

                  InkWell(

                    onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HeroProfileDetails(pic: profilePicVarHome ,img: "assets/star.png", )));
                    },

                      child: Hero(
                      tag: 'profile',
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: profilePicVarHome == null ? AssetImage("assets/star.png") :FileImage(profilePicVarHome),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    )
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "search",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff1d1c21),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Color(0x4D3D015B),
                          )
                        ]),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Category",
                    style: TextStyle(
                        color: Color(0xff2f2e30),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),


                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                        height: 100,
                        margin: EdgeInsets.only(right: 50),
                        child: getCategory== null
                            ? Text("no data")
                            : ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: getCategory.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onDoubleTap: () {
                                        createBuyDialog(context);
                                        setState(() {
                                          delIndex =
                                              getCategory[index].categoryId;

                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          pageCount = 0;
                                          variIndex =
                                              getCategory[index].categoryId;
                                          categoryIndex =
                                              "${getCategory[index].categoryName[0].toUpperCase()}${getCategory[index].categoryName.substring(
                                                    1,
                                                  ).toLowerCase()}";
                                          productCount = getCategory[index]
                                              .products
                                              .length;

                                          getHttpTwo();
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        width: 60,
                                        height: 140,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color:
                                                getCategory[index].categoryId ==
                                                        variIndex
                                                    ? Color(0xff1d1c21)
                                                    : null),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                              NetworkImage(
                                                "http://jayanthigaddameedi.pythonanywhere.com/${getCategory[index].categoryImage}",
                                              ),
                                              //  child:CachedNetworkImage(
                                              //    imageUrl: "http://jayanthigaddameedi.pythonanywhere.com/${getCategory[index].image}",
                                              // placeholder: (context,url)=> CircularProgressIndicator(
                                              //
                                              // ),
                                              //    errorWidget: (context,url ,error) => Icon(Icons.error_outline),
                                              //  )
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Flexible(
                                                child: Text(
                                                  "${getCategory[index].categoryName[0].toUpperCase()}${getCategory[index].categoryName.substring(
                                                        1,
                                                      ).toLowerCase()}",
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: getCategory[index]
                                                                  .categoryId ==
                                                              variIndex
                                                          ? Colors.white
                                                          : null,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 22,
                                  );
                                })),
                    Positioned(
                      top: 15,
                      right: -30,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff1d1c21),
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          onPressed: () {
                            categoryCreateAlert(context);

                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${categoryIndex} near you",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddProducts(indx: variIndex,)));
                  },
                    child: Icon(Icons.add),)
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // if (indicator)
              //   Center(
              //     child: CircularProgressIndicator(),
              //   )
              // else
                Expanded(
                    child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                          child: getProducts.products == null
                              ? CircularProgressIndicator()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getProducts.products.length,
                                  itemBuilder: (context, index) {
                                    return getProducts.products.isEmpty  ? Text("add items"): InkWell(
                                        onTap: () {
                                          setState(() {});
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SingleScreen(
                                                        getProdctForSecondScreen:
                                                            getProducts
                                                                    .products[
                                                                index],
                                                      )));
                                        },
                                        child: Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            Container(

                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        offset: Offset(0, 3),
                                                        blurRadius: 3)
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 120,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                        image: NetworkImage(
                                                            "http://jayanthigaddameedi.pythonanywhere.com/${getProducts.products[index].productImage}"),
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Flexible(
                                                    flex: 4,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${getProducts.products[index].productName[0].toUpperCase()}${getProducts.products[index].productName.substring(
                                                                1,
                                                              ).toUpperCase().toUpperCase()}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                           Image.asset("assets/clock.png" , height: 16, color: Colors.orange,),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text("30 - 40 min",style: TextStyle(
                                                                color: Color(0xFF222222),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 12),),
                                                            SizedBox(
                                                              width: 18,
                                                            ),
                                                            Icon(
                                                              Icons.star_border,
                                                              color:
                                                                  Colors.orange,
                                                              size: 19,
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                                "${getProducts.products[index].productRating}",style: TextStyle(
                                                                color: Color(0xFF222222),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 12),),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 9,
                                                        ),
                                                        Wrap(
                                                          children: [
                                                            Image.asset('assets/dollor.png' ,height: 20,color: Colors.green,),
                                                            Text(
                                                                "${getProducts.products[index].productPrice - getProducts.products[index].productDiscount}" , style: TextStyle(
                                                              color: Color(0xFF222222),
                                                              fontWeight: FontWeight.w500,
                                    fontSize: 13),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset('assets/dollor.png' ,height: 20,color: Colors.green,),
                                                            Text(
                                                                "${getProducts.products[index].productPrice }" ,overflow: TextOverflow.ellipsis, maxLines: 1,style: TextStyle(
                                                              color: Color(0xffd0d0d0),

                                                              fontSize: 12,
                                                              decoration: TextDecoration.lineThrough,),),
                                                            SizedBox(
                                                              width: 15,
                                                            ),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: -10,
                                              right: 0,
                                              child: InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    productIndexPass = getProducts.products[index].productId;
                                                    categoryIndexPass = getProducts.products[index].categoryId;
                                                  });
                                                  productDilagBox(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.bottomLeft,
                                                        end: Alignment.topRight,
                                                        colors :[
                                                          Colors.orange,
                                                        Colors.white
                                                        ],
                                                      ) ,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Icon(Icons.edit_outlined ,color: Colors.black,) ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 22,
                                    );
                                  })),

                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(

                              onPressed: () {
                                setState(() {
                                  if (pageCount > 0) {
                                    pageCount = pageCount - 1;
                                    getHttpTwo();
                                  }
                                });
                              },
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text("Back")),
                          SizedBox(width: 10,),
                          Text("${pageCount + 1}" , style: TextStyle(
                              color: Color(0xffd0d0d0) ,fontWeight: FontWeight.bold),),
                          productCount == null
                              ? Text("0")
                              : Text(
                                  " out of ${((productCount / 5)+1).toString().substring(0,1)}" , style: TextStyle(
                              color: Color(0xffd0d0d0) ,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,), FlatButton(
                              onPressed: () {
                                setState(() {

                                  pageCount = pageCount + 1;
                                  getHttpTwo();




                                });
                              },
                              child: Text("Next" ,),
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),),
                        ],
                      ),

                    ],
                  ),
                )),

              // SecondClass( varindx: variIndex,)
            ],
          ),
        ),
      ),
    );
  }

  createBuyDialog(BuildContext context) {
    var alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        content: Container(
             height: MediaQuery.of(context).size.height * 0.2 ,
            child:
            Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do you what to ? "),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          onPressed: () {
                            createDeleteDialog(context);
                          },
                          child: Text("Delete"),
                        ),
                        FlatButton(
                          onPressed: () {
                            createUpdateDialog(context);
                          },
                          child: Text("Update"),
                        )
                      ],
                    ),
                    // FlatButton(onPressed: (){
                    //   Navigator.pop(context);
                    // },
                    //   child: Text("Exit"),)
                  ],
                ),
             ) ,
    actions: [
      FlatButton(onPressed: (){
        Navigator.pop(context);

      }, child: Text("Exit")),
      SizedBox(height: 100,)
    ],);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  createDeleteDialog(BuildContext context) {
    var alertDialog = AlertDialog(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  FlatButton(
                    color: Colors.blueGrey[50],
                    onPressed: () {
                      deleteCategory();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                      setState(() {
                        getHttp();
                      });
                    },
                    child: Text("ok"),
                  ),
                  SizedBox(width: 30,),
                  FlatButton(
                    color: Colors.blueGrey[50],
                    onPressed: () {
                      updateCategoryFunc();
                      Navigator.pop(context);
                    },
                    child: Text("no"),
                  )
                ],
              ),


          ]),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  createUpdateDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: updateTextController,
                decoration: InputDecoration(hintText: "Update  name"),
              ),
              SizedBox(height: 10,),
              // RaisedButton(onPressed: (){
              //   GalleryClick();
              // } ,
              //   child: Text("Upload Image"),),
              // Expanded(
              //   child: Container(
              //     height: 400,
              //     width: 200,
              //     child:  imageForUpdate == null ? Text("  "):  Container(
              //       decoration: BoxDecoration(
              //
              //           image: DecorationImage(
              //               image: FileImage(imageForUpdate),
              //               fit: BoxFit.cover
              //           )
              //       ),
              //     ),
              //   ),
              // ),

           resOfUpdateCategory==null ? Text(" ") :  Text(resOfUpdateCategory)
            ],
          ),
        ),
    actions: [FlatButton(
      onPressed: () {
        updateCategoryFunc();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
        setState(() {
          getHttp();
        });
      },
      child: Text("update"),
    ),
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("cancel"),
      ),
    SizedBox(height: 100,)],

    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  categoryCreateAlert(BuildContext context) {

    var alertDialog = AlertDialog(
      backgroundColor: Colors.blueGrey[50],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.3 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(

                controller: createController,
                decoration: InputDecoration(hintText: "Enter Category  name"),
              ),
            SizedBox(height: 10,),
            RaisedButton(onPressed: (){
              createImageCategory();
            } ,
            child: Text("Upload Image"),),
              Expanded(
                child: Container(
                  height: 400,
                  width: 200,
                  child:  imageForCreateCategory == null ? Text(".  "):  Container(
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        image: FileImage(imageForCreateCategory),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              ),


            
            ],
          ),
        ),
      actions: [
        FlatButton(
        onPressed: () {

          createCategory();
          setState(() {
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text("create"),
      ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Text("cancel"),
        ),
      SizedBox(height: 100,)],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }


  // createCratigoryDialog(BuildContext context) {
  //
  //   var alertDialog = AlertDialog(
  //       backgroundColor: Colors.blueGrey[50],
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(60),
  //               bottomRight: Radius.circular(60))),
  //       content: Container(
  //         height: MediaQuery.of(context).size.height * 0.5 ,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: TextController,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: descriptionContoller,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: priceCotroller,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: discountcontroller,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: ratingController,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20),
  //               child: TextField(
  //                 controller: categoryIdcontoller,
  //                 decoration: InputDecoration(
  //                     hintText: "Enter"
  //                 ),
  //               ),
  //             ),
  //             RaisedButton(
  //                 child: Text("click to update"),
  //                 onPressed: (){
  //                   createProductsFunc();
  //                   setState(() {
  //
  //                   });
  //                 }),
  //             Center(
  //               child: RaisedButton(
  //                 child: Text('click Image'),
  //                 onPressed: (){
  //                   setState(() {
  //                     cameraClick();
  //                   });
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ));
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alertDialog;
  //     },
  //   );
  // }
  productDilagBox(BuildContext context) {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2 ,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Do you what to ? "),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddProducts(indx: variIndex,)));
                  setState(() {
                  });},
                child: Text("Create"),),

                FlatButton(
                  onPressed: () {
                    deleteProdcutMethod(context);
                  },
                  child: Text("Delete"),
                ),

                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        UpdateProdutClass( getProdctForSecondScreen: getProductsForShare,catIndx: categoryIndexPass,indx: productIndexPass,)));
                  },
                  child: Text("Update"),
                )
              ],
            ),
            // FlatButton(onPressed: (){
            //   Navigator.pop(context);
            // },
            //   child: Text("Exit"),)
          ],
        ),
      ) ,
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);

        }, child: Text("Exit")),
        SizedBox(height: 100,)
      ],);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
  deleteProdcutMethod(BuildContext context) {
    var alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.2 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      delect_Product();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                      setState(() {
                        getHttpTwo();
                      });
                    },
                    child: Text("ok"),
                  ),
                  SizedBox(width: 30,),
                  FlatButton(
                    color: Colors.blueGrey[50],
                    onPressed: () {
                      updateCategoryFunc();
                      Navigator.pop(context);
                    },
                    child: Text("no"),
                  )
                ],
              )
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

}
// class SecondClass extends StatefulWidget {
//   SecondClass({ this.varindx});
//   final int varindx ;
//   @override
//   _SecondClassState createState() => _SecondClassState();
// }
//
// class _SecondClassState extends State<SecondClass> {
//   List<Getproducts> getProdcts = List();
//   dynamic restwo;
//   int variIndex = 1;
//   Future <void> getHttpTwo() async {
//     try {
//       setState(()  async {
//         Response response =
//         await Dio().get("http://jayanthigaddameedi.pythonanywhere.com/products/?category_id=${widget.varindx}");
//         getProdcts = getproductsFromMap(jsonEncode(response.data));
//         restwo = response;
//         print(restwo);
//       });
//     } catch (e) {
//       setState(() {
//         print("error ---> $e");
//       });
//       print(e);
//     }
//   }
//   @override
//   void initState() {
//     getHttpTwo();
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//
//         child:
//         // child:  getProdcts == null ? Text("no data") :
//         ListView.separated(
//             shrinkWrap: true,
//
//
//             itemCount: getProdcts.length ,
//             itemBuilder: (context , index){
//               return Container(
//                 child: Text(getProdcts[index].productName ,style: TextStyle(color: Colors.black),),
//               );
//             },
//             separatorBuilder: (context, index) {
//               return SizedBox(
//                 width: 22,
//               );
//             })
//     );
//   }
// }
