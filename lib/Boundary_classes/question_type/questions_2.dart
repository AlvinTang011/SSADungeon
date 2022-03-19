import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/game_engine/ControlData.dart';
import 'package:ssadgame/Controller/CheckAnswer.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';

/// This is the True False question Page UI
class mcq2 extends StatefulWidget {
  final DataInterface test;
  mcq2({this.test});
  @override
  _mcq2State createState() => _mcq2State();
}

class _mcq2State extends State<mcq2> {
  int tfID = -1;
  String question = "";

  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {
    tfID = await widget.test.getTFQuestion();
    TrueFalseQuestion qn = await LoadQuestions.getTrueFalse(tfID);
    setState(() {
      question = qn.question;
    });
  }

  bool _button1HasBeenPressed = false;
  bool _button2HasBeenPressed = false;
  bool _answer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          left: true,
          right: true,
          bottom: true,
          top: true,
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
                    )),
                  ),
                  Expanded(
                      child: Container(
                          height: 70,
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
                          ))))
                ],
              ),
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Text(
                              question,
                              style: TextStyle(
                                fontFamily: "Orbitron",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                      height: 60,
                      width: 345,
                      child: ElevatedButton(
                        child: Text(
                          "True",
                          style: TextStyle(
                            fontFamily: "Orbitron",
                            fontSize: 20,
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
                        ),
                        onPressed: () => {
                          setState(() {
                            _button1HasBeenPressed = !_button1HasBeenPressed;
                            (_button2HasBeenPressed)
                                ? _button2HasBeenPressed =
                                    !_button2HasBeenPressed
                                : _button2HasBeenPressed =
                                    _button2HasBeenPressed;
                            (_button1HasBeenPressed)
                                ? _answer = true
                                : _answer = null;
                          })
                        },
                      )),
                  SizedBox(height: 30),
                  Container(
                      height: 60,
                      width: 345,
                      child: ElevatedButton(
                        child: Text("False",
                            style: TextStyle(
                              fontFamily: "Orbitron",
                              fontSize: 20,
                            )),
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
                        ),
                        onPressed: () => {
                          setState(() {
                            _button2HasBeenPressed = !_button2HasBeenPressed;
                            (_button1HasBeenPressed)
                                ? _button1HasBeenPressed =
                                    !_button1HasBeenPressed
                                : _button1HasBeenPressed =
                                    _button1HasBeenPressed;
                            (_button2HasBeenPressed)
                                ? _answer = false
                                : _answer = null;
                          })
                        },
                      )),
                  SizedBox(height: 50),
                  Container(
                      width: 90,
                      child: ElevatedButton(
                          onPressed: () async {
                            bool result =
                                await CheckAnswer.checkTrueFalse(_answer, tfID);
                            if (result) {
                              widget.test.updateScoreCorrectAnswer(tfID);
                            } else {
                              widget.test.updateTotal(tfID);
                            }
                            (result)
                                ? showDialog(
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 70, 10, 10),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                            "Correct!",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(height: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("Okay"),
                                                          )
                                                        ])))
                                              ]));
                                    })
                                : showDialog(
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 70, 10, 10),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                            "Wrong!!",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(height: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("Okay"),
                                                          )
                                                        ])))
                                              ]));
                                    });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                              fontFamily: "Orbitron",
                              fontSize: 20,
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
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ))),
                ],
              )
            ],
          )),
    );
  }
}
