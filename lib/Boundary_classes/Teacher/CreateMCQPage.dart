import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';

class CreateMCQPage extends StatefulWidget {
  int worldNumber;
  int stageNumber;
  int levelNumber;

  CreateMCQPage({this.worldNumber, this.stageNumber, this.levelNumber});

  @override
  _CreateMCQPageState createState() => _CreateMCQPageState();
}

class _CreateMCQPageState extends State<CreateMCQPage> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  String _question = "Press here to type...";
  List<String> answers = [
    "Press here to type...",
    "Press here to type...",
    "Press here to type...",
    "Press here to type..."
  ];
  String answerQ;
  List<Color> correctAnswer = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

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
          "MCQ",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: 35),
                  alignment: Alignment.center,
                  height: 180,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Orbitron'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: _question),
                      onChanged: (text) {
                        setState(() {
                          _question = text;
                        });
                      }),
                ),
              ),
            ),

            ///Answers
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Stack(
                          children: [
                            TextFormField(
                              style: TextStyle(fontFamily: 'Orbitron'),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: answers[index]),
                              onChanged: (text) {
                                setState(
                                  () {
                                    answers[index] = text;
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.check, size: 40),
                              color: correctAnswer[index],
                              onPressed: () {
                                setState(
                                  () {
                                    if (correctAnswer[index] == Colors.grey) {
                                      answerQ = "choice $index";
                                      correctAnswer[index] = Colors.green;
                                      correctAnswer[(index + 1) % 4] =
                                          Colors.grey;
                                      correctAnswer[(index + 2) % 4] =
                                          Colors.grey;
                                      correctAnswer[(index + 3) % 4] =
                                          Colors.grey;
                                    } else {
                                      correctAnswer[index] = Colors.grey;
                                      answerQ = "";
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Confirm button
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    if (answerQ != null &&
                        answerQ != '' &&
                        _question != null &&
                        _question != 'Press here to type...' &&
                        answers[0] != 'Press here to type...' &&
                        answers[1] != 'Press here to type...' &&
                        answers[2] != 'Press here to type...' &&
                        answers[3] != 'Press here to type...') {
                      /// call the function
                      configManager.createNewMCQQn(
                        widget.worldNumber,
                        widget.stageNumber,
                        widget.levelNumber,
                        _question,
                        answers,
                        answerQ,
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text("Question has been added"),
                              actions: [
                                TextButton(
                                  child: Text("Okay"),
                                  onPressed: () async {
                                    Navigator.pop(context, true);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });

                      /// pop context twice to levelpage
                    } else {
                      /// show dialog if u want
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text(
                                  "Some of the fields are left empty, please try again"),
                              actions: [
                                TextButton(
                                  child: Text("Confirm"),
                                  onPressed: () async {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(width: 1),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 90,
                      child: Center(
                        child: Text("Confirm",
                            style: TextStyle(fontFamily: 'Orbitron')),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
