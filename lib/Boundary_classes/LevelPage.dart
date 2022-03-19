import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ssadgame/Boundary_classes/PastAttemptsPage.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:ssadgame/game_engine/main.dart' as GameEngineMain;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LevelPage extends StatefulWidget {
  String title;
  String worldName;
  String stageName;
  String stageNumber;
  String characterSelected;

  LevelPage(
      {this.title,
      this.worldName,
      this.stageName,
      this.stageNumber,
      this.characterSelected});

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  String userId = FirebaseAuth.instance.currentUser.uid;
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> levelsNumbers = [];
  List<String> levelsScores = [];
  int totalAccessLevels;

  @override
  void initState() {
    super.initState();
    init();
  }

  bool _showSpinner;

  init() async {
    setState(() {
      _showSpinner = true;
    });
    levelsNumbers = await configManager.getLevelNumber(
        widget.worldName, widget.stageNumber);
    levelsScores = await configManager.getLevelsScores(
        widget.worldName, widget.stageNumber);
    totalAccessLevels = await configManager.getTotalAccessForLevels(
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
      /// AppBar
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Select Level",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blueGrey,
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
                    itemCount: totalAccessLevels,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        height: 80,
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameEngineMain.GameEngine(
                                  title: widget.title,
                                  stageNumber: widget.stageNumber,
                                  levelNumber: index + 1,
                                  characterSelected: widget.characterSelected,
                                ),
                              ),
                            );
                          }, //Need to link to the next page
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.only(left: 15),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PastAttemptsPage(
                                        worldName: widget.worldName,
                                        stageNo: int.parse(
                                            '${widget.stageNumber[6]}'),
                                        levelNo: index + 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(10),
                                        //borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                          child: Text(levelsScores[index])),
                                    ),
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
                      );
                    },
                  ),
                ),
          //The buttons
        ],
      ),
    );
  }
}
