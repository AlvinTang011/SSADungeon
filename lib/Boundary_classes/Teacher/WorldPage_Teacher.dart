import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'StagePage_Teacher.dart';

class WorldPage_Teacher extends StatefulWidget {
  @override
  _WorldPage_TeacherState createState() => _WorldPage_TeacherState();
}

class _WorldPage_TeacherState extends State<WorldPage_Teacher> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> worldsNames = [];
  List<String> worldsFNames = [];

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
        backgroundColor: Colors.orange[100],
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/Teacher/HomePage_Teacher');
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
          Padding(padding: EdgeInsets.only(top: 45)),
          _showSpinner
              ? Expanded(
                  child: Center(
                    child: spinkit,
                  ),
                )
              : new Expanded(
                  child: new ListView.builder(
                      itemCount: worldsNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index % 2 == 0) {
                          int dsIndex = index;
                          int ds2Index = index + 1;
                          return new Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.center,

                                  /// Left side stages 1,3,5
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StagePage_Teacher(
                                                    title:
                                                        worldsFNames[dsIndex],
                                                    worldName:
                                                        worldsNames[dsIndex],
                                                    worldNum: int.parse(
                                                        '${worldsFNames[dsIndex][6]}'),
                                                  )));
                                    },
                                    child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[200],
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(worldsFNames[dsIndex],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Orbitron',
                                                  fontWeight: FontWeight.w800,
                                                )),
                                          ],
                                        )),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,

                                  /// Right side stages 2,4,6
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StagePage_Teacher(
                                                    title:
                                                        worldsFNames[dsIndex],
                                                    worldName:
                                                        worldsNames[ds2Index],
                                                    worldNum: int.parse(
                                                        '${worldsFNames[ds2Index][6]}'),
                                                  )));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[200],
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            worldsFNames[ds2Index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Orbitron',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
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
                      }))
        ],
      ),
    );
  }
}
