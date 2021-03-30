import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_one/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';

class HeroProfileDetails extends StatefulWidget {
  HeroProfileDetails({this.pic  , this.img});
  final File pic ;
  final String img ;
  @override
  _HeroProfileDetailsState createState() => _HeroProfileDetailsState();
}

class _HeroProfileDetailsState extends State<HeroProfileDetails> {
  File profilePicVar ;
  void profilPic ()  async{
    File image;

    var galleryPicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if( galleryPicker != null){
      setState(() {
        image=galleryPicker;
        profilePicVar = galleryPicker;
        print(profilePicVar.path);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage(profilePicVar: profilePicVar,)));
        },),
        automaticallyImplyLeading: false,
        title: Text("profile Picture"),
        actions: [
          FlatButton(onPressed: (){
            profilPic();
          }, child: Text("edit"))
        ],
        // profilePicVar == null ? AssetImage("assets/star.png") :FileImage(profilePicVar),
      ),
      body: Hero(

        tag: 'profile',
        child: Container(
          child: profilePicVar == null ?  Image.asset(widget.img) :Image.file(profilePicVar) ,
        ),
      ),
          
    );
  }
}

class ProductImageHero extends StatefulWidget {
  ProductImageHero({
    this.img,this.name
});
  final String img;  final String name;
  @override
  _ProductImageHeroState createState() => _ProductImageHeroState();
}

class _ProductImageHeroState extends State<ProductImageHero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          CircleAvatar(
            radius: 300,

            child: Container(
              child: PinchZoomImage(

                  image : Image.network(widget.img)),
            ),
          ),
        ],
      )
    );
  }
}

