import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:redditech_lucas_nora/UserProfile/profile.dart';
import 'package:redditech_lucas_nora/UserProfile/user_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'package:redditech_lucas_nora/Auth/myweb.dart';
import 'package:redditech_lucas_nora/themes.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';


final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
void _doSomething() async {
  Timer(Duration(seconds: 3), () {
    _btnController.success();
  });
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                leading: Icon(Icons.lock),
                title: Text("Login Page"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 150,
                            child: Image.asset('assets/images/redditech_icon.png')),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      child : RoundedLoadingButton(
                        child: const Text('Connect With Reddit', style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () {
                          _doSomething();
                          Navigator.push(
                            context, MaterialPageRoute(builder: (_) =>  WebViewPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}