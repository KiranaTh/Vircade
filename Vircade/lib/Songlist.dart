import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'match.dart';

class Songlist extends StatelessWidget {
  Future getAvatar() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('song').getDocuments();

    return qn.documents;
  }

  int index = 0;
  String video, song, singer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: <Widget>[
        // FutureBuilder(
        //     future: getAvatar(),
        //     builder: (_, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: Text("Loading..."),
        //         );
        //       } else {
        //         while (index <= snapshot.data.length) {
        //           video = 'assets/video1.jpg';
        //           song = snapshot.data[index].data["song"];
        //           singer = snapshot.data[index].data["singer"];
        //           makePage(_, image: video, song: song, singer: singer);
        //         }
        //       }
        //     })
        makePage(
          context,
          image: 'assets/video1.jpg',
          song: "Cha Cha Slide",
          singer: "Mr. C",
        ),
        makePage(
          context,
          image: 'assets/video2.jpg',
          song: "Treasure",
          singer: "Bruno Mars",
        ),
        makePage(
          context,
          image: 'assets/video3.jpg',
          song: "Like that",
          singer: "Doja Cat",
        )
      ],
    ));
  }

  Widget makePage(context, {image, song, singer}) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.7),
              Colors.black.withOpacity(.2)
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      song,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "Poppins-Bold"),
                    ),
                    Text(
                      singer,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Poppins-Bold"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
