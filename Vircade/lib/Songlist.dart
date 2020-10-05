import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'model/video.dart';
import 'homeheader.dart';
import 'timer.dart';

class Songlist extends StatefulWidget {
  @override
  _SonglistState createState() => _SonglistState();
}

class _SonglistState extends State<Songlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayers(),
    );
  }
}

class VideoPlayers extends StatefulWidget {
  @override
  _VideoPlayersState createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    getLength();
  }

  getLength() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('song').getDocuments();
    _tabController = TabController(length: qn.documents.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getVideo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Scaffold(
                backgroundColor: Color(0xFF091F36),
                body: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          height: 80.0,
                          width: 80.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "LOADING",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: "Poppins-Bold"),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return RotatedBox(
                quarterTurns: 1,
                child: TabBarView(
                    controller: _tabController,
                    children: List.generate(songs.length, (index) {
                      return VideoPlayerItem(
                        video: songs[index]['video'],
                        size: size,
                        singer: songs[index]['singer'],
                        song: songs[index]['song'],
                      );
                    })));
          }
        });
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String video;
  final String singer;
  final String song;
  VideoPlayerItem(
      {Key key, @required this.size, this.singer, this.song, this.video})
      : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.video)
      ..initialize()
      ..setLooping(true)
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
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
          height: widget.size.height,
          width: widget.size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: BoxDecoration(color: Colors.black),
                child: VideoPlayer(_videoController),
              ),
              Container(
                height: widget.size.height,
                width: widget.size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        HeaderHomePage(),
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            LeftPanel(
                              size: widget.size,
                              video: widget.video,
                              song: "${widget.song}",
                              singer: "${widget.singer}",
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class LeftPanel extends StatelessWidget {
  final String singer;
  final String song;
  final String video;
  const LeftPanel({
    Key key,
    @required this.size,
    this.singer,
    this.song,
    this.video,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: size.height,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.music_note,
                color: Colors.white,
                size: 25,
              ),
              Flexible(
                child: Text(
                  song,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Icon(Icons.album, color: Colors.white, size: 20),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  singer,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Bold",
                      fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 26.0, right: 26.0),
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF8B93), Color(0xFFFF414E)]),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0)
                  ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => new Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          child: dialogContent(context, video)),
                    );
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
      ),
    );
  }

  Widget dialogContent(BuildContext context, video) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 18.0, left: 9.0, right: 9.0),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text("Select mode",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                          fontFamily: "Poppins-Bold",
                          letterSpacing: 1.0)),
                ) //
                    ),
                SizedBox(height: 24.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      "Single mode",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "Poppins-Bold",
                          letterSpacing: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CountdownVideo(
                    //               video: video,
                    //             )));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TimerCount(
                              video: video,
                            )));
                  },
                ),
                SizedBox(height: 24.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      "Battle mode",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "Poppins-Bold",
                          letterSpacing: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/match");
                  },
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
