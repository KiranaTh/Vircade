import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowScore extends StatefulWidget {
  final double score;
  final String uid;
  final String gameID;
  final String status;
  ShowScore({Key key, @required this.uid, @required this.score, @required this.gameID, @required this.status}) : super(key: key);
  @override
  _ShowScoreState createState() => _ShowScoreState();
}

class _ShowScoreState extends State<ShowScore> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double highScore;
  String scoreStatus;
  String scoreData;
  @override
  void initState() {
    databaseReference.child("games").child(widget.gameID).once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values=snapshot.value;
      print("highScore: "+ values["highScore"].toString());
      print("widgetScore: "+ widget.score.toString());
      setState(() {
        scoreData = widget.score.toString();
        highScore = double.parse(values["highScore"].toString());
        if(double.parse(widget.score.toString()) <  highScore){
          scoreStatus = "LOSE";
        }else if(double.parse(widget.score.toString()) ==  highScore){
          scoreStatus = "WIN";
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("scoreData: "+ scoreData);
    print("scorestatus"+ scoreStatus);
    return Scaffold(
        backgroundColor: Color(0xFF091F36),
        body: new Center(child: singleM(double.parse(scoreData).toString() ,scoreStatus.toString())));
  }
  Widget singleM(String scoreData, String scoreStatus){
    if(widget.status == 'singleMode'){
      print("singleMode");
      String word1, word2;
      if(double.parse(scoreData) <= 30){
        word1 = "SEEM NEED TO";
        word2 = "PRACTICE MORE";
      }else if(double.parse(scoreData) > 30 && double.parse(scoreData) <= 60){
        word1 = "NICE TRY!!";
        word2 = "GOOD JOB!!!!";
      }else {
        word1 = "BEST DANCER";
        word2 = "!!!!IS HERE!!!!";
      }
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
            double.parse(scoreData).toString(),
            style: TextStyle(
                color: Colors.yellow,
                height: 1.0,
                fontSize: 100,
                fontFamily: "Poppins-Bold"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 15.0),
              Text(
                word1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Poppins-Bold"),
              ),
              Text(
                word2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Poppins-Bold"),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFF091F36),
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
                        child: Text("Back to Home",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ))),
          SizedBox(height: 20.0),
        ],
      );
    }else if(widget.status == 'battleMode'){
      print("battleMode");
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
                color: scoreStatus == "WIN"?Colors.greenAccent : Colors.redAccent,
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
                double.parse(scoreData).toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Poppins-Bold"),
              ),
            ],
          ),
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

