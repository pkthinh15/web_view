import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled11/main.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Webview extends StatefulWidget {
  @override
  _WebviewState createState() => new _WebviewState();
}

class _WebviewState extends State<Webview> {
  String mail='';
  String pass='';
  var your_bear=null;
  // Map<String,String> data={"Authorization","Bearer your_token"} as Map<String, String>;
  // Future getcookies()async {
  //   final repose = await Dio().post('https://courses.elitelearning.vn/oauth2/login/',data: {"Authorization":"Bearer $your_bear"});
  //   final cookie=repose.data;
  //   print(cookie);
  // }

  Future<void> authenticate(String email, String pass) async {
    String myurl =
        "https://devcourses.elitelearning.vn//oauth2/access_token/";
    var response=await http.post(Uri.parse(myurl),  body: {
      "grant_type": "password",
      "client_id": "e10f0ece8e76d9f286e3",
      "username": email,
      "password": pass
    });
    // print(reponse.statusCode);
    var jsonResponse = null;
    your_bear=await json.decode(response.body)['access_token'];

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {



        // Navigator used to enter inside app if the authentication is correct
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: your_bear),
          ),
        );
      }
    } else {
      print("Error message like email or password wrong!!!!");  // Toast
    }
  }
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/lock.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      onChanged: (text) {
        mail = text;
      },

      decoration: InputDecoration(
        hintText: 'Enter your email...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      onChanged: (text) {
        pass = text;
      },

      decoration: InputDecoration(
        hintText: 'Enter your password...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = new RaisedButton(
      child: const Text('Sign In'),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      elevation: 10.0,
      splashColor: Colors.blueGrey,
      onPressed: () {
        authenticate(mail, pass)
;        // Perform some action
        // getcookies();
      },
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 45.0),
            email,
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 15.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}