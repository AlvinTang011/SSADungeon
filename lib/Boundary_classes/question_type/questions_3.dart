import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/CheckAnswer.dart';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/game_engine/ControlData.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';

/// This is the Open Ended question Page UI
class mcq3 extends StatefulWidget {
  DataInterface test;
  mcq3({this.test});
  @override
  _mcq3State createState() => _mcq3State();
}

class _mcq3State extends State<mcq3> {
  int oeID = -1;
  String question = "";
  TextEditingController userAns = TextEditingController();

  @override
  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {
    oeID = await widget.test.getOEQuestion();
    OEQuestion qn = await LoadQuestions.getOEQuestion(oeID);
    setState(() {
      question = qn.question;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          left: true,
          right: true,
          bottom: true,
          top: true,
          child: SingleChildScrollView(
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
                          width: 200,
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
                              ]),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                          )),
                        ),
                      ),
                    ]),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  height: 400.0,
                  width: 350.0,
                  color: Colors.grey[200],
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Question " +
                                (widget.test.getTotalQuestions() + 1)
                                    .toString(),
                            style: TextStyle(
                              fontFamily: "Orbitron",
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(question,
                              style: TextStyle(
                                fontFamily: "Orbitron",
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                    )),
                    child: TextFormField(
                      controller: userAns,
                      decoration:
                          InputDecoration(hintText: 'Enter your answer here'),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Container(
                    width: 90,
                    child: ElevatedButton(
                        onPressed: () async {
                          String temp = userAns.text;
                          bool result = await CheckAnswer.checkFillInTheBlanks(
                              temp, oeID);
                          if (result) {
                            widget.test.updateScoreCorrectAnswer(oeID);
                          } else {
                            widget.test.updateTotal(oeID);
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
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 70, 10, 10),
                                                      child: Column(children: [
                                                        Text(
                                                          "Wrong!!",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.center,
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
                          Navigator.pop(context);
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
          )),
    );
  }
}
