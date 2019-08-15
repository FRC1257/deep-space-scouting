import 'package:flutter/material.dart';

import 'instructions.dart';
import 'objective.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> children = [
    Instructions(),
    Objective(),
    Instructions(),
    Instructions(),
    Settings()
  ];
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team 1257 Scouting App: 2019')
      ),
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: IconTheme(
              data: IconThemeData(color: Color(0xFF97D700)),
              child: Icon(Icons.playlist_add_check),
            ),
              title: Text(
                'Instructions',
                style: TextStyle(color: Color(0xFF97D700)),
              )
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
              data: IconThemeData(color: Color(0xFF97D700)),
              child: Icon(Icons.web),
            ),
              title: Text(
                'Objective',
                style: TextStyle(color: Color(0xFF97D700)),
              )
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
              data: IconThemeData(color: Color(0xFF97D700)),
              child: Icon(Icons.dashboard),
            ),
              title: Text(
                'Pit',
                style: TextStyle(color: Color(0xFF97D700)),
              )
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
              data: IconThemeData(color: Color(0xFF97D700)),
              child: Icon(Icons.send),
            ),
              title: Text(
                'Send',
                style: TextStyle(color: Color(0xFF97D700)),
              )
          ),
          BottomNavigationBarItem(
            icon: IconTheme(
              data: IconThemeData(color: Color(0xFF97D700)),
              child: Icon(Icons.settings),
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Color(0xFF97D700)),
            )
          )
        ],
      ),
    );
  }
}