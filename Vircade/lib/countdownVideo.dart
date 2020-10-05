import 'dart:async';
import 'package:Vircade/dancing.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class CountdownVideo extends StatefulWidget {
  final String video;
  CountdownVideo({Key key, @required this.video}) : super(key: key);

  @override
  _CountdownVideoState createState() => _CountdownVideoState();
}

class _CountdownVideoState extends State<CountdownVideo> {
  VideoPlayerController _videoController;
  var size;
  Timer timer;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.video)
      ..initialize()
      ..setLooping(false)
      ..addListener(() {
        if (_videoController.value.initialized &&
            !_videoController.value.isPlaying) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dancing()));
        }
      })
      ..play().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        child: RotatedBox(
      quarterTurns: 0,
      child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: VideoPlayer(_videoController),
              ),
            ],
          )),
    ));
  }
}
