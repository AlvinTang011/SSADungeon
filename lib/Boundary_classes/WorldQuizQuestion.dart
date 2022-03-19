import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/Controller/WorldQuizController.dart';
import 'package:ssadgame/Controller/CheckAnswer.dart';

import 'WorldPage.dart';

class WorldQuizQuestion extends StatefulWidget {
  int worldNumber;
  String characterSelected;

  WorldQuizQuestion({this.worldNumber, this.characterSelected});

  @override
  _WorldQuizQuestionState createState() => _WorldQuizQuestionState();
}

class _WorldQuizQuestionState extends State<WorldQuizQuestion> {
  int mcqID = -1;
  List<String> answers = ["", "", "", ""];
  String question = "";
  List<int> questionsList = [];
  WorldQuizController wqc;
  String submission = "Next";
  int qnid;
  int questionNumber;

  @override
  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {
    wqc = new WorldQuizController(widget.worldNumber);
    questionsList = await wqc.getAllWorldMcQQuestions(wqc.world);
    //retrieves the function.
    qnid = await wqc.getQuestion(questionsList);
    McqQuestion qn = await LoadQuestions.getMcq(qnid);
    setState(() {
      question = qn.question;
      List<String> temp = [];
      for (int i = 0; i < qn.answers.length; i++) {
        temp.add(qn.answers[i]);
      }
      answers = temp;
      questionNumber = wqc.questionDone.length;
    });
  }

