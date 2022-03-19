import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/SummaryReportController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SummaryReportLevelPage extends StatefulWidget {
  final String worldName;
  final String stageName;

  const SummaryReportLevelPage({Key key, this.worldName, this.stageName})
      : super(key: key);

  @override
  _SummaryReportLevelPageState createState() => _SummaryReportLevelPageState();
}

class _SummaryReportLevelPageState extends State<SummaryReportLevelPage> {
  int _value = 1;

  List<String> levelList = [];

  List<double> avgScoreList = [];
  List<double> unlockedList = [];
  List<double> reattemptList = [];
  List<double> selectedList = [];

  int totalScore = 10;
  int totalStudents = 80;
  int selectedTotal = 10;
  bool _showSpinner = false;
  int _levelCount = 0;
  int highScoreSum = 0;
  int highScoreCount = 0;

  Future<void> getLevelList() async {
    setState(() {
      _showSpinner = true;
    });
    await FirebaseFirestore.instance
        .collection('worlds')
        .doc(widget.worldName)
        .collection('Stage')
        .doc(widget.stageName)
        .collection('Level')
        .get()
        .then((levels) {
      _levelCount = levels.docs.length;

      levels.docs.forEach((level) {
        levelList.add(level.id);
        highScoreCount = 0;
        highScoreSum = 0;
        level.data().forEach((key, value) {
          if (key != 'userAccess' && level.data()[key]['HighScore'] != null) {
            int highScore = level.data()[key]['HighScore'];
            highScoreSum += highScore;
            highScoreCount += 1;
          }
        });

        //ADD THE AVG SCORE
        if ((highScoreSum / highScoreCount).isNaN) {
          avgScoreList.add(0);
        } else {
          avgScoreList.add(highScoreSum / highScoreCount);
        }
      });
    });

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLevelList();
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        toolbarHeight: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        centerTitle: true,
        title: Text(
          "Level Summary",
          style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: _showSpinner
          ? spinkit
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                                SummaryReportController().getSelectedLevel(), style: TextStyle(fontSize: 17, fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            color: Colors.grey[400],
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: DropdownButton(
                              value: _value,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Average Scores", style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("No. of Unlocked", style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("No. of Re-Attempts", style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                                  value: 3,
                                ),
                              ],
                              onChanged: (value) {
                                setState(
                                  () {
                                    _value = value;
                                    switch (_value) {
                                      case 1:
                                        {
                                          selectedList = avgScoreList;
                                          selectedTotal = totalScore;
                                        }
                                        break;

                                      case 2:
                                        {
                                          selectedList = unlockedList;
                                          selectedTotal = totalStudents;
                                        }
                                        break;

                                      case 3:
                                        {
                                          selectedList = reattemptList;
                                          selectedTotal = totalStudents;
                                        }
                                        break;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: _levelCount,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Level " + (index + 1).toString(), style: TextStyle(fontFamily: 'Orbitron')),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    alignment: Alignment.center,
                                    child: Text(avgScoreList[index].toString(), style: TextStyle(fontFamily: 'Orbitron')),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
