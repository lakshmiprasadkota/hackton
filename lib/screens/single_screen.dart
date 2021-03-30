import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon_one/model/cart/post_cart.dart';
import 'package:hackathon_one/model/get_products.dart';
import 'package:hackathon_one/screens/home_screen.dart';
import 'package:hackathon_one/screens/hero_profile_details.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';

import 'get_cart_screen.dart';

class SingleScreen extends StatefulWidget {
  SingleScreen({this.getProdctForSecondScreen });
 Products getProdctForSecondScreen = Products();
Color clr ;
 @override
  _SingleScreenState createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  int items = 1 ;
  PostCart postCartVAr = PostCart();
  String crt ;
  int compare =1;
  void postGetHttpForCart() async {

    try {
      FormData formData = FormData.fromMap({
        "category_id" : widget.getProdctForSecondScreen.categoryId,
        "product_id" : widget.getProdctForSecondScreen.productId,
        "price" :widget.getProdctForSecondScreen.productPrice,
        "quantity" :items,
        "discount" : (widget.getProdctForSecondScreen.productDiscount) * items,
      "name": widget.getProdctForSecondScreen.productName ,
        "total_price" :(widget.getProdctForSecondScreen.productPrice - widget.getProdctForSecondScreen.productDiscount)* items,
        "image" : widget.getProdctForSecondScreen.productImage
      });
      Response response =
      await Dio().post("http://jayanthigaddameedi.pythonanywhere.com/cart/" , data: formData);
      setState(() {
        postCartVAr = postCartFromMap(jsonEncode(response.data));
        crt = response.data["message"];

        print(crt);
        Fluttertoast.showToast(msg: crt);
      });

    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10)
                    //         ),
                    //         child: IconButton(icon: Icon(Icons.arrow_back_ios),),
                    //       ),
                    //       Text(" Details"),
                    //       IconButton(icon: Icon(Icons.favorite_border), onPressed: null)
                    //     ],
                    //   ),
                    //   Expanded(
                    //     child: Container(height: 400,width: 1000
                    //       ,color: Colors.red,
                    //       child: Text("hai"),),
                    //   ),
                    // Positioned(
                    //  bottom: 0,
                    //   child: Expanded(
                    //           child: SingleChildScrollView(
                    //             child: Container(
                    //               width: double.infinity,
                    //
                    //               decoration: BoxDecoration(
                    //                   color: Colors.blue,
                    //                   borderRadius: BorderRadius.circular(100)
                    //               ),
                    //               child: Column(
                    //                 children: [
                    //                   Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),Text("hai"),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                            Navigator.pop(context);
                          },),
                        ),
                        Text(" ${(widget.getProdctForSecondScreen.categoryName).substring(0,1).toUpperCase()}${(widget.getProdctForSecondScreen.categoryName).substring(1,).toLowerCase()} Details" , style: TextStyle(color: Color(0xff39383c ,),fontSize: 17 , fontWeight: FontWeight.bold),),
                        IconButton(icon: Icon(Icons.favorite_border ,color: Color(0xff39383c ,) ,size: 26,), onPressed: null ,)
                      ],
                    ),
                  Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height * 0.4,
                         margin: EdgeInsets.symmetric(vertical: 20),
                         child: Stack(
                           overflow: Overflow.visible,
                           children: [
                             Positioned(
                               left: -150,
                               child: Container(
                                 child: CircleAvatar(
                                   radius: 170,

                                   child: CircleAvatar(
                                     radius: 150,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductImageHero(
                                          name: widget.getProdctForSecondScreen.productName,
                                          img:"http://jayanthigaddameedi.pythonanywhere.com/${widget.getProdctForSecondScreen.productImage}" ,)));
                                      },
                                      child: Hero(
                                        tag: "productImage",
                                        child: Container(
                                          child: PinchZoomImage(
                                            image: Image.network("http://jayanthigaddameedi.pythonanywhere.com/${widget.getProdctForSecondScreen.productImage}"),
                                          ),
                                        ),
                                      ),
                                    )
                                   ),
                                 ),
                               ),
                             ),
                             Positioned(
                               right: 0,
                               bottom: 0,
                               top: 0,

                               child: Container(
                                 padding: EdgeInsets.symmetric( horizontal: 15),
                                 child: Column(

                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          compare =1 ;
                                        });
                                      },
                                       child: Container(
                                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                         decoration: compare == 1 ? BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors :[
                                             Colors.orange,
                                              Colors.white
                                            ],
                                          ) ,
                                          //  color: Color(0xff201f24),

                                           borderRadius: BorderRadius.circular(30),
                                         ): BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(30),),
                                         child: Row(

                                           children: [
                                            Image.asset("assets/clock.png" ,color: Color(0xff201f24), height: 25,),
                                             SizedBox(width: 6,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("40-30 km" , style: TextStyle(color: Color(0xff343141) ,fontWeight: FontWeight.w500),),
                                                 Text("Delivery",style: TextStyle(color: Color(0xffadabb3), fontSize: 10),)
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                     InkWell(
                                       onTap: (){
                                         setState(() {
                                           compare =2 ;
                                         });
                                       },
                                       child: Container(
                                         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                                         decoration: compare == 2 ? BoxDecoration(
                                           gradient: LinearGradient(
                                             begin: Alignment.bottomLeft,
                                             end: Alignment.topRight,
                                             colors :[
                                               Colors.orange,
                                               Colors.white
                                             ],
                                           ) ,

                                           borderRadius: BorderRadius.circular(30),
                                         ): BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(30),),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [
                                             Image.asset("assets/star.png" , height: 30, ),
                                             SizedBox(width: 8,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("${widget.getProdctForSecondScreen.productRating}",style: TextStyle(color: Color(0xff201f24) , fontWeight: FontWeight.w500 , fontSize: 14),),
                                                 Text("Rating",style: TextStyle(color: Color(0xffadabb3) ,fontSize: 12, ),  )
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                     InkWell(
                                       onTap: (){
                                         setState(() {
                                           compare =3 ;
                                         });
                                       },
                                       child: Container(
                                         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                                         decoration: compare == 3 ? BoxDecoration(
                                           gradient: LinearGradient(
                                             begin: Alignment.bottomLeft,
                                             end: Alignment.topRight,
                                             colors :[
                                               Colors.orange,
                                               Colors.white
                                             ],
                                           ) ,

                                           borderRadius: BorderRadius.circular(30),
                                         ):BoxDecoration( color: Colors.white , borderRadius: BorderRadius.circular(30),),
                                          child: Row(
                                           children: [
                                             Image.asset("assets/dis.png" , height: 20, color: Colors.green,),
                                             SizedBox(width: 5,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("${widget.getProdctForSecondScreen.productDiscount}",style: TextStyle(color: Color(0xff201f24) , fontWeight: FontWeight.w500 , fontSize: 14),),
                                                 Text("Discount",style: TextStyle(color: Color(0xffadabb3) ,fontSize: 12, ),  )
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                             )
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Flexible(child: Text("${(widget.getProdctForSecondScreen.productName).substring(0,1).toUpperCase()}${(widget.getProdctForSecondScreen.productName).substring(1,).toLowerCase()} ",
                               style: TextStyle(color: Color(0xff120e26) , fontWeight: FontWeight.bold , fontSize: 24), )),
                          Row(
                            children: [

                                Row(
                                  children: [
                                    Text("\$" ,
                                      style: TextStyle(color: Color(0xffadabb3) ,
                                          fontWeight: FontWeight.w800 , fontSize: 14),),
                                    SizedBox(width: 6,),
                                    Text("${widget.getProdctForSecondScreen.productPrice}" ,
                                      style: TextStyle(color: Color(0xff414141) ,
                                          fontWeight: FontWeight.w700 , fontSize: 16),),
                                  ],
                                )

                            ],
                          )

                           ],
                         ),
                       ),

                       SizedBox(height: 10,),
                       Container(
                           padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                           child: Text("${widget.getProdctForSecondScreen.productDescription} ",style: TextStyle(color: Color(0xffadabb3), fontWeight: FontWeight.w400), textAlign: TextAlign.justify, ) ),
                       SizedBox(height: 30,),
                       // Container(  padding: EdgeInsets.symmetric(horizontal: 10),
                       //     alignment: Alignment.topLeft,
                       //     child: Text("Ingridiants" ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 24),)),
                       // SizedBox(height: 10,),
                       // Container(
                       //   padding: EdgeInsets.symmetric(horizontal: 19 , vertical: 10),
                       //   child: Row(
                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //     children: [
                       //       Container(
                       //         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                       //         decoration: BoxDecoration(
                       //           color: Colors.red,
                       //           borderRadius: BorderRadius.circular(30),
                       //         ),
                       //         child: Column(
                       //           children: [
                       //             Icon(Icons.lock_clock , color: Colors.white,),
                       //             SizedBox(width: 5,),
                       //             Column(
                       //               children: [
                       //                 Text("25-30m"),
                       //                 Text("delvery")
                       //               ],
                       //             )
                       //           ],
                       //         ),
                       //       ),Container(
                       //         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                       //         decoration: BoxDecoration(
                       //           color: Colors.red,
                       //           borderRadius: BorderRadius.circular(30),
                       //         ),
                       //         child: Column(
                       //           children: [
                       //             Icon(Icons.lock_clock , color: Colors.white,),
                       //             SizedBox(width: 5,),
                       //             Column(
                       //               children: [
                       //                 Text("25-30m"),
                       //                 Text("delvery")
                       //               ],
                       //             )
                       //           ],
                       //         ),
                       //       ),
                       //       Container(
                       //         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                       //         decoration: BoxDecoration(
                       //           color: Colors.red,
                       //           borderRadius: BorderRadius.circular(30),
                       //         ),
                       //         child: Column(
                       //           children: [
                       //             Icon(Icons.lock_clock , color: Colors.white,),
                       //             SizedBox(width: 5,),
                       //             Column(
                       //               children: [
                       //                 Text("25-30m"),
                       //                 Text("delvery")
                       //               ],
                       //             )
                       //           ],
                       //         ),
                       //       ),
                       //     ],
                       //   ),
                       // ),

                       Container(
                         padding: EdgeInsets.only( left: 20 , right: 20),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Add" ,style: TextStyle(color: Color(0xff120e26),fontSize: 16 ,fontWeight: FontWeight.w600), ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 InkWell(

                                     onTap: () {
                                       setState(() {
                                         if (items > 1) {
                                           items = items - 1;
                                         }
                                       });
                                     }, child: Image.asset("assets/minus.png" , height: 30 , color: Colors.orange,)
                                   ),

                                SizedBox(width: 10,),
                                 items < 0 ? Text("0") : Text("${items}"),
                                 SizedBox(width: 10,),
                                  InkWell(onTap: () {
                                     setState(() {
                                       if (items < 10) {
                                         items = items + 1;
                                       }
                                     });
                                   }, child: Image.asset("assets/add.png" , height: 40 , color: Colors.orange,)),

                               ],
                             ),

                           ],
                         ),
                       ),


                         Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20),
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black12,
                                     offset: Offset(0, 3),
                                     blurRadius: 3)
                               ]),
                           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                           margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                           child: Column(

                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("No.of Items " , style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                                   Text("${items}" , style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                                 ],
                               ), SizedBox(height: 10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Actual Price " ,style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                                   Text("\$${(widget.getProdctForSecondScreen.productPrice)* items}" ,style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                                 ],
                               ),SizedBox(height: 10,),

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Total Discount" ,style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                                   Text("\$${(widget.getProdctForSecondScreen.productDiscount)* items} " ,style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                                 ],
                               ),SizedBox(height: 10,),
                               Divider(height: 10,color:Color(0xffaeaeae)),
                               SizedBox(height: 10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Total Bill" ,style: TextStyle( color:Color(0xffda5253)  , fontSize:15   ,fontWeight: FontWeight.w600),),
                                   Text("\$${(widget.getProdctForSecondScreen.productPrice - widget.getProdctForSecondScreen.productDiscount)* items}  " ,style: TextStyle( color:Color(0xffda5253)  , fontSize:15   ,fontWeight: FontWeight.w900),)
                                 ],
                               ),SizedBox(height: 18,),


                               Container(
                                 width: MediaQuery.of(context).size.width * 1,
                                 height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors :[
                                   Color(0xffda5053),
                                      Colors.orange
                                    ],
                                  ) ,
                                ),
                                   child: Center(child: Text("Buy" ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600),)))





                             ],
                           ),
                         ),

                       SizedBox(height: 100,),
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
                           child: Text("Payment " , style: TextStyle(color: Colors.black , ),),
                           onPressed: (){

                             // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
                             setState(() {

                             });

                           },
                         ),

                       ),


                     ],
                   ),
                 ),
             )


                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Row(
              //     children: [
              //       Expanded(child: Container(
              //         color: Colors.orange,
              //           child: Text("Add to cart"))),
              //       Expanded(child: Container(
              //           child: Text("Add to cart"))),
              //     ],
              //   ),
              // )
              Positioned(
                bottom: -19,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 15,right: 15 , bottom: 35 , top: 20),


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff1d1c21),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          Text("Total price",style: TextStyle(color: Colors.white), ),
                    Text("${(widget.getProdctForSecondScreen.productPrice- widget.getProdctForSecondScreen.productDiscount )* items}" ,style: TextStyle(color: Colors.white),)


                        ],),
                        InkWell(

                          onTap: (){
                            setState(() {
                              postGetHttpForCart();
                              addCartDialog(context);
                            });

                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors :[
                                  Color(0xffda5053),
                                  Colors.orange
                                ],
                              ) ,
                            ),
                              child: Center(child: Text("Add to Cart" , style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500),))),
                        )

                      ],
                    ),
                  ),
                ),
              )
            ],
          )

        ),
      ),
    );
  }
