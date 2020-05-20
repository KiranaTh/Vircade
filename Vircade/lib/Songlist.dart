import 'package:flutter/material.dart';
import 'match.dart';

class Songlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: <Widget>[
        makePage(
          context,
          image: 'assets/video1.jpg',
          song: "Cha Cha Slide",
          singer: "Mr. C",
          rating: "MEDIUM",
        ),
        makePage(
          context,
          image: 'assets/video2.jpg',
          song: "Treasure",
          singer: "Bruno Mars",
          rating: "EASY",
        ),
        makePage(
          context,
          image: 'assets/video3.jpg',
          song: "Like that",
          singer: "Doja Cat",
          rating: "Hard",
        )
      ],
    ));
  }

  Widget makePage(context, {image, song, singer, rating}) {
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
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child:
                              Icon(Icons.star, color: Colors.green, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child:
                              Icon(Icons.star, color: Colors.green, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child:
                              Icon(Icons.star, color: Colors.green, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(Icons.star, color: Colors.grey, size: 20),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(Icons.star, color: Colors.grey, size: 20),
                        ),
                        Text(
                          rating,
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: "Poppins-Regular"),
                        ),
                      ],
                    ),
                    // if(rating == "EASY"){
                    //   easy(),
                    // }else if(rating == "MEDIUM"){
                    //   med(),
                    // }else if(rating == "HARD"){
                    //   med(),
                    // },
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

  Widget easy() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.yellow, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Text(
          "EASY",
          style: TextStyle(color: Colors.yellow, fontFamily: "Poppins-Regular"),
        ),
      ],
    );
  }

  Widget med() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.green, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.green, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.green, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.grey, size: 20),
        ),
        Text(
          "MEDIUM",
          style: TextStyle(color: Colors.green, fontFamily: "Poppins-Regular"),
        ),
      ],
    );
  }

  Widget hare() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.red, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.red, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.red, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.red, size: 20),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star, color: Colors.red, size: 20),
        ),
        Text(
          "HARD",
          style: TextStyle(color: Colors.yellow, fontFamily: "Poppins-Regular"),
        ),
      ],
    );
  }
}
