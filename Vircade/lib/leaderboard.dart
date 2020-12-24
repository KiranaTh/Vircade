import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model/ranklist.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
                  return StreamBuilder(
                      stream: Firestore.instance.collection('dancing').orderBy("score", descending: true).limit(3).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
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
                        }
                          return (Container(child: Column(children: <Widget>[
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.03,
                            ),
                            Text(
                              "TOP 3",
                              style: TextStyle(
                                  color: Colors.red[200],
                                  fontSize: 25.0,
                                  fontFamily: "Poppins-Bold"),
                              textAlign: TextAlign
                                  .center,
                            ),
                            Text(
                              "DANCING WITH THE STRANGER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "Poppins-Bold"),
                              textAlign: TextAlign
                                  .center,
                            ),Expanded(child: Container(
                              child: ListView(
                        children: snapshot.data.documents.map((doc){
                        return Container(
                        padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 30.0),
                        child: Column(
                        children: <Widget>[
                        Container(
                        child: Column(
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets
                            .only(
                        top: 5.0,
                        bottom: 5.0,
                        ),
                        padding: EdgeInsets
                            .symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width *
                        0.03,
                        vertical: MediaQuery
                            .of(context)
                            .size
                            .width *
                        0.03,),
                        decoration: BoxDecoration(
                        color: Colors
                            .white,
                        borderRadius: BorderRadius
                            .only(
                        topRight: Radius
                            .circular(
                        30.0),
                        topLeft: Radius
                            .circular(
                        30.0),
                        bottomRight: Radius
                            .circular(
                        30.0),
                        bottomLeft: Radius
                            .circular(
                        30.0),
                        ),
                        ),
                        child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: <
                        Widget>[
                        Row(
                        children: <
                        Widget>[
                        SizedBox(
                        width: 30.0),
                        CircleAvatar(
                        radius: 35.0,
                        backgroundImage:
                        AssetImage(
                        'assets/medal.png'),
                        ),
                        SizedBox(
                        width: 10.0),
                        Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: <
                        Widget>[
                        Text(
                        //name.name
                        doc["song"],
                        style: TextStyle(
                        color: Colors
                            .grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight
                            .bold,
                        ),
                        ),
                        SizedBox(
                        height: 5.0),
                        Container(
//                                                                    width: MediaQuery
//                                                                        .of(
//                                                                        context)
//                                                                        .size
//                                                                        .width *
//                                                                        0.25,
                        child: Text(
//                                                                         doc['key']['value']["score"],
                        doc["score"].toString(),
                        style: TextStyle(
                        color: Colors
                            .blueGrey,
                        fontSize: 15.0,
                        fontWeight: FontWeight
                            .w600,
                        ),
                        overflow:
                        TextOverflow
                            .ellipsis,
                        ),
                        ),
                        ],
                        ),
                        ],
                        ),
                        ])

                        )
                        ]))]));
                        }).toList(),)
                            ))
                          ],),));
