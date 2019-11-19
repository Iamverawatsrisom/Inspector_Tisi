import 'package:flutter/material.dart';
import 'package:pasadu/screens/my_service.dart';
import 'package:pasadu/screens/my_stye.dart';
import 'package:http/http.dart' show Response, get;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; //ใช้สำหรับถอดรหัส object ให้เป็นสิ่งที่ อ่านได้

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// explicit
  bool statusRemember = false; //false => ไม่ save true = save'
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString, runrecnoString;

// method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future checkStatus() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool currentRemember = sharedPreferences.getBool('remember');
      if (currentRemember) {
        runrecnoString = sharedPreferences.getString('runrecno');
        routeToMyserveice();
      }
    } catch (e) {}
  }

  Widget showlogo() {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Image.asset('images/Login.png'),
    );
  }

  Widget showLogoAndName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showlogo(),
        SizedBox(
          width: 10.0,
        ),
        showAppName(),
      ],
    );
  }

  Widget showAppName() {
    return Text(
      'ร้านค้า มอก.\nสำนักงานมาตรฐานฯ',
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: MyStyle().textColor,
        fontFamily: 'Mansalva',
      ),
    );
  }

  Widget userText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            // color: MyStyle().textColor,
            color: Colors.deepPurple,
          ),
          labelText: 'UserName',
          labelStyle: TextStyle(color: MyStyle().textColor),
          // helperText: 'ใส่ Email',
          // helperStyle: TextStyle(color: MyStyle().textColor),
          hintText: 'ใส่ Email',
        ),
        validator: (String value) {
          if (!((value.contains('@')) && (value.contains('.')))) {
            return 'โปรดตรวจสอบข้อมูล';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          labelText: 'Password',
          helperText: '',
          hintText: 'ใส่ รหัสผ่าน',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'โปรดใส่ Password';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          passwordString = value.trim();
        },
      ),
    );
  }

  Widget rememberCheck() {
    return Container(
      width: 320.0,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text('Remember Me'),
        value: statusRemember,
        onChanged: (bool value) {
          onRememberCheck(value);
        },
      ),
    );
  }

  void onRememberCheck(bool value) {
    setState(() {
      statusRemember = value;
    });
  }

  Widget loginButton() {
    return Container(
      width: 100.0,
      margin: const EdgeInsets.only(left: 160.0, right: 20.0),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: Colors.blue[800],
        child: Text(
          'Login',
          style: TextStyle(color: Colors.yellow),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print('email = $emailString, password = $passwordString');
            checkAuthen(); //เรียก php
          }
        },
      ),
    );
  }

// trade  ตรวจสอบ ข้อมูลกับฐาน
  Future<void> checkAuthen() async {
    String urlAPI =
        'https://appdb.tisi.go.th/ForApp/getUserWhereUserEmailEad.php?isAdd=true&reg_email=$emailString&reg_unmd5=$passwordString';

    Response response = await get(urlAPI);
    var result = json.decode(response.body);
    print('result = $result');

    if (result.toString() == 'null') {
      myAlert(
          'authen False', 'No $emailString or $passwordString in my Database');
    } else {
      for (var myData in result) {
        runrecnoString = myData['runrecno'];
        print('runrecno=$runrecnoString');

        if (statusRemember) {
          // Save runrecno
          saveuserThread();
        }

        routeToMyserveice();
      }
    }
  }

  void routeToMyserveice() {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MyService(
        keyRunrecno: runrecnoString,
      );
    });
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute,
        (Route<dynamic> route) {
      return false;
    });
  }

  Future<void> saveuserThread() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('runrecno', runrecnoString);
    sharedPreferences.setBool('remember', statusRemember);
  }

  Widget showTiltle(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        size: 48.0,
        color: MyStyle().textColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: MyStyle().h2,
          color: MyStyle().textColor,
        ),
      ),
    );
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTiltle(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('ตกลง'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, MyStyle().mainColor],
              radius: 1.0,
            ),
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showLogoAndName(),
                  userText(),
                  passwordText(),
                  rememberCheck(),
                  loginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
