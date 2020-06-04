import 'package:flutter/material.dart';
import 'dart:async';
import 'leaderboard.dart';

class Dancing extends StatefulWidget {
  @override
  _DancingState createState() => _DancingState();
}

class _DancingState extends State<Dancing> {
  double _progress = 0;

 startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == 1) {
            timer.cancel();
          } else {
            _progress += 0.2;
            if(_progress == 1){
              return route();
            }
          }
        },
      ),
    );
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => LeaderBoard()
    ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _progress = 0;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Image.asset("assets/walk.gif"),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: Text("DO A DANCE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "Poppins-Bold")))),
                SizedBox(height: 50.0),
                SizedBox(
                  height: 18.0,
                  child: LinearProgressIndicator(
                      backgroundColor: Colors.pink[100],
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pink[300]),
                      value: _progress),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ));
  }
}
