import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'test.dart';
import 'model/ranklist.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: Column(children: <Widget>[
          Container(
            height: 230.0,
            color: Color(0xFF091F36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/video1.jpg'),
                    ),
                    SizedBox(width: 50.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'SAM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Win: 8',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          child: InkWell(
                            child: Container(
                              width: ScreenUtil().setWidth(220),
                              height: ScreenUtil().setHeight(50),
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
                                  onTap: () => Test(),
                                  child: Center(
                                    child: Text("Edit Profile",
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
          ),
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
                          return Container(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: tops.length - 5,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                final User top = tops[index];
                                return Container(
                                    child: Container(
                                  margin: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
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
                                        top.name,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        top.score,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                              },
                            ),
                          );
                        }))
              ],
            ),
            // child: DraggableScrollableSheet(
            //     initialChildSize: 0.96,
            //     maxChildSize: 0.96,
            //     minChildSize: 0.96,
            //     builder: (BuildContext context,
            //         ScrollController scrollController) {
            //       return Container(
            //         child: ListView.builder(
            //           controller: scrollController,
            //           itemCount: tops.length - 5,
            //           itemBuilder: (
            //             BuildContext context,
            //             int index,
            //           ) {
            //             final User top = tops[index];
            //             return Container(
            //                 child: Container(
            //               margin: EdgeInsets.only(
            //                 top: 5.0,
            //                 bottom: 5.0,
            //               ),
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 20.0, vertical: 10.0),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(30.0),
            //                   topLeft: Radius.circular(30.0),
            //                   bottomRight: Radius.circular(30.0),
            //                   bottomLeft: Radius.circular(30.0),
            //                 ),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                 children: <Widget>[
            //                   Text(
            //                     top.name,
            //                     style: TextStyle(
            //                       color: Colors.grey,
            //                       fontSize: 15.0,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text(
            //                     top.score,
            //                     style: TextStyle(
            //                       color: Colors.blueGrey,
            //                       fontSize: 15.0,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ));
            //           },
            //         ),
            //       );
            //     })
            //)
          ))
        ]));
  }
}

// child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(
//                                       top.name,
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       top.score,
//                                       style: TextStyle(
//                                         color: Colors.blueGrey,
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     )
//                                   ],
//                                 ),
