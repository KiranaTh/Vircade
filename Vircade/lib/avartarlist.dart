import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'package:Vircade/model/user.dart';

class AvatarList extends StatefulWidget {
  @override
  AvatarListState createState() => AvatarListState();
}

class AvatarListState extends State<AvatarList> {
  int _index = 0;
  final db = Firestore.instance;

  Future getAvatar() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore
        .collection('avatar')
        .orderBy("avatarId", descending: false)
        .getDocuments();

    return qn.documents;
  }

  int page;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Image.asset(
            "assets/logo.png",
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          backgroundColor: Color(0xFF091F36),
        ),
        backgroundColor: Color(0xFF091F36),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: getAvatar(),
                builder: (_, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(
                  //     child: Text("Loading..."),
                  //   );
                  // } else {
                  //   // return ListView.builder(
                  //   //     itemCount: snapshot.data.length,
                  //   //     itemBuilder: (_, index) {
                  //   //       return Column(
                  //   //         children: <Widget>[
                  //   //           Text(snapshot.data[index].data["imageUrl"])
                  //   //         ],
                  //   //       );
                  //   //     });
                  page = snapshot.data.length;
                  return SizedBox(
                    height: 500, // card height
                    child: PageView.builder(
                      itemCount: page,
                      controller: PageController(viewportFraction: 0.7),
                      onPageChanged: (int index) =>
                          setState(() => _index = index),
                      itemBuilder: (_, i) {
                        return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: Card(
                              elevation: page.toDouble(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data[i].data["imageUrl"]))),
                                    ),
                                    InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF091F36),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
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
                                            onTap: () async {
                                              // final uid = await Provider.of(context)
                                              //     .auth
                                              //     .getCurrentUID();

                                              // final username =
                                              //     await Provider.of(context)
                                              //         .auth
                                              //         .getCurrentuserName();

                                              // user.name = username;
                                              // user.avartarId = _index;
                                              // print("avatarpg username: $uid");
                                              // print("avatarpg username: $username");
                                              // print("avatar pic id: $_index");

                                              // await db
                                              //     .collection("userData")
                                              //     .document(uid)
                                              //     .collection("userInfo")
                                              //     .add(user.toJson());

                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/home1');
                                            },
                                            child: Center(
                                              child: Text("Select this avatar",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "Poppins-Bold",
                                                      fontSize: 18,
                                                      letterSpacing: 1.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                }),
          ],
        )));
  }
}
