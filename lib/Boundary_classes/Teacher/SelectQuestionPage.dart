import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CreateFITBPage.dart';
import 'CreateMCQPage.dart';
import 'CreateTFPage.dart';

class SelectQuestionPage extends StatefulWidget {
  int worldNumber;
  String stageName;
  int stageNumber;
  int levelNumber;

  SelectQuestionPage(
      {this.worldNumber, this.stageNumber, this.levelNumber, this.stageName});

  @override
  _SelectQuestionPageState createState() => _SelectQuestionPageState();
}

class _SelectQuestionPageState extends State<SelectQuestionPage> {
  int levelNo;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    /// get the worldsnames
    levelNo = widget.levelNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Question Creator",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.00,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Text(
                  widget.stageName + ' - Level $levelNo',
                  style: TextStyle(
                      fontSize: 17, fontFamily: 'Orbitron'), //HARDCODED
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child:
                  Text("Select Question Type", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateMCQPage(
                                    worldNumber: widget.worldNumber,
                                    stageNumber: widget.stageNumber,
                                    levelNumber: widget.levelNumber,
                                  )),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: 300,
                          height: 100,
                          child: Center(
                            child: Text(
                              'MCQ',
                              style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateFITBPage(
                                    worldNumber: widget.worldNumber,
                                    stageNumber: widget.stageNumber,
                                    levelNumber: widget.levelNumber,
                                  )),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: 300,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fill in the',
                                style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                              ),
                              Text(
                                'Blanks',
                                style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateTFPage(
                                  worldNumber: widget.worldNumber,
                                  stageNumber: widget.stageNumber,
                                  levelNumber: widget.levelNumber,
                                )),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.blueGrey[200],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        width: 300,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'True/False',
                              style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                            ),
                            Text(
                              'Question',
                              style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