addCartDialog(BuildContext context){

  var alertDialog = AlertDialog(
      backgroundColor: Colors.blueGrey[50],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
    title: Text(widget.getProdctForSecondScreen.productName),
    content: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
   Text("product has been add to cart" , style: TextStyle
     (color: Colors.black),),

     SizedBox(height: 30,),

     Row(
       children: [
         InkWell(
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>GetCartScreen()));
           },
           child: Container(
               height: 40,
               width: 120,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 gradient: LinearGradient(
                   begin: Alignment.bottomLeft,
                   end: Alignment.topRight,
                   colors :[
                     Colors.orange,
                     Colors.white,
                   ],
                 ) ,
               ),
               child: Center(child: Text("Go to Cart" , style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w500),))),
         ),
SizedBox(width: 30,),
         InkWell(
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
           },
           child: Container(
               height: 40,
               width: 120,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 gradient: LinearGradient(
                   begin: Alignment.bottomLeft,
                   end: Alignment.topRight,
                   colors :[

                     Colors.orange,
                     Colors.white,
                   ],
                 ) ,
               ),
               child: Center(child: Text("Shope More" , style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w500),))),
         ),

       ],
     ),

        ],
      ),
    )

  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
  // createBuyDialog(BuildContext context){
  //
  //   var alertDialog = AlertDialog(
  //       backgroundColor: Colors.blueGrey[50],
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(60),
  //               bottomRight: Radius.circular(60))),
  //     title: Text(widget.getProdctForSecondScreen.productName),
  //     content: Container(
  //       height: MediaQuery.of(context).size.height * 0.4,
  //       child: Column(
  //         children: [
  //
  //           RichText(text: TextSpan(
  //               text: " Total Items  ",
  //               style: TextStyle(color: Colors.black , fontSize: 16),
  //               children: [
  //                 TextSpan(text: "${items}"),
  //
  //               ]
  //           )),
  //           RichText(text: TextSpan(
  //               text: " actual Price ",
  //               style: TextStyle(color: Colors.black , fontSize: 16),
  //               children: [
  //                 TextSpan(text: " ${(widget.getProdctForSecondScreen.productPrice)* items} "),
  //
  //               ]
  //           )),
  //           RichText(text: TextSpan(
  //               text: " Total Discount ",
  //               style: TextStyle(color: Colors.black , fontSize: 16),
  //               children: [
  //                 TextSpan(text: " ${(widget.getProdctForSecondScreen.productDiscount)* items} "),
  //
  //               ]
  //           )),
  //           RichText(text: TextSpan(
  //               text: " Total Bill ",
  //               style: TextStyle(color: Colors.black , fontSize: 16),
  //               children: [
  //                 TextSpan(text: " ${(widget.getProdctForSecondScreen.productPrice - widget.getProdctForSecondScreen.productDiscount)* items} "),
  //
  //               ]
  //           )),
  //
  //           Row(
  //             children: [
  //               RaisedButton(onPressed: (){
  //
  //               },child: Text("Add to Cart"),),
  //               RaisedButton(onPressed: (){
  //
  //               },child: Text("Buy"),)
  //             ],
  //           )
  //         ],
  //       ),
  //     )
  //
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alertDialog;
  //     },
  //   );
  // }


}

