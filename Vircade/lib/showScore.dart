import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowScore extends StatefulWidget {
  final int score;
  final String gameID;
  final String status;
  ShowScore({Key key, @required this.score, @required this.gameID, @required this.status}) : super(key: key);
  @override
  _ShowScoreState createState() => _ShowScoreState();
}

class _ShowScoreState extends State<ShowScore> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int highScore;
  String scoreStatus;
  @override
  void initState() {
    databaseReference.child("games").child(widget.gameID).once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values=snapshot.value;
      print(values["highScore"]);
      highScore = values["highScore"];
      if(widget.score <  highScore){
        scoreStatus = "LOSE";
      }else{
        scoreStatus = "WIN";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String scoreData = widget.score.toString();
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: new Center(child: singleM(scoreData,scoreStatus)));
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                child: Image.asset("assets/trophy.gif"),
//                width: MediaQuery.of(context).size.width * 0.6,
//                height: MediaQuery.of(context).size.height * 0.4,
//              ),
//              Text(
//                'SCORE',
//                style: TextStyle(
//                    color: Colors.white,
//                    height: 1.0,
//                    fontSize: 30,
//                    fontFamily: "Poppins-Bold"),
//              ),
//              Text(
//                scoreData,
//                style: TextStyle(
//                    color: Colors.yellow,
//                    height: 1.0,
//                    fontSize: 60,
//                    fontFamily: "Poppins-Bold"),
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        'BEST',
//                        style: TextStyle(
//                            color: Colors.white,
//                            height: 1.0,
//                            fontSize: 18,
//                            fontFamily: "Poppins-Bold"),
//                      ),
//                      Text(
//                        'SCORE',
//                        style: TextStyle(
//                            color: Colors.white,
//                            height: 1.0,
//                            fontSize: 18,
//                            fontFamily: "Poppins-Bold"),
//                      ),
//                    ],
//                  ),
//                  SizedBox(width: 15.0),
//                  Text(
//                    '76543',
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 40,
//                        fontFamily: "Poppins-Bold"),
//                  ),
//                ],
//              ),
//              SizedBox(height: 15.0),
//              InkWell(
//                  child: Container(
//                      width: MediaQuery.of(context).size.width * 0.7,
//                      height: MediaQuery.of(context).size.height * 0.07,
//                      decoration: BoxDecoration(
//                        color: Colors.blueAccent,
//                        border: Border.all(
//                          color: Colors.blueAccent,
//                          width: 2,
//                        ),
//                        borderRadius: BorderRadius.circular(30.0),
//                      ),
//                      child: Material(
//                        color: Colors.transparent,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.of(context)
//                                .pushReplacementNamed('/home1');
//                          },
//                          child: Center(
//                            child: Text("Play again",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontFamily: "Poppins-Bold",
//                                    fontSize: 18,
//                                    letterSpacing: 1.0)),
//                          ),
//                        ),
//                      ))),
//              SizedBox(height: 10.0),
//              InkWell(
//                  child: Container(
//                      width: MediaQuery.of(context).size.width * 0.7,
//                      height: MediaQuery.of(context).size.height * 0.07,
//                      decoration: BoxDecoration(
//                        color: Colors.redAccent,
//                        border: Border.all(
//                          color: Colors.redAccent,
//                          width: 2,
//                        ),
//                        borderRadius: BorderRadius.circular(30.0),
//                      ),
//                      child: Material(
//                        color: Colors.transparent,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.of(context)
//                                .pushReplacementNamed('/home1');
//                          },
//                          child: Center(
//                            child: Text("Select new song",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontFamily: "Poppins-Bold",
//                                    fontSize: 18,
//                                    letterSpacing: 1.0)),
//                          ),
//                        ),
//                      ))),
//              SizedBox(height: 10.0),
//              InkWell(
//                  child: Container(
//                      width: MediaQuery.of(context).size.width * 0.7,
//                      height: MediaQuery.of(context).size.height * 0.07,
//                      decoration: BoxDecoration(
//                        color: Color(0xFF091F36),
//                        border: Border.all(
//                          color: Colors.white,
//                          width: 2,
//                        ),
//                        borderRadius: BorderRadius.circular(30.0),
//                      ),
//                      child: Material(
//                        color: Colors.transparent,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.of(context)
//                                .pushReplacementNamed('/home1');
//                          },
//                          child: Center(
//                            child: Text("Back to Home",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontFamily: "Poppins-Bold",
//                                    fontSize: 18,
//                                    letterSpacing: 1.0)),
//                          ),
//                        ),
//                      ))),
//              SizedBox(height: 20.0),
//            ],
//          ),
//        ));
  }
  Widget singleM(String scoreData, String scoreStatus){
    if(widget.status == 'singleMode'){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/trophy.gif"),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Text(
            'SCORE',
            style: TextStyle(
                color: Colors.white,
                height: 1.0,
                fontSize: 30,
                fontFamily: "Poppins-Bold"),
          ),
          Text(
            scoreData,
            style: TextStyle(
                color: Colors.yellow,
                height: 1.0,
                fontSize: 60,
                fontFamily: "Poppins-Bold"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'BEST',
                    style: TextStyle(
                        color: Colors.white,
                        height: 1.0,
                        fontSize: 18,
                        fontFamily: "Poppins-Bold"),
                  ),
                  Text(
                    'SCORE',
                    style: TextStyle(
                        color: Colors.white,
                        height: 1.0,
                        fontSize: 18,
                        fontFamily: "Poppins-Bold"),
                  ),
                ],
              ),
              SizedBox(width: 15.0),
              Text(
                '76543',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Poppins-Bold"),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Play again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 10.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Select new song",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 10.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFF091F36),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Back to Home",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 20.0),
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/trophy.gif"),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Text(
            'YOU',
            style: TextStyle(
                color: Colors.white,
                height: 1.0,
                fontSize: 30,
                fontFamily: "Poppins-Bold"),
          ),
          Text(
            scoreStatus,
            style: TextStyle(
                color: Colors.yellow,
                height: 1.0,
                fontSize: 60,
                fontFamily: "Poppins-Bold"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'SCORE',
                    style: TextStyle(
                        color: Colors.white,
                        height: 1.0,
                        fontSize: 18,
                        fontFamily: "Poppins-Bold"),
                  ),
                ],
              ),
              SizedBox(width: 15.0),
              Text(
                scoreData,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Poppins-Bold"),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Play again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 10.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Select new song",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 10.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFF091F36),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/home1');
                      },
                      child: Center(
                        child: Text("Back to Home",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 20.0),
        ],
      );
    }
  }
}

