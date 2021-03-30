import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_one/model/cart/delct_cart.dart';
import 'package:hackathon_one/model/cart/get_cart.dart';
import 'package:hackathon_one/screens/home_screen.dart';
import 'package:hackathon_one/screens/single_screen.dart';

class GetCartScreen extends StatefulWidget {
  @override
  _GetCartScreenState createState() => _GetCartScreenState();
}

class _GetCartScreenState extends State<GetCartScreen> {
 List <GetCart> getcart = List();
DelCart delmethod  = DelCart();


  bool indicator;
  double totalPrice  = 1.1 ; double totalPriceall  = 0;
  int delectCartIndex ;

  Response res;
  void getHttp() async {
    setState(() {
      indicator = true;
    });
    try {
      Response response = await Dio().get(
          "http://jayanthigaddameedi.pythonanywhere.com/cart/");
      setState(() {
        indicator = false;
        getcart = getCartFromMap(jsonEncode(response.data));
        res = response;
        print(res);
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
 void delectCart() async {
   setState(() {
     indicator = true;
   });
   try {
     FormData formData = FormData.fromMap({
       "cart_id" : delectCartIndex ,


     });
     Response response = await Dio().delete(
         "http://jayanthigaddameedi.pythonanywhere.com/cart/" ,data: formData);
     setState(() {
       indicator = false;
       delmethod = delCartFromMap(jsonEncode(response.data)) ;
       res = response ;
       print(res);
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
    getHttp();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Cart"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
        },),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
          //       RaisedButton(onPressed: (){
          //      setState(() {
          //       totalPriceall;
          //      });
          //       }),
          // Text("${totalPriceall}"),

SizedBox(height: 10,),
               getcart.length== null ? Container() : ListView.separated(
                 physics: NeverScrollableScrollPhysics(),
                  itemCount: getcart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){


                     totalPrice  = getcart[index].price * getcart[index].quantity;
                     totalPriceall = totalPriceall +totalPrice ;

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10), margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xfffeeee6),
                              offset: Offset(0, 5),
                              blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Container(
                              height: 100,
                              child:    getcart[index].image==null ?Text(" ")   : Image.network(getcart[index].image,height: 100,),
                            ),

                            SizedBox(width: 100,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${(getcart[index].name).substring(0,1).toUpperCase()}${(getcart[index].name).substring(1,).toLowerCase()}"),
                                Text("${(getcart[index].price)*getcart[index].quantity}")
                              ],
                            ),
                          ),
                          ],
                        ),

                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),

                        Container(
                          padding: EdgeInsets.only( left: 20 , right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (getcart[index].quantity > 1) {
                                            getcart[index].quantity = getcart[index].quantity - 1;
                                          }
                                        });
                                      }, child: Image.asset("assets/minus.png" , height: 30 , color: Colors.orange,)
                                  ),

                                  SizedBox(width: 10,),
                                  getcart[index].quantity < 0 ? Text("0") : Text("${getcart[index].quantity}"),
                                  SizedBox(width: 10,),
                                  InkWell(onTap: () {
                                    setState(() {
                                      if (getcart[index].quantity < 10) {
                                        getcart[index].quantity = getcart[index].quantity + 1;
                                      }
                                    });
                                  }, child: Image.asset("assets/add.png" , height: 40 , color: Colors.orange,)),

                                ],
                              ),
         InkWell(
           onTap: (){
             setState(() {
               delectCartIndex =getcart[index].cartId;
               createDelectDialog(context);
             });
           },
           child: Container(
             child:  Icon(Icons.delete),
           ),
         )

                            ],
                          ),
                        ),



                      ],
                    ),
                  );
                },
                   separatorBuilder: (context, index) {
                     return SizedBox(
                       height: 22,
                     );
                   }
                ),

                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.black12,
                //             offset: Offset(0, 3),
                //             blurRadius: 3)
                //       ]),
                //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //   margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //   child: Column(
                //
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("No.of Items " , style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                //           Text("${getcart.length}" , style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                //         ],
                //       ), SizedBox(height: 10,),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Actual Price " ,style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                //           Text("\$${(getcart)* items}" ,style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                //         ],
                //       ),SizedBox(height: 10,),
                //
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Total Discount" ,style: TextStyle( color:Color(0xffaeaeae)  , fontSize:14  ),),
                //           Text("\$${(widget.getProdctForSecondScreen.productDiscount)* items} " ,style: TextStyle( color:Color(0xff3a3a3a)  , fontSize:14 , fontWeight: FontWeight.w500 ),)
                //         ],
                //       ),SizedBox(height: 10,),
                //       Divider(height: 10,color:Color(0xffaeaeae)),
                //       SizedBox(height: 10,),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Total Bill" ,style: TextStyle( color:Color(0xffda5253)  , fontSize:15   ,fontWeight: FontWeight.w600),),
                //           Text("\$${(widget.getProdctForSecondScreen.productPrice - widget.getProdctForSecondScreen.productDiscount)* items}  " ,style: TextStyle( color:Color(0xffda5253)  , fontSize:15   ,fontWeight: FontWeight.w900),)
                //         ],
                //       ),SizedBox(height: 18,),
                //
                //
                //       Container(
                //           width: MediaQuery.of(context).size.width * 1,
                //           height: 40,
                //           decoration: BoxDecoration(
                //             gradient: LinearGradient(
                //               begin: Alignment.bottomLeft,
                //               end: Alignment.topRight,
                //               colors :[
                //                 Color(0xffda5053),
                //                 Colors.orange
                //               ],
                //             ) ,
                //           ),
                //           child: Center(child: Text("Buy" ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600),)))
                //
                //
                //
                //
                //
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 createDelectDialog(BuildContext context) {
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
                     delectCart();
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetCartScreen()));
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
}
