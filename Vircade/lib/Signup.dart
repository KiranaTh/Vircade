import 'package:Vircade/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Vircade/widgets/provider_widget.dart';

enum AuthFormType { logIn, signUp, reset }

class Signup extends StatefulWidget {
  final AuthFormType authFormType;
  Signup({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignupState createState() => _SignupState(authFormType: this.authFormType);
}

class _SignupState extends State<Signup> {
  AuthFormType authFormType;
  _SignupState({this.authFormType});

  final formKey = GlobalKey<FormState>();

  String _email, _password, _name, _warning;
  String _imageUrl = "https://firebasestorage.googleapis.com/v0/b/vircade-4c1d4.appspot.com/o/PaoPao.gif?alt=media&token=43825617-59d3-46b7-b189-3555a3e88d6f";


  TextEditingController userNameController = new TextEditingController();

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

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.logIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Password reset email sent");
          _warning = "Password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.logIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _name, _imageUrl);
          print("Signed in with new ID $uid");
          String username = await auth.getCurrentuserName();
          print("username: $username");
        }
      } catch (e) {
        setState(() {
          _warning = e.message;
        });
      }
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
                  showAlert(),
                  space(),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(550),
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

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget space() {
    if (_warning != null) {
      return SizedBox(height: ScreenUtil().setHeight(345));
    }
    return SizedBox(height: ScreenUtil().setHeight(450));
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
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "RESET PASSWORD";
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
    if (authFormType == AuthFormType.reset) {
      textFeilds.add(
        TextFormField(
          validator: EmailValidator.validate,
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      return textFeilds;
    }
    if (authFormType == AuthFormType.signUp) {
      textFeilds.add(
        TextFormField(
          controller: userNameController,
          validator: NameValidator.validate,
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
        validator: EmailValidator.validate,
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
        validator: PasswordValidator.validate,
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
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
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
    } else if (authFormType == AuthFormType.reset) {
      _leftButton = "Return to LOG IN";
      _newFormState = "signIn";
      _submitButton = "Submit";
    } else {
      _leftButton = "Return to LOG IN";
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
