//import 'dart:html';

import 'package:Vircade/Signup.dart';
import 'package:Vircade/services/auth_service.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'test.dart';
import 'model/score.dart';
import 'SplashScreen.dart';
import 'package:Vircade/services/auth_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var uid;
  var username;
  var imageUrl;
  var song;
  var score;
  List songlist;
  List scorelist;


  Future getData() async {
    uid = await Provider.of(context).auth.getCurrentUID();
    username = await Provider.of(context).auth.getCurrentuserName();
    imageUrl = await Provider.of(context).auth.getCurrentAvatar();
    List d = [uid, username, imageUrl];
    return d;
  }

getDocument() async {
    uid = await Provider.of(context).auth.getCurrentUID();
    Firestore.instance.collection("dancing").document(uid).get().then((docSnapshot){
      print("length: "+ docSnapshot.data["history"].length.toString());
      songlist.addAll(docSnapshot.data["history"]);
      return songlist;
    });
  }

  @override
  void initState() {
//    getData();
//    getDocument();
//      Firestore.instance.collection("dancing").document(uid).get().then((docSnapshot){
//    print("length: "+ docSnapshot.data["history"].length.toString());
//    int len = docSnapshot.data["history"].length;
//    for(int i = 0; i <= 5; i++){
//      int indx = len - i;
//      setState(() {
//      songlist.add(docSnapshot.data["history"][indx]["song"]);
//      scorelist.add(docSnapshot.data["history"][indx]["score"]);
//      });
//    }
//   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    getDocument();
    var id;
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: Container(
          child: Column(children: <Widget>[
          FutureBuilder(future: getData(),builder: (context, snapshot){
            id = snapshot.data[0];
            return Container(
              height: 230.0,
              color: Color(0xFF091F36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage:  NetworkImage(snapshot.data[2]),
                      ),
                      SizedBox(width: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                          snapshot.data[1],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            child: InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xFF091F36),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF6078ea),
                                      )
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      try {
                                        AuthService auth =
                                            Provider.of(context).auth;
                                        await auth.signOut();
                                        print("Signed out");
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Center(
                                      child: Text("Sign Out",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 15,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )),
            child: Column(
              children: <Widget>[
                Text(
                  "MY TOP DANCES",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                    child: DraggableScrollableSheet(
                        initialChildSize: 0.96,
                        maxChildSize: 0.96,
                        minChildSize: 0.96,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
//                          getDocument();
                          return new StreamBuilder(stream: Firestore.instance.collection("dancing").orderBy("score", descending: true).limit(5).where("userId",isEqualTo: id).snapshots(), builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                             if(!snapshot.hasData){
                              return Container(child: Text("loading"),);
                            }
                              return ListView(
                                  children: snapshot.data.documents.map((doc){
                                    return Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                    child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        doc["song"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        doc["score"].toString(),
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                      ),
                                    );
                                  }).toList()
                                );
//                            child: ListView.builder(
//                              controller: scrollController,
//                              itemCount: 5,
//                              itemBuilder: (
//                                BuildContext context,
//                                int index,
//                              ) {
//                                final Score top = tops[index];
//                                List songlist;
//                                List scorelist;
//                                int len;
//                                Firestore.instance.collection("dancing").document(id).get().then((docSnapshot){
//                                  print("length: "+ docSnapshot.data["history"].length.toString());
//                                  len = docSnapshot.data["history"].length;
//                                  for(int i = 0; i <= 5; i++){
//                                    int indx = len - i;
//                                    songlist.add(docSnapshot.data["history"][indx]["song"]);
//                                    scorelist.add(docSnapshot.data["history"][indx]["score"]);
//                                  }
//                                });
//
//                                return Container(
//                                    child: Container(
//                                  margin: EdgeInsets.only(
//                                    top: 5.0,
//                                    bottom: 5.0,
//                                  ),
//                                  padding: EdgeInsets.symmetric(
//                                      horizontal: 20.0, vertical: 10.0),
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.only(
//                                      topRight: Radius.circular(30.0),
//                                      topLeft: Radius.circular(30.0),
//                                      bottomRight: Radius.circular(30.0),
//                                      bottomLeft: Radius.circular(30.0),
//                                    ),
//                                  ),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Text(
//                                        snapshot.data[index]['song'].toString(),
//                                        style: TextStyle(
//                                          color: Colors.grey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.bold,
//                                        ),
//                                      ),
//                                      Text(
//                                        snapshot.data[index]['score'].toString(),
//                                        style: TextStyle(
//                                          color: Colors.blueGrey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ));
//                              },
//                            ),

                          });
//                            Container(
//                            child: ListView.builder(
//                              controller: scrollController,
//                              itemCount: 5,
//                              itemBuilder: (
//                                BuildContext context,
//                                int index,
//                              ) {
//                                final Score top = tops[index];
//
//                                return Container(
//                                    child: Container(
//                                  margin: EdgeInsets.only(
//                                    top: 5.0,
//                                    bottom: 5.0,
//                                  ),
//                                  padding: EdgeInsets.symmetric(
//                                      horizontal: 20.0, vertical: 10.0),
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.only(
//                                      topRight: Radius.circular(30.0),
//                                      topLeft: Radius.circular(30.0),
//                                      bottomRight: Radius.circular(30.0),
//                                      bottomLeft: Radius.circular(30.0),
//                                    ),
//                                  ),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Text(
////                                        song,
//                                      top.name,
//                                        style: TextStyle(
//                                          color: Colors.grey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.bold,
//                                        ),
//                                      ),
//                                      Text(
////                                        score,
//                                      top.score,
//                                        style: TextStyle(
//                                          color: Colors.blueGrey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ));
//                              },
//                            ),
//                          );
                        }))
              ],
            ),
          ))
        ]
    )
        )
