import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'useful.dart';

class Pit extends StatefulWidget {
  Pit ({Key key}) : super(key: key);
  @override
  PitState createState() => PitState();
}

class PitState extends State<Pit> {
  GlobalKey scaffold = GlobalKey();
  String event = '';
  String team = '';
  String role = '';
  String initials = '';
  String sandstorm = '';
  bool hatches = false;
  String speed = '';
  String weight = '';
  bool vision = false;
  String drivetrain = '';
  String hatchMech = '';
  String cargoMech = '';
  String climbMech = '';
  String helpMech = '';
  String experience = '';
  String notes = '';
  Boolean eventRed = Boolean(false);
  Boolean teamRed = Boolean(false);
  Boolean roleRed = Boolean(false);
  Boolean initialsRed = Boolean(false);
  Boolean sandstormRed = Boolean(false);
  Boolean speedRed = Boolean(false);
  Boolean weightRed = Boolean(false);
  Boolean drivetrainRed = Boolean(false);
  Boolean hatchMechRed = Boolean(false);
  Boolean cargoMechRed = Boolean(false);
  Boolean climbMechRed = Boolean(false);
  Boolean helpMechRed = Boolean(false);
  Boolean experienceRed = Boolean(false);
  Boolean notesRed = Boolean(false);
  TextEditingController teamController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController initialsController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController drivetrainController = TextEditingController();
  TextEditingController hatchMechController = TextEditingController();
  TextEditingController cargoMechController = TextEditingController();
  TextEditingController climbMechController = TextEditingController();
  TextEditingController helpMechController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String ID = '';
  void reset() {
    setState(() {
      event = '';
      team = '';
      role = '';
      initials = '';
      sandstorm = '';
      speed = '';
      weight = '';
      drivetrain = '';
      hatchMech = '';
      cargoMech = '';
      climbMech = '';
      helpMech = '';
      experience = '';
      notes = '';
      teamController.clear();
      roleController.clear();
      initialsController.clear();
      initialsController.clear();
      speedController.clear();
      weightController.clear();
      drivetrainController.clear();
      hatchMechController.clear();
      cargoMechController.clear();
      climbMechController.clear();
      helpMechController.clear();
      experienceController.clear();
      notesController.clear();
      eventRed.makeFalse();
      teamRed.makeFalse();
      roleRed.makeFalse();
      initialsRed.makeFalse();
      sandstormRed.makeFalse();
      speedRed.makeFalse();
      weightRed.makeFalse();
      drivetrainRed.makeFalse();
      hatchMechRed.makeFalse();
      cargoMechRed.makeFalse();
      climbMechRed.makeFalse();
      helpMechRed.makeFalse();
      experienceRed.makeFalse();
      notesRed.makeFalse();
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
                  List<String> criteria = [event, team, role, initials, sandstorm, speed, weight, drivetrain, hatchMech, cargoMech, climbMech, helpMech, experience, notes];
                  List<Boolean> bools = [eventRed, teamRed, roleRed, initialsRed, sandstormRed, speedRed, weightRed, drivetrainRed, hatchMechRed, cargoMechRed, climbMechRed, helpMechRed, experienceRed, notesRed];
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
                  int millis = DateTime.now().millisecondsSinceEpoch;
                  String complete = '$event|$team|$role|$initials|$sandstorm|$hatches|$speed|$weight|$vision|$drivetrain|$hatchMech|$cargoMech|$climbMech|$helpMech|$experience|$notes|$millis|}';
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
                  reset();
                  // This is the response for if the data is not complete.
                  // Leave it unchanged.
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
            // This is just the "no" option.
            // Leave it unchanged.
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
    readText('settingsLogs', 'pid.txt').then((String id) {
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
            Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 12.0), child: Center(child: Text('Pit', style: TextStyle(fontSize: 22)))),
          ]
        )
    );
  }
}