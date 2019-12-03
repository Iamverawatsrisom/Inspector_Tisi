import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pasadu/screens/home.dart';
import 'package:pasadu/screens/my_stye.dart';
import 'package:pasadu/widget/main_home.dart';
import 'package:pasadu/widget/page1.dart';
import 'package:pasadu/widget/page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Widget currenWidget = MainHome();

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
          String name = map['reg_fname'];
          String surName = map['reg_lname'];
          loginString = '$name $surName';
        });
      }
    }
  }

  Widget menuHome() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 48.0,
        color: Colors.blue,
      ),
      title: Text('Home'),
      subtitle: Text('description of Home'),
      onTap: () {
        setState(() {
          currenWidget=MainHome();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuPage1() {
    return ListTile(
      leading: Icon(
        Icons.shopping_cart,
        size: 48.0,
        color: Colors.green.shade800,
      ),
      title: Text('Page 1'),
      subtitle: Text('Description Page1'),
      onTap: () {
        setState(() {
          currenWidget=Page1();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuPage2() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: 48.0,
        color: Colors.lime.shade800,
      ),
      title: Text('Show Map'),
      subtitle: Text('description of Map'),
      onTap: () {
        setState(() {
          currenWidget=MyMap();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuExit() {
    return ListTile(
      leading: Icon(
        Icons.close,
        size: 48.0,
        color: Colors.purple.shade800,
      ),
      title: Text('Exit Program'),
      subtitle: Text('ออกจากโปรแกรม'),
      onTap: () {
        Navigator.of(context).pop();
        exit(0);
      },
    );
  }

  Widget menuSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 48.0,
        color: Colors.orange.shade800,
      ),
      title: Text('Singout and Exit'),
      subtitle: Text('ออกจากระบบ'),
      onTap: () {
        Navigator.of(context).pop();
        processSingOut();
      },
    );
  }

  Future<void> processSingOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context){return Home();});
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute,(Route <dynamic> route){return false;});

  }

  Widget showLogin() {
    return Text(
      'Login By $loginString',
      style: TextStyle(color: Colors.yellow.shade100),
    );
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
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
          menuHome(),
          Divider(
            thickness: .5,
          ),
          menuPage1(),
          Divider(
            thickness: .5,
          ),
          menuPage2(),
          Divider(
            thickness: .5,
          ),
          menuExit(),
          Divider(
            thickness: .5,
          ),
          menuSignOut(),
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
      body: currenWidget,
      drawer: showDrawer(),
    );
  }
}
