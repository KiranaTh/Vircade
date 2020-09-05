//import 'package:Vircade/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'FormCard.dart';
//import 'Login.dart';
//import 'test.dart';
import 'package:Vircade/widgets/provider_widget.dart';

enum AuthFormType { logIn, signUp }

class Signup extends StatefulWidget {
  final AuthFormType authFormType;
  Signup({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignupState createState() => _SignupState(authFormType: this.authFormType);
}

class _SignupState extends State<Signup> {
  route() {
    Navigator.of(context).pushReplacementNamed('/signUp');
  }

  // test() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => Test()));
  // }

  AuthFormType authFormType;
  _SignupState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.logIn;
      });
    }
  }

  void submit() async {
    final form = formKey.currentState;
    form.save();
    try {
      final auth = Provider.of(context).auth;
      if (authFormType == AuthFormType.logIn) {
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        String uid =
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
        print("Signed in with new ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Color(0xFF091F36),
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          showPic(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: ScreenUtil().setWidth(110),
                        height: ScreenUtil().setHeight(110),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(450),
                  ),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(500),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                        BoxShadow(
                            color: Colors.white12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildInputs(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildButtons(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showPic() {
    String pic;
    if (authFormType == AuthFormType.signUp) {
      pic = "assets/signup.png";
    } else {
      pic = "assets/login.png";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Image.asset(pic),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFeilds = [];
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "SIGN UP";
    } else {
      _headerText = "LOG IN";
    }

    textFeilds.add(
      Text(_headerText,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(45),
              fontFamily: "Poppins-Bold",
              letterSpacing: .6)),
    );
    textFeilds.add(
      SizedBox(
        height: ScreenUtil().setHeight(30),
      ),
    );
    if (authFormType == AuthFormType.signUp) {
      textFeilds.add(
        TextFormField(
          decoration: buildSignUpInputDecoration("Username"),
          onSaved: (value) => _name = value,
        ),
      );
    }
    textFeilds.add(
      SizedBox(
        height: ScreenUtil().setHeight(30),
      ),
    );
    textFeilds.add(
      TextFormField(
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFeilds.add(
      SizedBox(
        height: ScreenUtil().setHeight(30),
      ),
    );
    textFeilds.add(
      TextFormField(
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    if (authFormType == AuthFormType.logIn) {
      textFeilds.add(FlatButton(
        padding: const EdgeInsets.all(0),
        child: Text("Forgot Password",
            style: TextStyle(
                color: Color(0xFF6078ea),
                fontFamily: "Poppins-Medium",
                fontSize: ScreenUtil().setSp(28))),
        onPressed: () => route(),
      ));
    }
    return textFeilds;
  }

  List<Widget> buildButtons() {
    String _leftButton, _submitButton, _newFormState;
    bool statesignUp;
    if (authFormType == AuthFormType.logIn) {
      _leftButton = "Create New Account";
      _newFormState = "signUp";
      _submitButton = "LOG IN";
      statesignUp = false;
    } else {
      _leftButton = "Go Back to LOG IN";
      _newFormState = "logIn";
      _submitButton = "SIGN UP";
      statesignUp = true;
    }
    return [
      InkWell(
        child: Container(
          width: ScreenUtil().setWidth(280),
          height: ScreenUtil().setHeight(100),
          decoration: BoxDecoration(
              color: Color(0xFF091F36),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => switchFormState(_newFormState),
              child: Center(
                child: Text(_leftButton,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Bold",
                        fontSize: 18,
                        letterSpacing: 1.0)),
              ),
            ),
          ),
        ),
      ),
      InkWell(
        child: Container(
          width: ScreenUtil().setWidth(280),
          height: ScreenUtil().setHeight(100),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: statesignUp == true
                      ? [Color(0xFFFF8B93), Color(0xFFFF414E)]
                      : [Color(0xFF17ead9), Color(0xFF6078ea)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => submit(),
              child: Center(
                child: Text(_submitButton,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Bold",
                        fontSize: 18,
                        letterSpacing: 1.0)),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

InputDecoration buildSignUpInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.white,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
  );
}
