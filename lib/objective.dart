import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'useful.dart';

class Objective extends StatefulWidget {
  Objective ({Key key}) : super(key: key);
  @override
  ObjectiveState createState() => ObjectiveState();
}

class ObjectiveState extends State<Objective> {
  GlobalKey scaffold = GlobalKey();
  String event = '';
  String team = '';
  String match = '';
  String initials = '';
  String sandstormStart = '';
  String sandstormPreload = '';
  String sandstormHatch= '';
  String sandstormCargo= '';
  int hatchShip = 0;
  int hatchLow = 0;
  int hatchMedium = 0;
  int hatchHigh = 0;
  int hatchDropped = 0;
  int cargoShip = 0;
  int cargoLow = 0;
  int cargoMedium = 0;
  int cargoHigh = 0;
  int cargoDropped = 0;
  String endgameClimb = '';
  String endgameHelp = '';
  String notes = '';
  Boolean eventRed = Boolean(false);
  Boolean teamRed = Boolean(false);
  Boolean matchRed = Boolean(false);
  Boolean initialsRed = Boolean(false);
  Boolean sandstormStartRed = Boolean(false);
  Boolean sandstormPreloadRed = Boolean(false);
  Boolean sandstormHatchRed = Boolean(false);
  Boolean sandstormCargoRed = Boolean(false);
  Boolean endgameClimbRed = Boolean(false);
  Boolean endgameHelpRed = Boolean(false);
  Boolean notesRed = Boolean(false);
  TextEditingController teamController = TextEditingController();
  TextEditingController matchController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController sandstormHatchController = TextEditingController();
  TextEditingController sandstormCargoController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String text = '';
  String ID = '';
  void reset() {
    setState(() {
      event = '';
      team = '';
      match = '';
      initials = '';
      sandstormStart = '';
      sandstormPreload = '';
      sandstormHatch = '';
      sandstormCargo = '';
      hatchShip = 0;
      hatchLow = 0;
      hatchMedium = 0;
      hatchHigh = 0;
      hatchDropped = 0;
      cargoShip = 0;
      cargoLow = 0;
      cargoMedium = 0;
      cargoHigh = 0;
      cargoDropped = 0;
      endgameClimb = '';
      endgameHelp = '';
      notes = '';
      teamController.clear();
      matchController.clear();
      initialsController.clear();
      sandstormHatchController.clear();
      sandstormCargoController.clear();
      notesController.clear();
      List<Boolean> bools = [eventRed, teamRed, matchRed, initialsRed, sandstormStartRed, sandstormPreloadRed, sandstormHatchRed, sandstormCargoRed, endgameClimbRed, endgameHelpRed, notesRed];
      for (Boolean i in bools) {
        i.makeFalse();
      }
    });
  }
  Future<void> resetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset match?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('All unsubmitted objective scouting information will be lost.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
                reset();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> submitDialog() async {
    return showDialog<void>(
      context: scaffold.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit match?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will not be able to change submitted scouting data.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(scaffold.currentContext).pop();
                bool flag = true;
                setState(() {
                  List<String> criteria = [event, team, match, initials, sandstormStart, sandstormPreload, sandstormHatch, sandstormCargo, endgameClimb, endgameHelp, notes];
                  List<Boolean> bools = [eventRed, teamRed, matchRed, initialsRed, sandstormStartRed, sandstormPreloadRed, sandstormHatchRed, sandstormCargoRed, endgameClimbRed, endgameHelpRed, notesRed];
                  for (int i = 0; i < 11; i++) {
                    if (criteria[i] == '') {
                      flag = false;
                      bools[i].makeTrue();
                    } else {
                      bools[i].makeFalse();
                    }
                  }
                });
                if (flag) {
                  match = match.toUpperCase();
                  bool quals = false;
                  if (((!(match[0] == 'S')) && (!(match[0] == 'F'))) && (!((match[0] == 'Q') && (match[1] == 'F')))) {
                    quals = true;
                  }
                  if ((match[0] != 'Q') && (quals == true)) {
                    match = 'Q' + match;
                  }
                  int millis = DateTime.now().millisecondsSinceEpoch;
                  String complete = '$event|$team|$match|$initials|$sandstormStart|$sandstormPreload|$sandstormHatch|$sandstormCargo|$cargoHigh|$cargoMedium|$cargoLow|$cargoShip|$cargoDropped|$hatchHigh|$hatchMedium|$hatchLow|$hatchShip|$hatchDropped|$endgameClimb|$endgameHelp|$notes|$millis|}';
                  int status = await makeRequest(ID, complete);
                  if (status == 200) {
                    Flushbar(
                        title:  'Send successful',
                        message:  'Match sent to spreadsheet',
                        duration:  Duration(seconds: 2),
                        icon: IconTheme(data: IconThemeData(color: Color(0xFF209020)), child: Icon(Icons.check_circle))
                    ).show(scaffold.currentContext);
                  } else {
                    if (status > 0) {
                      Flushbar(
                          title:  'Send unsuccessful',
                          message:  'HTTP error code $status',
                          duration:  Duration(seconds: 2),
                          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
                      ).show(scaffold.currentContext);
                    } else {
                      Flushbar(
                          title:  'Send unsuccessful',
                          message:  'No connection',
                          duration:  Duration(seconds: 2),
                          icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
                      ).show(scaffold.currentContext);
                    }
                    writeText('objectiveLogs', 'objectiveErrorLog.txt', complete);
                  }
                  writeText('objectiveLogs', 'objectiveLog.txt', complete);
                  //reset();
                } else {
                  Flushbar(
                    title:  'Submit unsuccessful',
                    message:  'Please fill out all required fields before submitting',
                    duration:  Duration(seconds: 2),
                    icon: IconTheme(data: IconThemeData(color: Color(0xFF902020)), child: Icon(Icons.error))
                  ).show(scaffold.currentContext);
                }
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(scaffold.currentContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    readText('settingsLogs', 'robot.txt').then((String txt) {
      setState(() {
        text = txt;
      });
    });
    readText('settingsLogs', 'oid.txt').then((String id) {
      setState(() {
        ID = id;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffold,
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Objective', style: TextStyle(fontSize: 22)))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(bottom: 8.0, top: 4.0), child: Center(child: Text('Scout this robot: $text', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Event', style: TextStyle(color: eventRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Team', style: TextStyle(color: teamRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Match', style: TextStyle(color: matchRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Initials', style: TextStyle(color: initialsRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: event,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    event = newValue;
                                                  });
                                                },
                                                items: <String>['', 'Training', 'BE'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: teamController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  team = newValue;
                                                });
                                              },
                                              keyboardType: TextInputType.number
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: matchController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  match = newValue;
                                                });
                                              }
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: initialsController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...'
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  initials = newValue;
                                                });
                                              }
                                          ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Sandstorm', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Start', style: TextStyle(color: sandstormStartRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Preload', style: TextStyle(color: sandstormPreloadRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 3, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Hatch', style: TextStyle(color: sandstormHatchRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 2, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Cargo', style: TextStyle(color: sandstormCargoRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 2, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: sandstormStart,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  sandstormStart = newValue;
                                                });
                                              },
                                              items: <String>['', 'None', 'L1', 'L2'].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            )
                                        ),
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: sandstormPreload,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  sandstormPreload = newValue;
                                                });
                                              },
                                              items: <String>['', 'None', 'Hatch', 'Cargo'].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            )
                                        ),
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: sandstormHatchController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '...'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                sandstormHatch = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.number
                                        ),
                                      ),
                                      flex: 2,
                                      fit: FlexFit.tight
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: sandstormCargoController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '...'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                sandstormCargo = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.number
                                        ),
                                      ),
                                      flex: 2,
                                      fit: FlexFit.tight
                                  ),
                                ]
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Hatch', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Cargo')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Low')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Medium')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('High')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Dropped')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Ship')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('on Field')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchShip++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchLow++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchMedium++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchHigh++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchDropped++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Center(child: Text('$hatchShip')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchLow')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchMedium')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchHigh')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$hatchDropped')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchShip = max(0, hatchShip - 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchLow= max(0, hatchLow- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchMedium= max(0, hatchMedium- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchHigh= max(0, hatchHigh- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                hatchDropped = max(0, hatchDropped- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFF600), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Cargo', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Cargo')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Low')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Medium')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('High')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Dropped')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Ship')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Rocket')), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('on Field')), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoShip++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoLow++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoMedium++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoHigh++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoDropped++;
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_less))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Center(child: Text('$cargoShip')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoLow')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoMedium')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoHigh')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Center(child: Text('$cargoDropped')),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoShip = max(0, cargoShip - 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoLow= max(0, cargoLow- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoMedium= max(0, cargoMedium- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoHigh= max(0, cargoHigh- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cargoDropped = max(0, cargoDropped- 1);
                                              });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: IconTheme(data: IconThemeData(color: Color(0xFFFFAA55), size: 60.0), child: Icon(Icons.expand_more))
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Endgame', style: TextStyle(fontSize: 18)))),
                          Row(
                              children: <Widget>[
                                Flexible(child: Center(child: Text('Climb', style: TextStyle(color: endgameClimbRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight),
                                Flexible(child: Center(child: Text('Help', style: TextStyle(color: endgameHelpRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF)))), flex: 1, fit: FlexFit.tight)
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: endgameClimb,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    endgameClimb = newValue;
                                                  });
                                                },
                                                items: <String>['', 'None', 'L1', 'L2', 'L3'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: endgameHelp,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    endgameHelp = newValue;
                                                  });
                                                },
                                                items: <String>['', 'None', 'Received', 'L2', 'L3', 'L2/L2', 'L2/L3', 'L3/L3'].map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    ),
                                  ]
                              )
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8.0), child: Center(child: Text('Notes', style: TextStyle(fontSize: 18, color: notesRed.getBool() ? Color(0xFF902020) : Color(0xFFFFFFFF))))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: TextField(
                                            controller: notesController,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Note malfunctions, fouls, driving, intake, speed, etc.'
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                notes = newValue;
                                              });
                                            },
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                          ),
                                        ),
                                        flex: 3,
                                        fit: FlexFit.tight
                                    )
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                            child: RaisedButton(
                                                child: Text('Reset'),
                                                color: Color(0xFF97D700),
                                                textColor: Color(0xFF51284F),
                                                onPressed: resetDialog
                                            )
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    ),
                                    Flexible(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 4.0, right: 8.0),
                                            child: RaisedButton(
                                                child: Text('Submit'),
                                                color: Color(0xFF97D700),
                                                textColor: Color(0xFF51284F),
                                                onPressed: submitDialog
                                            ),
                                        ),
                                        flex: 1,
                                        fit: FlexFit.tight
                                    )
                                  ]
                              )
                          ),
                        ]
                    )
                )
            )
          ],
        )
    );
  }
}