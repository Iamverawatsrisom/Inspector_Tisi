import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pasadu/screens/my_stye.dart';

class MyService extends StatefulWidget {
  final String keyRunrecno;
  MyService({Key key, this.keyRunrecno}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// field
  String loginString = '...';
  String runrecnoString;

// Method

  @override
  void initState() {
    super.initState();
    runrecnoString = widget.keyRunrecno;
    if (runrecnoString != null) {
      readUserData();
    }
  }

  Future<void> readUserData() async {
    String url =
        'https://appdb.tisi.go.th/ForApp/getUserWhereRunrecno.php?isAdd=true&runrecno=$runrecnoString';
    Response response = await get(url);
    var result = json.decode(response.body);
    if (result != 'null') {
      for (var map in result) {
        setState(() {
          String name =map['reg_fname'];
          String surName= map['reg_lname'];
          loginString = '$name $surName';
        });
      }
    }
  }

  Widget showLogin() {
    return Text('Login By $loginString');
  }

  Widget showAppName() {
    return Text(
      'Inspector',
      style: TextStyle(
        fontSize: MyStyle().h2,
        color: MyStyle().textColor,
        fontFamily: MyStyle().fontString,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget head() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          head(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: showDrawer(),
    );
  }
}