//        Column(children: <Widget>[

//          Container(
//            height: 230.0,
//            color: Color(0xFF091F36),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    CircleAvatar(
//                      radius: 40.0,
//                      backgroundImage: AssetImage('assets/video1.jpg'),
//                    ),
//                    SizedBox(width: 50.0),
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text(
//                          "Jill",
////                          username,
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 35.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
////                        Text(
////                          'Win: 8',
////                          style: TextStyle(
////                            color: Colors.greenAccent,
////                            fontSize: 30.0,
////                            fontWeight: FontWeight.bold,
////                          ),
////                        ),
//                        SizedBox(height: 5.0),
//                        Container(
//                          child: InkWell(
//                            child: Container(
//                              width: MediaQuery.of(context).size.width * 0.3,
//                              height: MediaQuery.of(context).size.height * 0.05,
//                              decoration: BoxDecoration(
//                                  color: Color(0xFF091F36),
//                                  border: Border.all(
//                                    color: Colors.grey,
//                                    width: 2,
//                                  ),
//                                  borderRadius: BorderRadius.circular(6.0),
//                                  boxShadow: [
//                                    BoxShadow(
//                                      color: Color(0xFF6078ea),
//                                    )
//                                  ]),
//                              child: Material(
//                                color: Colors.transparent,
//                                child: InkWell(
//                                  onTap: () async {
//                                    try {
//                                      AuthService auth =
//                                          Provider.of(context).auth;
//                                      await auth.signOut();
//                                      print("Signed out");
//                                    } catch (e) {
//                                      print(e);
//                                    }
//                                  },
//                                  child: Center(
//                                    child: Text("Sign Out",
//                                        style: TextStyle(
//                                            color: Colors.grey,
//                                            fontFamily: "Poppins-Bold",
//                                            fontSize: 15,
//                                            letterSpacing: 1.0)),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//          Expanded(
//              child: Container(
//            padding: EdgeInsets.all(10.0),
//            decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(30.0),
//                  topRight: Radius.circular(30.0),
//                )),
//            child: Column(
//              children: <Widget>[
//                Text(
//                  "MY TOP DANCES",
//                  style: TextStyle(
//                    color: Colors.pinkAccent,
//                    fontSize: 25.0,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                Expanded(
//                    child: DraggableScrollableSheet(
//                        initialChildSize: 0.96,
//                        maxChildSize: 0.96,
//                        minChildSize: 0.96,
//                        builder: (BuildContext context,
//                            ScrollController scrollController) {
////                          getDocument();
//                          return Container(
//                            child: ListView.builder(
//                              controller: scrollController,
//                              itemCount: 5,
//                              itemBuilder: (
//                                BuildContext context,
//                                int index,
//                              ) {
//                                final Score top = tops[index];
//
//                                return Container(
//                                    child: Container(
//                                  margin: EdgeInsets.only(
//                                    top: 5.0,
//                                    bottom: 5.0,
//                                  ),
//                                  padding: EdgeInsets.symmetric(
//                                      horizontal: 20.0, vertical: 10.0),
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.only(
//                                      topRight: Radius.circular(30.0),
//                                      topLeft: Radius.circular(30.0),
//                                      bottomRight: Radius.circular(30.0),
//                                      bottomLeft: Radius.circular(30.0),
//                                    ),
//                                  ),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Text(
////                                        song,
//                                      top.name,
//                                        style: TextStyle(
//                                          color: Colors.grey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.bold,
//                                        ),
//                                      ),
//                                      Text(
////                                        score,
//                                      top.score,
//                                        style: TextStyle(
//                                          color: Colors.blueGrey,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ));
//                              },
//                            ),
//                          );
//                        }))
//              ],
//            ),
//          ))
//        ]
//    )
    );
  }
}
class Set {
  final int reps;
  final int weight;

  Set(this.reps, this.weight);

  Map<String, dynamic> toMap() =>
      {
        "reps": this.reps,
        "weight": this.weight
      };

  Set.fromMap(Map<dynamic, dynamic> map)
      : reps = map["reps"].toInt(),
        weight = map["weight"].toInt();
}
