import 'package:flutter/material.dart';
import 'package:pasadu/screens/my_stye.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// explicit
  bool statusRemember = false; //false => ไม่ save true = save'
  final formKey = GlobalKey<FormState>();

// method

  Widget showlogo() {
    return Container(
      width: 70.0,
      height: 70.0,
      child: Image.asset('images/Login.png'),
    );
  }

  Widget showLogoAndName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showlogo(),
        SizedBox(
          width: 20.0,
        ),
        showAppName(),
      ],
    );
  }

  Widget showAppName() {
    return Text(
      'ร้าน มอก.',
      style: TextStyle(
        fontSize: 20.0,
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
          hintText: 'Exam Mymail.com',
        ),
        validator: (String value) {
          if (!((value.contains('@')) && (value.contains('.')))) {
            return 'Please Keep Email Format';
          } else {
            return null;
          }
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
          hintText: 'Exam YourPasword',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Pleas Type Password';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget remmemberCheck() {
    return Container(
      width: 300.0,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text('Remember Me'),
        value: statusRemember,
        onChanged: (bool value) {},
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue[900],
        child: Text(
          'login',
          style: TextStyle(color: Colors.yellow),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {}
        },
      ),
    );
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
                  remmemberCheck(),
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
