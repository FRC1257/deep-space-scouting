import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(ScoutApp());
}

class ScoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team 1257 Scouting App: 2019', // year-specific
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