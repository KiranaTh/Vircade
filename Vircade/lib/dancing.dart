import 'package:Vircade/showScore.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

class Dancing extends StatefulWidget {
  @override
  _DancingState createState() => _DancingState();
}

class _DancingState extends State<Dancing> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int i = 1;
  double _progress = 0;
  List<double> _accelerometerValues;
  List<List<String>> datas;
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
              timer.cancel();
              return route();
            }
          }
        },
      ),
    );
  }

  route() {
    print(datas);
    updateData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShowScore()));
  }

  void updateData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    databaseReference.child("ML").push().child(uid).set({
      'data': datas,
    });
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
        _accelerometerValues = <double>[event.x, event.y, event.z];
        i++;
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
    datas = List.generate(i, (index) => accelerometer);
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
