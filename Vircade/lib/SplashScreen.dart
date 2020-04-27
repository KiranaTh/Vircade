import 'dart:async';

import 'package:flutter/material.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 4);
    return Timer(duration,route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Login()
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF091F36),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Container(
               child: Image.asset("assets/logo.png")
             ),
             Padding(padding: EdgeInsets.only(top: 20)),
           ],
         ),
       )
    );
  }
}