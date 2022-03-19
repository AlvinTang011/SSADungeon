import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ReviewController.dart';

import 'level_review.dart';

class PastAttemptsPage extends StatefulWidget {
  String worldName;
  int stageNo;
  int levelNo;

  PastAttemptsPage({this.worldName, this.stageNo, this.levelNo});

  @override
  _PastAttemptsPageState createState() => _PastAttemptsPageState();
}

class _PastAttemptsPageState extends State<PastAttemptsPage> {
  String userId = FirebaseAuth.instance.currentUser.uid;
  List<int> pastScores = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    int numAttempts =
        await getPastAttempts(widget.worldName, widget.stageNo, widget.levelNo);
    List<int> tempPastScores = [];
    for (int i = 0; i < numAttempts; i++) {
      Map<String, dynamic> studentAttempt = {};
      studentAttempt = await ReviewController.getStudentAttempt(
          userId, i + 1, widget.worldName, widget.stageNo, widget.levelNo);
      int pastScore = 0;
      for (var x in studentAttempt.entries) {
        if (x.value == true) {
          pastScore++;
        }
      }
      tempPastScores.add(pastScore);
    }

    setState(() {
      pastScores = tempPastScores;
    });
  }

  Future<int> getPastAttempts(String world, int stage, int level) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    return await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level $level")
        .get()
        .then((users) {
      return users.data()[userId]["StudentTotalAttempt"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Your Past Attempts",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 60),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Past attempts...",
                    style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: ListView.builder(
                      itemCount: pastScores.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Score: " +
                                              pastScores[index].toString() +
                                              "/10",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Orbitron')),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  level_review(
                                                    worldName: widget.worldName,
                                                    stageNo: widget.stageNo,
                                                    levelNo: widget.levelNo,
                                                    attemptNo: index + 1,
                                                  )));
                                    },
                                    child: Card(
                                      color: Colors.orange[100],
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(width: 1),
                                      ),
                                      child: SizedBox(
                                        height: 30,
                                        width: 90,
                                        child: Center(
                                          child: Text(
                                            "View More",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Orbitron'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
