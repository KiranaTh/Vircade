import 'package:Vircade/avatar.dart';
import 'package:Vircade/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'Signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          title: 'Vircade',
          home: Signup(authFormType: AuthFormType.signUp),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) =>
                Signup(authFormType: AuthFormType.signUp),
            '/logIn': (BuildContext context) =>
                Signup(authFormType: AuthFormType.logIn),
            '/home': (BuildContext context) => HomeController(),
            '/avatar': (BuildContext context) => Avatar(),
          },
        ));
  }
}
