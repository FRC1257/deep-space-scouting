import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  Instructions({Key key}) : super(key: key);
  @override
  InstructionsState createState() => InstructionsState();
}

class InstructionsState extends State<Instructions> {
  static List<String> instructions = ['Instructions 1', 'Instructions 2', 'Instructions 3']; // year-specific
  String text = instructions[0];
  int a = 0;
  void nextPage() {
    setState(() {
      text = instructions[(a + 1) % instructions.length];
      a++;
    });
  }
  void prevPage() {
    setState(() {
      text = instructions[(a - 1) % instructions.length];
      a = (a - 1) % instructions.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Instructions', style: TextStyle(fontSize: 22)))),
          Expanded(child: Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Center(child: Text(text)))),
          Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                          onPressed: prevPage,
                          tooltip: 'Previous Page',
                          child: IconTheme(data: IconThemeData(color: Color(0xFF51284F)), child: Icon(Icons.arrow_back_ios))
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
              ),
              Expanded(
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                          onPressed: nextPage,
                          tooltip: 'Next Page',
                          child: IconTheme(data: IconThemeData(color: Color(0xFF51284F)), child: Icon(Icons.arrow_forward_ios))
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
              ),

            ],
          )

        ],
      ),
    );
  }
}