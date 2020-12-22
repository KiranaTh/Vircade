import 'dart:async';
import 'package:Vircade/dancing.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class CountdownVideo extends StatefulWidget {
  final String video;
  final String gameID;
  final String song;
  final String uid;
  final String status;
  CountdownVideo({Key key, @required this.video, @required this.gameID, @required this.song, @required this.uid, @required this.status}) : super(key: key);

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
              context, MaterialPageRoute(builder: (context) => Dancing(gameID: widget.gameID, song: widget.song, uid: widget.uid, video: widget.video, status: widget.status)));
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
