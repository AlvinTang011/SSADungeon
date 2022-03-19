import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ssadgame/Boundary_classes/PastAttemptsPage.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:ssadgame/Controller/customLevelsController.dart';
import 'package:ssadgame/game_engine/main.dart' as GameEngineMain;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class teacherAssignmentPage extends StatefulWidget {

  @override
  _teacherAssignmentPageState createState() => _teacherAssignmentPageState();
}

//SELECT LEVEL PAGE
class _teacherAssignmentPageState extends State<teacherAssignmentPage> {
  String userId = FirebaseAuth.instance.currentUser.uid;
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  customLevelsController cLController = customLevelsController.getInstance();
  List<String> teacherAssignedLevels = [];
  List<String> levelsScores = [];
  int totalAssignedLevels;

  @override
  void initState() {
    super.initState();
    init();
  }

  bool _showSpinner;

  init() async {
    setState(() {
      _showSpinner = true;
    });
    teacherAssignedLevels = await cLController.checkTeacherAssignment();
    totalAssignedLevels = teacherAssignedLevels.length;
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
      color: Colors.black,
      size: 50.0,
    );
    return Scaffold(
      /// AppBar
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Select Level",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      //The Topic Name/Heading
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 2.0,
                    child: Text(
                      'Teacher Assigned Levels', //Hardcoded, need to change
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 17,
                        decorationColor: Colors.black,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.black),
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          _showSpinner
              ? spinkit
              : new Expanded(
            child: new ListView.builder(
              itemCount: totalAssignedLevels,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  height: 80,
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: RaisedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => GameEngineMain.GameEngine(
                      //       title: widget.title,
                      //       stageNumber: widget.stageNumber,
                      //       levelNumber: index + 1,
                      //       characterSelected: widget.characterSelected,
                      //     ),
                      //   ),
                      // );
                    }, //Need to link to the next page
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              teacherAssignedLevels[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                fontFamily: 'Orbitron',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueGrey[200],
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
            ),
          ),
          //The buttons
        ],
      ),
    );
  }
}
