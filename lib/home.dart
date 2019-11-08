import 'package:flutter/material.dart';

import 'instructions.dart';
import 'objective.dart';
import 'pit.dart';
import 'send.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String team = '';
  int currentIndex = 0;
  void initState() {
    super.initState();
  }
  final List<Widget> children = [
    Instructions(),
    Objective(),
    Pit(),
    Send(),
    Settings()
  ];
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/1257background.png'),
                fit: BoxFit.cover),
          ),
        ),
        Opacity(
          child: Scaffold(
            body: Opacity(child: children[currentIndex], opacity: .5),
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
          ),
          opacity: .85
        ),
      ],
    );
  }
}