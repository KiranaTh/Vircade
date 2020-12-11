import 'package:Vircade/widgets/provider_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'calculating.dart';

class Dancing extends StatefulWidget {
  final String gameID;
  final String song;
  final String uid;
  final String video;
  Dancing({Key key, @required this.gameID, @required this.song, @required this.uid, @required this.video}) : super(key: key);
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

  int _counter = 0;

  streamSensor(){
    new Timer.periodic(
        Duration(milliseconds: 50),
            (Timer timer) async {
              setState(() {
                _counter++;
              });
//              if( _counter % 2 == 0 ){
                //print(_counter);
                _streamSubscriptions
                    .add(accelerometerEvents.listen((AccelerometerEvent event) {
                  if(event.x != null ){
                    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
                      subscription.resume();
                    }
                    setState(() {
                      _accelerometerValues = <double>[event.x, event.y, event.z];
                      i++;
                      for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
                        subscription.pause();
                      }
                    });
                    print("eventx not null=> $_counter: $i");
                  }else{
                    setState(() {
                      _accelerometerValues = <double>[0.00000000, 0.00000000, 0.00000000];
                      i++;
                      for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
                        subscription.pause();
                      }
                    });
                  }
                }));
//              }
              if(_counter == 318){
                for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
                  subscription.cancel();
                  timer.cancel();
                }
              }
        });
  }

  route(){
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    print(datas);
    updateData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Calculating(gameID: widget.gameID, song: widget.song, uid: widget.uid)));
  }

  void updateData() async {
    print("widget.gameID: ${widget.gameID} widget.uid: ${widget.uid} widget.song: ${widget.song}");
    final uid = await Provider.of(context).auth.getCurrentUID();
    databaseReference.child("games").child(widget.gameID).child(uid).update({
      'ML': datas,
    });
//    databaseReference.reference().child("test").child(widget.gameID).update({"time": ServerValue.timestamp, "song": widget.song, '$uid': {"ML": "", "score": 0}});
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
    if(i >= 270){
      datas = List.generate(270, (index) => accelerometer);
    }else{
      int length = i;
      datas = List.generate(i, (index) => accelerometer);
      if(length <= 270 ){
        datas.add(["0.00000000", "0.00000000", "0.00000000"]);
        length++;
      }
    }
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