//                          return ListView(
//                          children: snapshot.data.documents.map((doc){
//                          return Container(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 50.0, vertical: 30.0),
//                                  child: Column(
//                                      children: <Widget>[
//                                        Container(
//                                            child: Column(
//                                                children: <Widget>[
//                                                    Container(
//                                                    margin: EdgeInsets
//                                                        .only(
//                                                    top: 5.0,
//                                                      bottom: 5.0,
//                                                    ),
//                                                    padding: EdgeInsets
//                                                        .symmetric(
//                                                      horizontal: MediaQuery
//                                                          .of(context)
//                                                          .size
//                                                          .width *
//                                                          0.03,
//                                                      vertical: MediaQuery
//                                                          .of(context)
//                                                          .size
//                                                          .width *
//                                                          0.03,),
//                                                    decoration: BoxDecoration(
//                                                      color: Colors
//                                                          .white,
//                                                      borderRadius: BorderRadius
//                                                          .only(
//                                                        topRight: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        topLeft: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        bottomRight: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        bottomLeft: Radius
//                                                            .circular(
//                                                            30.0),
//                                                      ),
//                                                    ),
//                                                    child: Row(
//                                                        mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceBetween,
//                                                        children: <
//                                                            Widget>[
//                                                          Row(
//                                                            children: <
//                                                                Widget>[
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              Text("1", style: TextStyle(
//                                                                color: Colors
//                                                                    .grey,
//                                                                fontSize: 50.0,
//                                                                fontWeight: FontWeight
//                                                                    .bold,
//                                                              ),),
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              CircleAvatar(
//                                                                radius: 35.0,
//                                                                backgroundImage:
//                                                                AssetImage(
//                                                                    'assets/video1.jpg'),
//                                                              ),
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              Column(
//                                                                crossAxisAlignment:
//                                                                CrossAxisAlignment
//                                                                    .start,
//                                                                children: <
//                                                                    Widget>[
//                                                                  Text(
//                                                                    //name.name
//                                                                    doc["song"],
//                                                                    style: TextStyle(
//                                                                      color: Colors
//                                                                          .grey,
//                                                                      fontSize: 15.0,
//                                                                      fontWeight: FontWeight
//                                                                          .bold,
//                                                                    ),
//                                                                  ),
//                                                                  SizedBox(
//                                                                      height: 5.0),
//                                                                  Container(
////                                                                    width: MediaQuery
////                                                                        .of(
////                                                                        context)
////                                                                        .size
////                                                                        .width *
////                                                                        0.25,
//                                                                    child: Text(
////                                                                         doc['key']['value']["score"],
//                                                                      doc["score"].toString(),
//                                                                      style: TextStyle(
//                                                                        color: Colors
//                                                                            .blueGrey,
//                                                                        fontSize: 15.0,
//                                                                        fontWeight: FontWeight
//                                                                            .w600,
//                                                                      ),
//                                                                      overflow:
//                                                                      TextOverflow
//                                                                          .ellipsis,
//                                                                    ),
//                                                                  ),
//                                                                ],
//                                                              ),
//                                                            ],
//                                                          ),
//                                                        ])
//
//                                                )
//                          ]))]));
//                          }).toList(),);


//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 50.0, vertical: 30.0),
//                              child: Card(
//                                  color: Color(0xFF091F36),
//                                  child: Column(
//                                      children: <Widget>[
//                                        Container(
//                                            width: double.infinity,
//                                            height: MediaQuery
//                                                .of(context)
//                                                .size
//                                                .width *
//                                                1.05,
//                                            decoration: BoxDecoration(
//                                              color: Color(0xFF16AAE0),
//                                              borderRadius: BorderRadius
//                                                  .circular(20.0),
//                                              border:
//                                              Border.all(color: Colors.grey
//                                                  .withOpacity(.3),
//                                                  width: .2),
//                                            ),
//                                            child: Column(
//                                                children: <Widget>[
//                                                  SizedBox(
//                                                    height: MediaQuery
//                                                        .of(context)
//                                                        .size
//                                                        .width *
//                                                        0.03,
//                                                  ),
//                                                  Text(
//                                                    "TOP 3",
//                                                    style: TextStyle(
//                                                        color: Colors.red[200],
//                                                        fontSize: 25.0,
//                                                        fontFamily: "Poppins-Bold"),
//                                                    textAlign: TextAlign
//                                                        .center,
//                                                  ),
//                                                  Text(
//                                                    "DANCING WITH THE STRANGER",
//                                                    style: TextStyle(
//                                                        color: Colors.white,
//                                                        fontSize: 20.0,
//                                                        fontFamily: "Poppins-Bold"),
//                                                    textAlign: TextAlign
//                                                        .center,
//                                                  ),
//                                                  SizedBox(height: MediaQuery
//                                                      .of(context)
//                                                      .size
//                                                      .width *
//                                                      0.03)
//                                                    Container(
//                                                    margin: EdgeInsets
//                                                        .only(
//                                                    top: 5.0,
//                                                      bottom: 5.0,
//                                                    ),
//                                                    padding: EdgeInsets
//                                                        .symmetric(
//                                                      horizontal: MediaQuery
//                                                          .of(context)
//                                                          .size
//                                                          .width *
//                                                          0.03,
//                                                      vertical: MediaQuery
//                                                          .of(context)
//                                                          .size
//                                                          .width *
//                                                          0.03,),
//                                                    decoration: BoxDecoration(
//                                                      color: Colors
//                                                          .white,
//                                                      borderRadius: BorderRadius
//                                                          .only(
//                                                        topRight: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        topLeft: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        bottomRight: Radius
//                                                            .circular(
//                                                            30.0),
//                                                        bottomLeft: Radius
//                                                            .circular(
//                                                            30.0),
//                                                      ),
//                                                    ),
//                                                    child: Row(
//                                                        mainAxisAlignment:
//                                                        MainAxisAlignment
//                                                            .spaceBetween,
//                                                        children: <
//                                                            Widget>[
//                                                          Row(
//                                                            children: <
//                                                                Widget>[
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              Text("1", style: TextStyle(
//                                                                color: Colors
//                                                                    .grey,
//                                                                fontSize: 50.0,
//                                                                fontWeight: FontWeight
//                                                                    .bold,
//                                                              ),),
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              CircleAvatar(
//                                                                radius: 35.0,
//                                                                backgroundImage:
//                                                                AssetImage(
//                                                                    'assets/video1.jpg'),
//                                                              ),
//                                                              SizedBox(
//                                                                  width: 10.0),
//                                                              Column(
//                                                                crossAxisAlignment:
//                                                                CrossAxisAlignment
//                                                                    .start,
//                                                                children: <
//                                                                    Widget>[
//                                                                  Text(
//                                                                    //name.name
//                                                                    "Treasure",
//                                                                    style: TextStyle(
//                                                                      color: Colors
//                                                                          .grey,
//                                                                      fontSize: 15.0,
//                                                                      fontWeight: FontWeight
//                                                                          .bold,
//                                                                    ),
//                                                                  ),
//                                                                  SizedBox(
//                                                                      height: 5.0),
//                                                                  Container(
////                                                                    width: MediaQuery
////                                                                        .of(
////                                                                        context)
////                                                                        .size
////                                                                        .width *
////                                                                        0.25,
//                                                                    child: Text(
////                                                                         doc['key']['value']["score"],
//                                                                      '987',
//                                                                      style: TextStyle(
//                                                                        color: Colors
//                                                                            .blueGrey,
//                                                                        fontSize: 15.0,
//                                                                        fontWeight: FontWeight
//                                                                            .w600,
//                                                                      ),
//                                                                      overflow:
//                                                                      TextOverflow
//                                                                          .ellipsis,
//                                                                    ),
//                                                                  ),
//                                                                ],
//                                                              ),
//                                                            ],
//                                                          ),
//                                                        ])
//
//                                                )
//+++++
//                                                  Container(
//                                                      child: Container(
//                                                          margin: EdgeInsets
//                                                              .only(
//                                                            top: 5.0,
//                                                            bottom: 5.0,
//                                                          ),
//                                                          padding: EdgeInsets
//                                                              .symmetric(
//                                                            horizontal: MediaQuery
//                                                                .of(context)
//                                                                .size
//                                                                .width *
//                                                                0.03,
//                                                            vertical: MediaQuery
//                                                                .of(context)
//                                                                .size
//                                                                .width *
//                                                                0.03,),
//                                                          decoration: BoxDecoration(
//                                                            color: Colors
//                                                                .white,
//                                                            borderRadius: BorderRadius
//                                                                .only(
//                                                              topRight: Radius
//                                                                  .circular(
//                                                                  30.0),
//                                                              topLeft: Radius
//                                                                  .circular(
//                                                                  30.0),
//                                                              bottomRight: Radius
//                                                                  .circular(
//                                                                  30.0),
//                                                              bottomLeft: Radius
//                                                                  .circular(
//                                                                  30.0),
//                                                            ),
//                                                          ),
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment
//                                                                  .spaceBetween,
//                                                              children: <
//                                                                  Widget>[
//                                                                Row(
//                                                                  children: <
//                                                                      Widget>[
//                                                                    CircleAvatar(
//                                                                      radius: 35.0,
//                                                                      backgroundImage:
//                                                                      AssetImage(
//                                                                          "top.imageUrl"),
//                                                                    ),
//                                                                    SizedBox(
//                                                                        width: 10.0),
//                                                                    Column(
//                                                                      crossAxisAlignment:
//                                                                      CrossAxisAlignment
//                                                                          .start,
//                                                                      children: <
//                                                                          Widget>[
//                                                                        Text(
//                                                                          //name.name
//                                                                          "",
//                                                                          style: TextStyle(
//                                                                            color: Colors
//                                                                                .grey,
//                                                                            fontSize: 15.0,
//                                                                            fontWeight: FontWeight
//                                                                                .bold,
//                                                                          ),
//                                                                        ),
//                                                                        SizedBox(
//                                                                            height: 5.0),
//                                                                        Container(
//                                                                          width: MediaQuery
//                                                                              .of(
//                                                                              context)
//                                                                              .size
//                                                                              .width *
//                                                                              0.45,
//                                                                          child: Text(
////                                                                         snapshot.data.document[index],
//                                                                          '',
//                                                                            style: TextStyle(
//                                                                              color: Colors
//                                                                                  .blueGrey,
//                                                                              fontSize: 15.0,
//                                                                              fontWeight: FontWeight
//                                                                                  .w600,
//                                                                            ),
//                                                                            overflow:
//                                                                            TextOverflow
//                                                                                .ellipsis,
//                                                                          ),
//                                                                        ),
//                                                                      ],
//                                                                    ),
//                                                                  ],
//                                                                ),
//                                                              ]))
//
//                                                  ),
//++++++
//                                                ]))
//                                      ])));
                        });


//---
//                          }
//                        );
//                        return Container(
//                          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
//                          child: Card(
//                            color: Color(0xFF091F36),
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  width: double.infinity,
//                                  height: MediaQuery.of(context).size.width *
//                                      1.05,
//                                  decoration: BoxDecoration(
//                                    color: Color(0xFF16AAE0),
//                                    borderRadius: BorderRadius.circular(20.0),
//                                    border:
//                                    Border.all(color: Colors.grey.withOpacity(.3), width: .2),
//                                  ),
//                                  child: Column(
//                                    children: <Widget>[
//                                      SizedBox(
//                                        height: MediaQuery.of(context).size.width *
//                                            0.03,
//                                      ),
//                                      Text(
//                                        "TOP 3 OF"+
//                                        snapshot
//                                            .data[index]
//                                            .data["activity"],
//                                        style: TextStyle(
//                                            color: Colors.white,
//                                            fontSize: 25.0,
//                                            fontFamily: "Poppins-Bold"),
//                                        textAlign: TextAlign.center,
//                                      ),
//                                      SizedBox( height: MediaQuery.of(context).size.width *
//                                          0.03),
//                        ]))]
//
//                  ),
//                ));


//                        ++
//                        ++
//                          });
                  }
//                      );
//                }));


//---
//    return Scaffold(
//        backgroundColor: Color(0xFF091F36),
//        body: Column(children: <Widget>[
//          Container(
//            height: 90.0,
//            color: Color(0xFF091F36),
//            child: Center(
//                child: Text(
//              "TOP 10 RANKING",
//              style: TextStyle(
//                  color: Colors.pink[300],
//                  fontSize: 25.0,
//                  fontFamily: "Poppins-Bold"),
//              textAlign: TextAlign.center,
//            )),
//          ),
//          Expanded(
//              child: Container(
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(30.0),
//                        topRight: Radius.circular(30.0),
//                      )),
//                  child: DraggableScrollableSheet(
//                      initialChildSize: 0.96,
//                      maxChildSize: 0.96,
//                      minChildSize: 0.96,
//                      builder: (BuildContext context,
//                          ScrollController scrollController) {
//                        return Container(
//                          child: ListView.builder(
//                            controller: scrollController,
//                            itemCount: snapshot.length,
//                            itemBuilder: (
//                              BuildContext context,
//                              int index,
//                            ) {
////                              final User top = tops[index];
//                              return Container(
//                                child: Container(
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
//                                      Row(
//                                        children: <Widget>[
//                                          CircleAvatar(
//                                            radius: 35.0,
//                                            backgroundImage:
//                                                AssetImage("top.imageUrl"),
//                                          ),
//                                          SizedBox(width: 10.0),
//                                          Column(
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Text(
//                                                "top.name",
//                                                style: TextStyle(
//                                                  color: Colors.grey,
//                                                  fontSize: 15.0,
//                                                  fontWeight: FontWeight.bold,
//                                                ),
//                                              ),
//                                              SizedBox(height: 5.0),
//                                              Container(
//                                                width: MediaQuery.of(context)
//                                                        .size
//                                                        .width *
//                                                    0.45,
//                                                child: Text(
//                                                  "top.score",
//                                                  style: TextStyle(
//                                                    color: Colors.blueGrey,
//                                                    fontSize: 15.0,
//                                                    fontWeight: FontWeight.w600,
//                                                  ),
//                                                  overflow:
//                                                      TextOverflow.ellipsis,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              );
//                            },
//                          ),
//                        );
//                      })))
//        ]));
//    }
}

