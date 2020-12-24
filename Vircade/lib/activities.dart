import 'package:flutter/material.dart';
import 'Songlist.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  songlist() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Songlist()));
  }



  @override
  Widget build(BuildContext context) {
              return Container(
                child: new ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, index){
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
                        child: Card(
                          color: Color(0xFF091F36),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width *
                                    1.05,
                                decoration: BoxDecoration(
                                  color: Color(0xFF16AAE0),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border:
                                  Border.all(color: Colors.grey.withOpacity(.3), width: .2),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Image.asset("assets/dance.png", width:
                                      MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.6),
                                    Text(
                                      "DANCING WITH THE STRANGER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: "Poppins-Bold"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox( height: MediaQuery.of(context).size.width *
                                        0.03),
                                    //  Padding(padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                    //  child: Column()),
                                    InkWell(
                                      child: Container(
                                        width:  MediaQuery.of(context).size.width *
                                            0.4,
                                        height:  MediaQuery.of(context).size.width *
                                          0.13,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF16AAE0),
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
                                            onTap: () => songlist(),
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
                                ),)
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
  }
}
