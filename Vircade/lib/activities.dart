import 'package:flutter/material.dart';
import 'test.dart';

class Activities extends StatefulWidget {

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

test(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Test()
    ));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF091F36),
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
         child: new Column(
           children: <Widget>[
             Align(
               alignment: Alignment.center,
               child: Padding(
                 padding: EdgeInsets.only(top: 30.0, bottom: 25.0),
                 child:
                  Image.asset("assets/logo.png", width: 62.0, height: 43.0),
               ),
             ),
             Container(
               width: double.infinity,
               height: 380.0,
               decoration: BoxDecoration(
                 color: Color(0xFF6078ea),
                 borderRadius: BorderRadius.circular(20.0),
                 border: Border.all(
                   color: Colors.grey.withOpacity(.3), width: .2
                 ),
               ),
               child: Column(
                 children: <Widget>[
                   SizedBox(
                     height: 20.0,
                   ),
                   Image.asset("assets/dance.png", width: 261.0, height: 191.0),
                   Text("DANCING WITH THE STRANGER",
                   style: TextStyle(color: Colors.white,fontSize: 25.0, fontFamily: "Poppins-Bold"),
                   textAlign: TextAlign.center,),
                   SizedBox(height: 15.0),
                  //  Padding(padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  //  child: Column()),
                  InkWell(

                        child: Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF6078ea),
                              border: Border.all(
                                color: Colors.red[200],
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
                              onTap: () => test(),
                              child: Center(
                                child: Text("PLAY",
                                    style: TextStyle(
                                        color: Colors.red[200],
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                 ],
               ),
             )
           ],
         ),
       ),
    );
  }
}