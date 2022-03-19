import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/SummaryReportStagePage.dart';
import 'package:ssadgame/Controller/SummaryReportController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SummaryReportWorldPage extends StatefulWidget {
  @override
  _SummaryReportWorldPageState createState() => _SummaryReportWorldPageState();
}

class _SummaryReportWorldPageState extends State<SummaryReportWorldPage> {
  int _value = 1;

  List<String> worldList = [];

  List<double> avgScoreList = [];
  Map<String, double> worldAvgScoreList = {
    'Stage 1': 5.5,
    'Stage 2': 0.0,
    'Stage 3': 0.0,
    'Stage 4': 0.0,
    'Stage 5': 0.0
  };
  List<double> worldAvgScoreList2 = [5.5, 0, 0, 0, 0];
  List<double> unlockedList = [];
  List<double> selectedList = [];
  int totalScore = 250;
  int totalStudents = 80;
  int selectedTotal = 250;

  int _worldCount = 0;

  bool _showSpinner = false;
  int sum = 0;
  int counter = 0;
  double sum2 = 0;

  Future<bool> _getWorldList() async {
    await FirebaseFirestore.instance.collection('worlds').get().then((worlds) {
      int _worldCount2 = worlds.docs.length;
      worlds.docs.forEach((world) async {
        worldList.add(world.id);
        await FirebaseFirestore.instance
            .collection('worlds')
            .doc(world.id)
            .collection('Stage')
            .get()
            .then((stage) {
          sum = 0;
          counter = 0;
          stage.docs.forEach((stage) {
            counter += 1;
            stage.data()['userScore'].forEach((key, value) {
              sum += value;
            });
          });
          worldAvgScoreList[world.id] = sum / counter;
        });
      });
      setState(() {
        _worldCount = _worldCount2;
      });
    });
    return false;
  }

  @override
  void initState() {
    super.initState();
    initTest();

  }

  void initTest() async {
    setState(() {
      _showSpinner = true;
    });

    setState(() async {
      _showSpinner = await _getWorldList();
    });
    setState(() {
      _showSpinner = false;
    });

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
        ),
        centerTitle: true,
        title: Text(
          "Summary Report (World)",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: SafeArea(
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
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text("Worlds"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text("Average Scores"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("No. of Unlocked"),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                              if (value == 1) {
                                selectedList = avgScoreList;
                                selectedTotal = totalScore;
                              } else {
                                selectedList = unlockedList;
                                selectedTotal = totalStudents;
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            _showSpinner
                ? spinkit
                : Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: _worldCount,
                        itemBuilder: (context, index) {
                          return _showSpinner
                              ? spinkit
                              : Container(
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
                                              Text(worldList[index]),

                                              /// Padding
                                              Text(""),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SummaryReportStagePage(
                                                                worldName:
                                                                    worldList[
                                                                        index],
                                                              )));
                                                  SummaryReportController()
                                                      .setSelectedStage(
                                                          worldList[index]);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
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
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Text("View Stages"),
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
                                          child: Text(worldAvgScoreList2[index]
                                              .toString()),
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
