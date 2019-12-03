import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  // field
  String runRecNoString;
  // Method
  @override
  void initState() {
    super.initState();
    findRunRecNo();

  }

  Future<void> findRunRecNo() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    runRecNoString = sharedPreferences.getString('runrecno');
    if (runRecNoString != null) {
      readData();
      
    }

  }

  Future<void> readData()async{
      String url = 'https://appdb.tisi.go.th/ForApp/getUserWhereidCheck.php?isAdd=true&idCheck=$runRecNoString';

      Response response = await get(url);
      var result = json.decode(response.body);
      print('result ============> $result');

      for (var map in result) {
        
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is Home'),
    );
  }
}
