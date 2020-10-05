import 'package:Vircade/Home.dart';
import 'package:Vircade/Songlist.dart';
import 'package:Vircade/dancing.dart';
import 'package:Vircade/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'Signup.dart';
import 'package:Vircade/avartarlist.dart';
import 'Songlist.dart';
import 'match.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          title: 'Vircade',
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) =>
                Signup(authFormType: AuthFormType.signUp),
            '/logIn': (BuildContext context) =>
                Signup(authFormType: AuthFormType.logIn),
            '/home': (BuildContext context) => HomeController(),
            '/avatar': (BuildContext context) => AvatarList(),
            '/song': (BuildContext context) => Songlist(),
            '/home1': (BuildContext context) => Home(),
            '/match': (BuildContext context) => Match(),
          },
        ));
  }
}
