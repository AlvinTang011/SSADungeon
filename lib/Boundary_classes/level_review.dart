import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/Controller/ReviewController.dart';

class level_review extends StatefulWidget {
  String worldName;
  int stageNo;
  int levelNo;
  int attemptNo;

  level_review({this.worldName, this.stageNo, this.levelNo, this.attemptNo});

  @override
  _level_reviewState createState() => _level_reviewState();
}

class _level_reviewState extends State<level_review> {
  String userId = FirebaseAuth.instance.currentUser.uid;
  int level;

  @override
  void initState() {
    super.initState();
    initTest();
    level = widget.levelNo;
  }

  void initTest() async {

    Map<String, dynamic> studentAttempt = {};
    Map<String, QuestionAnswer> displayedValues = {};

    studentAttempt = await ReviewController.getStudentAttempt(userId,
        widget.attemptNo, widget.worldName, widget.stageNo, widget.levelNo);

    displayedValues =
        await ReviewController.getListOfQnAttempted(studentAttempt);

    List<String> correctAns = [];
    correctAns = await getAnswer(displayedValues);
    setState(() {
      List<String> tempDisplayQn = [];
      List<bool> userAns = [];
      displayedValues.forEach((key, value) {
        tempDisplayQn.add(value.question);
        userAns.add(value.userAns);

      });
      questions = tempDisplayQn;
      answers = correctAns;
      userAnsList = userAns;
    });
  }

  Future<List<String>> getAnswer(
      Map<String, QuestionAnswer> displayedValues) async {
    List<String> correctAns = [];
    for (var x in displayedValues.entries) {
      await Future.delayed(const Duration(milliseconds: 20));
      if (x.value.type == "mcq") {
        int index = int.parse(x.value.answer.substring(7));
        index--;
        McqQuestion test = await LoadQuestions.getMcq(x.value.qnID);
        correctAns.add(test.answers[index]);
      } else {
        correctAns.add(x.value.answer);
      }
    }
    return correctAns;
  }

  Widget output_icon(bool result) {
    if (result) {
      return Icon(
        Icons.done_sharp, //fiber_manual_record_sharp,
        color: Colors.green[800],
        size: 35,
      );
    } else {
      return Icon(
        Icons.highlight_off_sharp, //fiber_manual_record_sharp,
        color: Colors.red[700],
        size: 35,
      );
    }
  }

  List<String> questions = [];

  List<bool> userAnsList = [true];
  List<String> answers = [];

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
            "Level $level Review",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
          ),
        ),
        body: ListView.builder(
          itemCount: questions
              .length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Card(
                              elevation: 5.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Question ${index + 1}",
                                              style: TextStyle(
                                                fontSize: 22.0,
                                              ),
                                            ),
                                            SizedBox(width: 55),
                                            Container(
                                              child: output_icon(
                                                  userAnsList[index]),
                                            )
                                          ],
                                        )),
                                    color: Colors.grey[200],
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                            //to allow long questions to be scrolled
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                "Question:\n${questions[index]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              //to allow long answers to be scrolled
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text("Answer:\n${answers[index]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                      )))),
                        )
                      ],
                    ))),
          ),
        ));
  }
}
