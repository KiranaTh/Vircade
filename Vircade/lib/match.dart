import 'package:Vircade/SplashScreen.dart';
import 'package:Vircade/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dancing.dart';

class Match extends StatefulWidget {
  final String song;
  Match({
    Key key,
    @required this.song,
  }) : super(key: key);
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
//  final databaseReference = FirebaseDatabase.instance.reference();
//  StreamSubscription<Event> _addedSubscription;
//  Query matching;
  //List<Waiting> waitingList;

  @override
  void initState() {
    super.initState();
    startTimer();
    //waitingList = new List();
//    String song = widget.song;
//    print("widget.song $song ");
//    matching = databaseReference.child("waitingRoom").child(widget.song);
//    _addedSubscription = matching.onChildAdded.listen(onEntryAdded);
  }

  startTimer() async {
    var duration = Duration(minutes: 6);
    return Timer(duration, route1);
  }

  route1() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeController()));
  }

  route2() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dancing()));
  }

  @override
  void dispose() {
    //_addedSubscription.cancel();
    super.dispose();
  }

  onEntryAdded(Event event) {
    setState(() {
//      waitingList.add(Waiting.fromSnapshot(event.snapshot));
//      print(waitingList.toString());
//      DatabaseReference db = databaseReference.child("game").push();
//      if (waitingList.length == 2) {
//        for (int i = 0; i <= waitingList.length-1; i++) {
//          String uid = waitingList.toString();
//          print("waitingList.toString() $uid ");
//          db.child("player$i").set({
//            "userUID": uid,
//            "score": 0
//          }).then((_) {
//            databaseReference
//                .child("waitingRoom")
//                .child(widget.song)
//                .child(uid)
//                .remove()
//                .then((_) {
//              print("Delete $uid successful");
//              setState(() {
//                waitingList.removeAt(i);
//              });
//            });
//          });
//        }
//        db.set({'timestamp': DateTime.now().millisecondsSinceEpoch}).then(
//            route2());
//      }
    });
//    DatabaseReference db = databaseReference.child("game").push();
//    if (waitingList.length == 2) {
//      for (int i = 0; i <= waitingList.length-1; i++) {
//        String uid = waitingList.toString();
//        print("waitingList.toString() $uid ");
//        db.child("player$i").set({
//          "userUID": uid,
//          "score": 0
//        }).then((_) {
//          databaseReference
//              .child("waitingRoom")
//              .child(widget.song)
//              .child(uid)
//              .remove()
//              .then((_) {
//            print("Delete $uid successful");
//            setState(() {
//              waitingList.removeAt(i);
//            });
//          });
//        });
//      }
//      db.set({'timestamp': DateTime.now().millisecondsSinceEpoch}).then(
//          route2());
//    }
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
