import 'dart:async';
import 'package:Vircade/countdownVideo.dart';
import 'package:flutter/material.dart';

class TimerCount extends StatefulWidget {
  final String video;
  final String gameID;
  final String song;
  final String uid;
  TimerCount({Key key, @required this.video, @required this.gameID, @required this.song, @required this.uid}) : super(key: key);

  @override
  _TimerCountState createState() => _TimerCountState();
}

class _TimerCountState extends State<TimerCount> {
  Timer _timer;
  int _start = 5;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    _timer.cancel();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CountdownVideo(video: widget.video, gameID: widget.gameID, song: widget.song, uid: widget.uid)));
  }

  void countdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countdown();
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Start remember",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 25,
                  )),
              Text("the move",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 25,
                  )),
              Text("in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 25,
                  )),
              Text("$_start sec",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 35,
                  ))
            ],
          ),
        ));
  }
}
