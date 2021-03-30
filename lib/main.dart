
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hackathon_one/screens/home_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lp Hackathon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: HomePage(),
    );
  }
}