  bool _button1HasBeenPressed = false;
  bool _button2HasBeenPressed = false;
  bool _button3HasBeenPressed = false;
  bool _button4HasBeenPressed = false;
  int _answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: true,
        right: true,
        top: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 70,
                    width: 192,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "World Quiz",
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  height: 200,
                  // width: 90,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        questionNumber.toString() + ") " + question,
                        style: TextStyle(
                          fontSize: 19,
                          fontFamily: "Orbitron",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        primary: Colors.grey[400],
                        onPrimary: Colors.black,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 100,
                  width: 470,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _button1HasBeenPressed = !_button1HasBeenPressed;
                          (_button2HasBeenPressed)
                              ? _button2HasBeenPressed = !_button2HasBeenPressed
                              : _button2HasBeenPressed = _button2HasBeenPressed;
                          (_button3HasBeenPressed)
                              ? _button3HasBeenPressed = !_button3HasBeenPressed
                              : _button3HasBeenPressed = _button3HasBeenPressed;
                          (_button4HasBeenPressed)
                              ? _button4HasBeenPressed = !_button4HasBeenPressed
                              : _button4HasBeenPressed = _button4HasBeenPressed;
                          (_button1HasBeenPressed)
                              ? _answer = 1
                              : _answer = null;
                        });
                      },
                      child: Text(
                        answers[0],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Orbitron",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        primary: _button1HasBeenPressed
                            ? Colors.greenAccent
                            : Colors.white,
                        onPrimary: Colors.black,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 100,
                  width: 470,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _button2HasBeenPressed = !_button2HasBeenPressed;
                          (_button1HasBeenPressed)
                              ? _button1HasBeenPressed = !_button1HasBeenPressed
                              : _button1HasBeenPressed = _button1HasBeenPressed;
                          (_button3HasBeenPressed)
                              ? _button3HasBeenPressed = !_button3HasBeenPressed
                              : _button3HasBeenPressed = _button3HasBeenPressed;
                          (_button4HasBeenPressed)
                              ? _button4HasBeenPressed = !_button4HasBeenPressed
                              : _button4HasBeenPressed = _button4HasBeenPressed;
                          (_button2HasBeenPressed)
                              ? _answer = 2
                              : _answer = null;
                        });
                      },
                      child: Text(
                        answers[1],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Orbitron",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        primary: _button2HasBeenPressed
                            ? Colors.greenAccent
                            : Colors.white,
                        onPrimary: Colors.black,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 100,
                  width: 470,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _button3HasBeenPressed = !_button3HasBeenPressed;
                          (_button1HasBeenPressed)
                              ? _button1HasBeenPressed = !_button1HasBeenPressed
                              : _button1HasBeenPressed = _button1HasBeenPressed;
                          (_button2HasBeenPressed)
                              ? _button2HasBeenPressed = !_button2HasBeenPressed
                              : _button2HasBeenPressed = _button2HasBeenPressed;
                          (_button4HasBeenPressed)
                              ? _button4HasBeenPressed = !_button4HasBeenPressed
                              : _button4HasBeenPressed = _button4HasBeenPressed;
                          (_button3HasBeenPressed)
                              ? _answer = 3
                              : _answer = null;
                        });
                      },
                      child: Text(
                        answers[2],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Orbitron",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        primary: _button3HasBeenPressed
                            ? Colors.greenAccent
                            : Colors.white,
                        onPrimary: Colors.black,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 100,
                  width: 470,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _button4HasBeenPressed = !_button4HasBeenPressed;
                          (_button1HasBeenPressed)
                              ? _button1HasBeenPressed = !_button1HasBeenPressed
                              : _button1HasBeenPressed = _button1HasBeenPressed;
                          (_button2HasBeenPressed)
                              ? _button2HasBeenPressed = !_button2HasBeenPressed
                              : _button2HasBeenPressed = _button2HasBeenPressed;
                          (_button3HasBeenPressed)
                              ? _button3HasBeenPressed = !_button3HasBeenPressed
                              : _button3HasBeenPressed = _button3HasBeenPressed;
                          (_button4HasBeenPressed)
                              ? _answer = 4
                              : _answer = null;
                        });
                      },
                      child: Text(
                        answers[3],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Orbitron",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        primary: _button4HasBeenPressed
                            ? Colors.greenAccent
                            : Colors.white,
                        onPrimary: Colors.black,
                      )),
                ),
                Container(
                    width: 90,
                    child: ElevatedButton(
                        onPressed: () async {
                          int result =
                              await CheckAnswer.checkMCQ(_answer, qnid);
                          if (result == 1) {
                            wqc.addTotalScore();
                          }
                          //go next page
                          if (wqc.questionDone.length >= 20) {
                            //Navigator push to end
                            int result = 0;
                            if (wqc.totalScore >= 10) {
                              wqc.checkAndSaveAccess(); //update userAccess if he passed
                              result = 1;
                            }
                            //pop to home page
                            switch (result) {
                              case 0:
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: Stack(
                                              overflow: Overflow.visible,
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Container(
                                                    height: 250,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 70, 10, 10),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                            "You have failed the world quiz, you shall not advance!!",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(height: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WorldPage(
                                                                    characterSelected:
                                                                        widget
                                                                            .characterSelected,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                                "Return to World Page"),
                                                          )
                                                        ])))
                                              ]));
                                    });
                                break;
                              case 1:
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: Stack(
                                              overflow: Overflow.visible,
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Container(
                                                    height: 250,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 70, 10, 10),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                            "Good job! You have passed the world quiz and unlocked the next world!",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(height: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WorldPage(
                                                                    characterSelected:
                                                                        widget
                                                                            .characterSelected,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                                "Return to World Page"),
                                                          )
                                                        ])))
                                              ]));
                                    });
                                break;
                              default:
                            }
                          } else {
                            qnid = await wqc.getQuestion(questionsList);
                            McqQuestion qn = await LoadQuestions.getMcq(qnid);
                            setState(() {
                              question = qn.question;
                              List<String> temp = [];
                              for (int i = 0; i < qn.answers.length; i++) {
                                temp.add(qn.answers[i]);
                              }
                              answers = temp;
                              if (wqc.questionDone.length == 20) {
                                submission = "Submit";
                              }
                              questionNumber = wqc.questionDone.length;
                            });
                          }
                        },
                        child: Text(submission,
                            style: TextStyle(
                              fontFamily: "Orbitron",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          primary: Colors.orange[100],
                          onPrimary: Colors.black,
                        ),),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
