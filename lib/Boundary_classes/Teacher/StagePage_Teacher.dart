import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'LevelPage_Teacher.dart';

class StagePage_Teacher extends StatefulWidget {
  String title;
  String worldName;
  int worldNum;
  StagePage_Teacher({this.title, this.worldName, this.worldNum});
  @override
  _StagePage_TeacherState createState() => _StagePage_TeacherState();
}

class _StagePage_TeacherState extends State<StagePage_Teacher> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> stagesNames = [];
  List<String> stagesNumbers = [];

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

    stagesNames = await configManager.getStageName(widget.worldName);
    stagesNumbers = await configManager.getStageNumber(widget.worldName);

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
          "Select Stage",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange[100],
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
      body: _showSpinner
          ? spinkit
          : Column(
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
                      widget.title.toString(),
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
          new Expanded(
              child: new ListView.builder(
                  itemCount: stagesNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      height: 160,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelPage_Teacher(
                                    stageName: stagesNames[index],
                                    stageNumber: stagesNumbers[index],
                                    worldName: widget.worldName,
                                      worldNumber: widget.worldNum)),
                            );
                          }, //Need to link to the next page
                          child: Stack(children: [
                            Column(
                              //alignment: Alignment.topRight,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10),
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Text(
                                        stagesNumbers[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22,
                                          fontFamily: 'Orbitron',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                        child: Text(
                                          stagesNames[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Orbitron',
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ]),
                          color: Colors.blueGrey[200],
                          shape: new RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  
}
