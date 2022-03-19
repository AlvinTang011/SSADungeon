import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';

import '../../Controller/CheckAnswer.dart';

/// This is the MCQ question Page UI
class mcq1 extends StatefulWidget {
  DataInterface test;
  mcq1({this.test});
  @override
  _mcq1State createState() => _mcq1State();
}

class _mcq1State extends State<mcq1> {
  int mcqID = -1;
  List<String> answers = ["", "", "", ""];
  String question = "";

  @override
  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {
    mcqID = await widget.test.getMcqQuestion();
    McqQuestion qn = await LoadQuestions.getMcq(mcqID);
    setState(() {
      question = qn.question;
      List<String> temp = [];
      for (int i = 0; i < qn.answers.length; i++) {
        temp.add(qn.answers[i]);
      }
      answers = temp;
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
                Container(
                  height: 70,
                  width: 125,
                  alignment: Alignment.center,
                  child: Text(
                    "Level " + widget.test.getLevel().toString(),
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
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
                          "Score: " + widget.test.getScoreFormat(),
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                    )),
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
                        question,
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
                              await CheckAnswer.checkMCQ(_answer, mcqID);
                          if (result == 1) {
                            widget.test.updateScoreCorrectAnswer(mcqID);
                          } else {
                            widget.test.updateTotal(mcqID);
                          }
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
                                                  height: 200,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 70, 10, 10),
                                                      child: Column(children: [
                                                        Text(
                                                          "Wrong!",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context, true);
                                                          },
                                                          child: Text("Okay"),
                                                        )
                                                      ])))
                                            ]));
                                  });
                              Navigator.pop(context, true);
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
                                                  height: 200,
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 70, 10, 10),
                                                      child: Column(children: [
                                                        Text(
                                                          "Correct!",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context, true);
                                                          },
                                                          child: Text("Okay"),
                                                        )
                                                      ])))
                                            ]));
                                  });
                              Navigator.pop(context, true);
                              break;
                            default:
                          }
                        },
                        child: Text("Next",
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
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
