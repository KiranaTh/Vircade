import 'package:flutter/material.dart';
import 'package:Vircade/model/avartarlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Vircade/widgets/provider_widget.dart';
import 'package:Vircade/model/user.dart';
// import 'package:Vircade/services/auth_service.dart';

class Avatar extends StatefulWidget {
  // final User user;
  const Avatar({
    Key key,
    // @required this.user
  }) : super(key: key);
  @override
  AvatarState createState() => AvatarState();
}

class AvatarState extends State<Avatar> {
  int _index = 0;
  User user;
  AvatarState();
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/logo.png",
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          backgroundColor: Color(0xFF091F36),
        ),
        backgroundColor: Color(0xFF091F36),
        body: SizedBox(
          height: 500, // card height
          child: PageView.builder(
            itemCount: avatars.length,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              final AvatarList avatar = avatars[i];
              return Transform.scale(
                  scale: i == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(avatar.imageUrl))),
                          ),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  color: Color(0xFF091F36),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    final uid = await Provider.of(context)
                                        .auth
                                        .getCurrentUID();

                                    final username = await Provider.of(context)
                                        .auth
                                        .getCurrentuserName();

                                    user.name = username;
                                    user.avartarId = _index;
                                    print("avatarpg username: $uid");
                                    print("avatarpg username: $username");
                                    print("avatar pic id: $_index");

                                    await db
                                        .collection("userData")
                                        .document(uid)
                                        .collection("userInfo")
                                        .add(user.toJson());

                                    Navigator.of(context)
                                        .pushReplacementNamed('/Home');
                                  },
                                  child: Center(
                                    child: Text("Select this avatar",
                                        textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ));
  }
}

// InkWell(
//   child: Container(
//     width: MediaQuery.of(context).size.width * 1,
//     height: MediaQuery.of(context).size.width * 1,
//     decoration: BoxDecoration(
//         color: Color(0xFF091F36),
//         border: Border.all(
//           color: Colors.white,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(6.0),
//         boxShadow: [
//           BoxShadow(
//               color: Color(0xFF6078ea).withOpacity(.3),
//               offset: Offset(0.0, 8.0),
//               blurRadius: 8.0)
//         ]),
//     child: Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () =>
//             Navigator.of(context).pushReplacementNamed('/Home'),
//         child: Center(
//           child: Text("Select this avatar",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: "Poppins-Bold",
//                   fontSize: 18,
//                   letterSpacing: 1.0)),
//         ),
//       ),
//     ),
//   ),
// ),
