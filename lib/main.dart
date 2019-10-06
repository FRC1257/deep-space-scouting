import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';
import 'useful.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(ScoutApp());
}

class ScoutApp extends StatefulWidget {
  ScoutApp({Key key}) : super(key: key);
  @override
  ScoutAppState createState() => ScoutAppState();
}

class ScoutAppState extends State<ScoutApp> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Space Scouting', // year-specific
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF51284F),
          accentColor: Color(0xFF97D700),
          fontFamily: 'Noto Sans'
      ),
      home: Home(),
    );
  }
}