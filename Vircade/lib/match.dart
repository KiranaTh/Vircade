import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF091F36),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                height: 100.0,
                width: 100.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                      "MATCHING",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "Poppins-Bold"),
                    ),
            ],
          ),
        ),
      )
    );
  }
}