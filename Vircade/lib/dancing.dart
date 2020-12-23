import 'package:Vircade/widgets/provider_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'calculating.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dancing extends StatefulWidget {
  final String gameID;
  final String song;
  final String uid;
  final String video;
  final String status;
  Dancing(
      {Key key,
      @required this.gameID,
      @required this.song,
      @required this.uid,
      @required this.video,
      @required this.status})
      : super(key: key);
  @override
  _DancingState createState() => _DancingState();
}

class _DancingState extends State<Dancing> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int i = 1;
  double _progress = 0;
  List<double> _accelerometerValues;
  List datas = [];
  List dataset =[];
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

  int _counter = 0;

  streamSensor() {
    new Timer.periodic(Duration(milliseconds: 50), (Timer timer) async {
      setState(() {
        _counter++;
      });
      _streamSubscriptions
          .add(accelerometerEvents.listen((AccelerometerEvent event) {
        if (event.x != null) {
          for (StreamSubscription<dynamic> subscription
              in _streamSubscriptions) {
            subscription.resume();
          }
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            i++;
            for (StreamSubscription<dynamic> subscription
                in _streamSubscriptions) {
              subscription.pause();
            }
            if(i <= 130){
              datas.add(
                  _accelerometerValues?.map((double v) => v.toStringAsFixed(8))
                      ?.toList());}
          });
          print("eventx not null=> $_counter: $i");
        }
      }));
//              }
      if (_counter == 318) {
        for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
          subscription.cancel();
          timer.cancel();
        }
      }
    }
    );
  }

  route() {
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    print(datas);
    updateData();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Calculating(
                gameID: widget.gameID, song: widget.song, uid: widget.uid, status: widget.status)));
  }

  void updateData() async {
     if(datas.length <= 130){
      List d = List.generate(130 - datas.length, (index) => [ 0.00000000, 0.00000000,  0.00000000]);
      datas.addAll(d);
    }
    final uid = await Provider.of(context).auth.getCurrentUID();
    databaseReference.child("games").child(widget.gameID).child(uid).update({
      'ML':  datas,
    });
    databaseReference.child("games").child(widget.gameID).update({'highScore':0});
    final url = 'https://vircade2020.herokuapp.com/model/classify';
    http.post(url,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic>{"gameID": widget.gameID, 'userId': uid, 'song': widget.song, 'ml': datas}));

  }


  VideoPlayerController _videoController;

  @override
  void initState() {
    _videoController = VideoPlayerController.network(widget.video)
      ..initialize()
      ..setLooping(false)
      ..addListener(() {
        if (_videoController.value.initialized &&
            !_videoController.value.isPlaying) {
          route();
        }
      })
      ..play().then((value) {
        setState(() {
          _progress = 0;
        });
        startTimer();
        VideoPlayer(_videoController);
        streamSensor();
//        _streamSubscriptions
//            .add(accelerometerEvents.listen((AccelerometerEvent event) {
//          setState(() {
//            _accelerometerValues = <double>[event.x, event.y, event.z];
//            i++;
//          });
//        }));
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(8))?.toList();
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
