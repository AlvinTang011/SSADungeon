import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/Teacher/SelectQuestionPage.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LevelPage_Teacher extends StatefulWidget {
  String worldName;
  int worldNumber;
  String stageName;
  String stageNumber;

  LevelPage_Teacher(
      {this.worldName, this.stageName, this.stageNumber, this.worldNumber});

  @override
  _LevelPage_TeacherState createState() => _LevelPage_TeacherState();
}

class _LevelPage_TeacherState extends State<LevelPage_Teacher> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> levelsNumbers = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  bool _showSpinner;

  init() async {
    /// get the worldsnames
    setState(() {
      _showSpinner = true;
    });

    levelsNumbers = await configManager.getLevelNumber(
        widget.worldName, widget.stageNumber);

    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
      color: Colors.black,
      size: 50.0,
    );
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //AppBar
      appBar: AppBar(
        title: Text(
          "Select Level",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange[100],
        toolbarHeight: 60,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      //The Topic Name/Heading
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 2.0,
                    child: Text(
                      widget.stageName.toString(), //Hardcoded, need to change
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 17,
                        decorationColor: Colors.black,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.black),
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          _showSpinner
              ? spinkit
              : new Expanded(
                  child: new ListView.builder(
                      itemCount: levelsNumbers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new Container(
                          height: 80,
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: RaisedButton(
                              onPressed: () {
                              }, //Need to link to the next page
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        levelsNumbers[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22,
                                          fontFamily: 'Orbitron',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectQuestionPage(
                                                    worldNumber:
                                                        widget.worldNumber,
                                                    stageNumber: int.parse(
                                                        '${widget.stageNumber[6]}'),
                                                    stageName: widget.stageName,
                                                    levelNumber: index + 1,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)
                                            //borderRadius: BorderRadius.circular(30.0),
                                            ),
                                        child: Center(
                                            child: Text('Add\nQuestions',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Orbitron'))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.blueGrey[200],
                              shape: new RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        );
                      }))
          //The buttons
        ],
      ),
    );
  }
}
