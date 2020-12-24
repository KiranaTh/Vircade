import 'package:Vircade/showScore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class Calculating extends StatefulWidget {
  final String gameID;
  final String song;
  final String uid;
  final String status;
  Calculating({
    Key key,
    @required this.gameID,
    @required this.song,
    @required this.uid,
    @required this.status
  }) : super(key: key);

  @override
  _Calculating createState() => _Calculating();
}

class _Calculating extends State<Calculating> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final db = Firestore.instance;
  Timer timer;
  int score;
  var timestamp;

  @override
  void initState() {
    databaseReference.child("games").child(widget.gameID).child(widget.uid).onValue.listen((event) {
      var snapshot = event.snapshot;
      score = snapshot.value["score"];
      print('score is $score');
        if (score != null && score != 0) {
          databaseReference.child("games").child(widget.gameID).child("time").once().then((DataSnapshot snap){
            Store data = Store( snap.value.toString() , {
              "score": score,
              "song": widget.song}
            );
            databaseReference.child("games").child(widget.gameID).once().then((DataSnapshot snapshot){
              Map<dynamic, dynamic> values=snapshot.value;
              print(values["highScore"]);
              if(values["highScore"] <= score){
                databaseReference.child("games").child(widget.gameID).update({'highScore': score});
              }
            });
            db.collection("dancing").add({"userId": widget.uid, "score": score, "song": widget.song, "time": snap.value.toString()}).then((value){route1();});

//            db.collection("dancing").document(widget.uid).setData({"history": FieldValue.arrayUnion([{ "score": score,
//              "song": widget.song, "time": snap.value.toString()}])}, merge: true
//            ).then((value){
//              route1();
//            });
     });
    }});
    setState(() {
      timer = new Timer(const Duration(minutes: 1),(){
        outOfTime();
      });
    });
    super.initState();
  }

  outOfTime(){
    databaseReference.child("games").child(widget.gameID).child("time").once().then((DataSnapshot snap){
      Store data = Store( snap.value.toString() , {
        "score": 0,
        "song": widget.song}
      );
      db.collection("dancing").add({"userId": widget.uid, "score": score, "song": widget.song, "time": snap.value.toString()}).then((value){route1();});

//      db.collection("dancing").document(widget.uid).setData({"history": FieldValue.arrayUnion([{ "score": score,
//        "song": widget.song, "time": snap.value.toString()}])}, merge: true
//      ).then((value){
//        route1();
//      });
    });
  }

  route1() {
    timer.cancel();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShowScore(score: score, gameID: widget.gameID, status: widget.status)));
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                  "CALCULATING",
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


class Store {
  String time;
  Map<String, dynamic> sets = {};
  Store(this.time, this.sets);

  Map<String ,dynamic> toMap() => {
    this.time : this.sets
  };
}
