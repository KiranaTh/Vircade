import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'activities.dart';
import 'leaderboard.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  final _pageOptions = [
    Activities(),
    LeaderBoard(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          width: ScreenUtil().setWidth(110),
          height: ScreenUtil().setHeight(110),
        ),
        backgroundColor: Color(0xFF091F36),
      ),
      backgroundColor: Color(0xFF091F36),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink[300],
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('ACTIVITIES',
                  style: TextStyle(fontFamily: "Poppins-Bold"))),
          BottomNavigationBarItem(
              icon: Icon(Icons.stars),
              title: Text('LEADERBOARD',
                  style: TextStyle(fontFamily: "Poppins-Bold"))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title:
                  Text('PROFILE', style: TextStyle(fontFamily: "Poppins-Bold")))
        ],
      ),
    );
  }
}
