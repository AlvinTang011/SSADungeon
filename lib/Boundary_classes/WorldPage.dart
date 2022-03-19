import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/StagePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'WorldQuizQuestion.dart';

class WorldPage extends StatefulWidget {
  String characterSelected;

  WorldPage({this.characterSelected});

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  var lock = [false, true, true, true, true, true];
  String userId = FirebaseAuth.instance.currentUser.uid;
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> worldsNames = [];
  List<String> worldsFNames = [];
  List<String> worldScores = [];
  List<int> worldScoresInt = [];
  List<String> stagesNumbers = [];
  List<String> stagesScores = [];
  List<bool> accessForWorlds = [];
  int counter = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  bool _showSpinner;

  init() async {
    /// get the worldsnames
    setState(() {
      _showSpinner = true;
    });

    worldsNames = await configManager.getWorldName();

    /// get worlds full name
    worldsFNames = await configManager.getWorldFName(worldsNames);

    /// get the list of world scores
    worldScores = await configManager.getWorldsScores(worldsNames);

    /// get the list of world scores int
    worldScoresInt = await configManager.getWorldsScoresInt(worldsNames);

    for (int i = 0; i < worldsNames.length; i++) {
      bool worldAccess =
          await configManager.checkAccessForWorlds(worldsNames[i]);
      accessForWorlds.add(worldAccess);
    }
    accessForWorlds[0] = true;

    for (int i = 0; i < accessForWorlds.length; i++) {
      if (accessForWorlds[i]) counter++;
    }

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/HomePage');
          },
        ),
        centerTitle: true,
        title: Text(
          "Select World",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: Column(
        children: [
          _showSpinner
              ? Expanded(
                  child: Center(
                    child: spinkit,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 15, top: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                content: Text("Attempt World Quiz $counter?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Confirm"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WorldQuizQuestion(
                                            worldNumber: counter,
                                            characterSelected:
                                                widget.characterSelected,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            color: Colors.orange[100],
                          ),
                          child: Text("World Quiz",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Orbitron')),
                        ),
                      ),
                    ),
                  ),
                ),
          new Expanded(
            child: new ListView.builder(
              itemCount: worldsNames.length,
              itemBuilder: (BuildContext context, int index) {
                if (index % 2 == 0) {
                  int dsIndex = index;
                  int ds2Index = index + 1;
                  return new Padding(
                    /// World 1,3,5
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: (!accessForWorlds[dsIndex])
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black),
                                    color: Colors.grey[600],
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(worldsFNames[dsIndex],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Orbitron',
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.lock, size: 45),
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StagePage(
                                          title: worldsFNames[dsIndex],
                                          worldName: worldsNames[dsIndex],
                                          characterSelected:
                                              widget.characterSelected,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.blueGrey[200],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                worldsFNames[dsIndex] + '\n',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Orbitron',
                                                  fontWeight: FontWeight.w800,
                                                )),
                                          ),
                                        ),
                                        Text(
                                            worldScores[dsIndex] == null
                                                ? "0"
                                                : worldScores[dsIndex],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Orbitron',
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: (!accessForWorlds[ds2Index])
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black),
                                    color: Colors.grey[600],
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(worldsFNames[ds2Index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Orbitron',
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.lock, size: 45),
                                      )
                                    ],
                                  ))
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StagePage(
                                              title: worldsFNames[ds2Index],
                                              worldName: worldsNames[ds2Index],
                                              characterSelected:
                                              widget.characterSelected,
                                                )));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.blueGrey[200],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Text(
                                              worldsFNames[ds2Index] + '\n',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Orbitron',
                                                fontWeight: FontWeight.w800,
                                              )),
                                        ),
                                        Text(
                                            worldScores[ds2Index] == null
                                                ? "0"
                                                : worldScores[ds2Index],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Orbitron',
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
