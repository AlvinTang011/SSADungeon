import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';

class CreateFITBPage extends StatefulWidget {
  int worldNumber;
  int stageNumber;
  int levelNumber;

  CreateFITBPage({this.worldNumber, this.stageNumber, this.levelNumber});

  @override
  _CreateFITBPageState createState() => _CreateFITBPageState();
}

class _CreateFITBPageState extends State<CreateFITBPage> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  String _question = "Press here to type...";
  String answers = "Press here to type...";

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
          "Fill in the Blanks",
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
            Padding(
              padding: EdgeInsets.only(top: 50, right: 260, bottom: 5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Answer:",
                  style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
                ),
              ),
            ),

            Align(
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
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Orbitron'),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: answers),
                      onChanged: (text) {
                        setState(
                          () {
                            answers = text;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// Confirm button
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      if (answers != null &&
                          _question != null &&
                          answers != "Press here to type..." &&
                          _question != 'Press here to type...') {
                        /// call the function
                        configManager.createNewFITBQn(
                          widget.worldNumber,
                          widget.stageNumber,
                          widget.levelNumber,
                          _question,
                          answers,
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
                      } else {
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
                          child: Text("Confirm", style: TextStyle(fontFamily: 'Orbitron')),
                        ),
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
