import 'package:flutter/material.dart';
import 'package:pasadu/screens/home.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Inspector',
      home: Home(),
    );
  }
}
