import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStyle {
// field
  double h1 = 30.0, h2 = 18.0;
  Color textColor = Color.fromARGB(255, 0, 0, 0);
  Color textColorEmphasize = Color.fromARGB(255, 255, 0, 0);
  Color mainColor = Color.fromRGBO(0, 100, 25, 2.0);

  String fontString = 'Mansalva';

  TextStyle h2TextStyle = TextStyle(
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.bold,
  );


  TextStyle h3TextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

// Constructor
  MyStyle();
}
