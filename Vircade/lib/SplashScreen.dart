import 'dart:async';
import 'package:Vircade/Signup.dart';
import 'Home.dart';
import 'package:Vircade/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:Vircade/widgets/provider_widget.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, check);
  }

  check() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(child: Image.asset("assets/logo.png")),
              Padding(padding: EdgeInsets.only(top: 20)),
            ],
          ),
        ));
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : Signup(authFormType: AuthFormType.logIn);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
