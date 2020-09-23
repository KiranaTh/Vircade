import 'dart:async';
import 'package:Vircade/countdownVideo.dart';
import 'package:flutter/material.dart';

class TimerCount extends StatefulWidget {
  final String video;
  TimerCount({Key key, @required this.video}) : super(key: key);

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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CountdownVideo(video: widget.video)));
  }

  void countdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
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
              Text("It will countdown in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 30,
                  )),
              Text("$_start",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 25,
                  ))
            ],
          ),
        ));
  }
}
