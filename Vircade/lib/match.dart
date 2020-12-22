import 'package:Vircade/SplashScreen.dart';
import 'package:Vircade/timer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';


class Match extends StatefulWidget {
  final String song;
  final String uid;
  final String video;
  final String status;
  Match({
    Key key,
    @required this.song,
    @required this.uid,
    @required this.video,
    @required this.status
  }) : super(key: key);
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  final databaseReference = FirebaseDatabase.instance.reference();
  Timer timer;
  String gameID;


  @override
  void initState() {

   databaseReference.child("waitingRoom").child(widget.song).onValue.listen((event) {
      var snapshot = event.snapshot;
      gameID = snapshot.value[widget.uid];
      print('Value is $gameID');
      if (gameID != 'waiting') {
        databaseReference.child("games").child(gameID).once().then((DataSnapshot data){
          print("data snapshot: ${data.key}");
          gameID = data.key;
          route2(gameID);
          quiteWaitingRoom();
        });
      }
    });
   setState(() {
     timer = new Timer(const Duration(minutes: 1),(){
       route1();
       quiteWaitingRoom();
     });
   });
    super.initState();
  }

  quiteWaitingRoom(){
    databaseReference.child("waitingRoom").child(widget.song).child(widget.uid).remove();
  }

  route1() {
    print("out of time");
    timer.cancel();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeController()));
  }

  route2(String gameID) {
    print("can change page");
    timer.cancel();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TimerCount(video: widget.video, gameID: gameID, song: widget.song, uid: widget.uid, status: widget.status)));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
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
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "MATCHING",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: "Poppins-Bold"),
                ),
              ],
            ),
          ),
        ));
  }
}

