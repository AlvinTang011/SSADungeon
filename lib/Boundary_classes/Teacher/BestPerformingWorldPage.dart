import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';

class BestPerformingWorldPage extends StatefulWidget {
  @override
  _BestPerformingWorldPageState createState() =>
      _BestPerformingWorldPageState();
}

class _BestPerformingWorldPageState extends State<BestPerformingWorldPage> {
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  List<String> worldsNames = [];
  List<String> worldsFNames = [];
  List<String> worldScores = [];
  List<int> worldScoresInt = [];
  List<String> stagesNumbers = [];
  List<String> stagesScores = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    worldsNames = await configManager.getWorldName();

    /// get worlds full name
    worldsFNames = await configManager.getWorldFName(worldsNames);

    /// get the list of world scores
    worldScores = await configManager.getWorldsScores(worldsNames);

    /// get the list of world scores int
    worldScoresInt = await configManager.getWorldsScoresInt(worldsNames);
  }

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
          "Best Performing World",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: (MediaQuery.of(context).size.height - 85) / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.25,
                    color: Colors.black,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Best", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                        Text(""),
                        Text("Average Points:", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                        Text("214" + "/250", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.2),
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Req Specification", textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, '/Teacher/BestPerformingStagePage');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Card(
                                color: Colors.grey[400],
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                  height: 30,
                                  width: 80,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("More Details",
                                        style: TextStyle(fontSize: 10, fontFamily: 'Orbitron')),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 85) / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  width: 1.25,
                  color: Colors.black,
                )),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Second", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                        Text("Best", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                        Text(""),
                        Text("Average Points:", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                        Text("212" + "/250", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.2),
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child:
                                Text("World 2", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Card(
                                elevation: 5,
                                color: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                  height: 30,
                                  width: 80,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("More Details",
                                        style: TextStyle(fontSize: 10, fontFamily: 'Orbitron')),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 85) / 3,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Third", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                        Text("Best", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
                        Text(""),
                        Text("Average Points:", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                        Text("214" + "/250", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.2),
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child:
                                Text("World 3", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Card(
                                color: Colors.grey[400],
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                  height: 30,
                                  width: 80,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("More Details",
                                        style: TextStyle(fontSize: 10, fontFamily: 'Orbitron')),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
