import 'package:Vircade/services/auth_service.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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


  Future getData() async {
    uid = await Provider.of(context).auth.getCurrentUID();
    username = await Provider.of(context).auth.getCurrentuserName();
    imageUrl = await Provider.of(context).auth.getCurrentAvatar();
    List d = [uid, username, imageUrl];
    return d;
  }

  @override
  void initState() {
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
                              return  Scaffold(
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
                          });
                        }))
              ],
            ),
          ))
        ]
    )
        )
    );
  }
}
