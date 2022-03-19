import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/SummaryReportLevelPage.dart';
import 'package:ssadgame/Controller/SummaryReportController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SummaryReportStagePage extends StatefulWidget {
  final String worldName;

  const SummaryReportStagePage({Key key, this.worldName}) : super(key: key);
  @override
  _SummaryReportStagePageState createState() => _SummaryReportStagePageState();
}

class _SummaryReportStagePageState extends State<SummaryReportStagePage> {
  int _value;

  List<String> stageList = [];
  List<String> levelList = [];

  List<double> avgScoreList = [];
  Map<String, double> stageAvgScoreList = {};
  List<double> unlockedList = [];
  List<double> selectedList = [];
  int totalScore = 50;
  int totalStudents = 80;
  int selectedTotal = 50;
  int _stageCount = 0;
  bool _showSpinner = false;
  int sum = 0;
  int counter = 0;


  void _getStageList() async {
    setState(() {
      _showSpinner = true;
    });
    await FirebaseFirestore.instance
        .collection('worlds')
        .doc(widget.worldName)
        .collection('Stage')
        .get()
        .then((stages) {
      _stageCount = stages.docs.length;

      stages.docs.forEach((stage) {
        stageList.add(stage.id);
        stage.data()['userScore'].forEach((key, value) {
          counter++;
          sum += value;
        });
        if ((sum / counter).isNaN) {
          avgScoreList.add(0);
        } else {
          avgScoreList.add((sum / counter));
        }

        sum = 0;
      });
    });

    setState(() {
      _showSpinner = false;
      _value = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _getStageList();
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );

    return _showSpinner
        ? spinkit
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.orange[100],
              toolbarHeight: 60,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                "Stage Summary",
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                                      SummaryReportController()
                                          .getSelectedStage(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Orbitron',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey[400],
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: DropdownButton(
                                    value: _value,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Average Scores",
                                            style: TextStyle(
                                                fontFamily: 'Orbitron',
                                                fontWeight: FontWeight.w800)),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("No. of Unlocked",
                                            style: TextStyle(
                                                fontFamily: 'Orbitron',
                                                fontWeight: FontWeight.w800)),
                                        value: 2,
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _value = value;
                                          if (value == 1) {
                                            selectedList = avgScoreList;
                                            selectedTotal = totalScore;
                                          } else {
                                            selectedList = unlockedList;
                                            selectedTotal = totalStudents;
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
                              itemCount: _stageCount,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
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
                                              /// Padding
                                              Text(""),
                                              Text(stageList[index],
                                                  style: TextStyle(
                                                      fontFamily: 'Orbitron')),

                                              /// Padding
                                              Text(""),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SummaryReportLevelPage(
                                                                  worldName: widget
                                                                      .worldName,
                                                                  stageName:
                                                                      stageList[
                                                                          index])));
                                                  SummaryReportController()
                                                      .setSelectedLevel(
                                                          stageList[index]);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.blueGrey[200]),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.black),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Text("View Levels",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Orbitron')),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          alignment: Alignment.center,
                                          child: Text(
                                              avgScoreList[index].toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Orbitron')),
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
