import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'leaderboard.dart';

class Dancing extends StatefulWidget {
  @override
  _DancingState createState() => _DancingState();
}

class Accelerometer {
  String userUID;
  String song;
  Timer time;
  List<Data> datas;

  Accelerometer({this.userUID, this.song, this.time, this.datas});
  Map<String, dynamic> toJson() {
    return {
      "userUID": userUID,
      "song": song,
      "time": time,
      "Data": datas.map((data) => data.toJson()).toList(),
    };
  }
}

class Data {
  Double x;
  Double y;
  Double z;

  Data({this.x, this.y, this.z});
  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
      "z": z,
    };
  }
}

class _DancingState extends State<Dancing> {
  double _progress = 0;
  Accelerometer accelerometer;
  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress >= 1) {
            timer.cancel();
          } else {
            _progress += 1 / 15;
            if (_progress >= 1) {
              print(_accelerometerValues);
              return route();
            }
          }
        },
      ),
    );
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LeaderBoard()));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _progress = 0;
    });
    startTimer();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        //_accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(8))?.toList();
    //print(accelerometer);

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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Accelerometer: $accelerometer',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
