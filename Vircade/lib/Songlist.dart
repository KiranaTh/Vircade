import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'match.dart';

class Songlist extends StatefulWidget {
  @override
  _SonglistState createState() => _SonglistState();
}

class _SonglistState extends State<Songlist> {
  int page;
  final db = Firestore.instance;

  Future getSong() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('song').getDocuments();

    return qn.documents;
  }

  int _index = 0;
  VideoPlayerController _controller;

  @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/Plain Jane.MP4')
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _controller.play();
  //       _controller.setLooping(true);
  //       _controller.setVolume(0.5);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getSong(),
          builder: (_, snapshot) {
            return PageView.builder(
                itemCount: snapshot.data.length,
                controller: PageController(viewportFraction: 1),
                onPageChanged: (int index) => setState(() {
                      _index = index;
                      _controller.play();
                      _controller.setLooping(true);
                      _controller.setVolume(0.5);
                    }),
                itemBuilder: (_, i) {
                  _controller = VideoPlayerController.asset(
                      snapshot.data[i].data["video"]);
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        child: _controller.value.initialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ),
                      Column(
                        // children: <Widget>[
                        //   Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment.bottomRight,
                        //         colors: [
                        //           Colors.black.withOpacity(.7),
                        //           Colors.black.withOpacity(.2)
                        //         ],
                        //       ),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(20.0),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: <Widget>[
                        //           Expanded(
                        //             child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(20.0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data[i].data["song"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontFamily: "Poppins-Bold"),
                              ),
                              Text(
                                snapshot.data[i].data["singer"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "Poppins-Bold"),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 26.0, right: 26.0),
                                  width: 350,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xFFFF8B93),
                                        Color(0xFFFF414E)
                                      ]),
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF6078ea)
                                                .withOpacity(.3),
                                            offset: Offset(0.0, 8.0),
                                            blurRadius: 8.0)
                                      ]),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Match()));
                                      },
                                      child: Center(
                                        child: Text("Let's Dance",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins-Bold",
                                                fontSize: 18,
                                                letterSpacing: 1.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          )
                        ],
                      ),
                      // ),
                    ],
                    // ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                  );
                });
          }),
    );
  }
}
