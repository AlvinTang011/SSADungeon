import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LevelLeaderBoardController.dart';

class LevelLeaderBoardPage extends StatefulWidget {
  @override
  _LevelLeaderBoardPageState createState() => _LevelLeaderBoardPageState();
}

class _LevelLeaderBoardPageState extends State<LevelLeaderBoardPage> {
  String leaderBoardType = 'scores';
  LevelLeaderBoardController lvlLeaderBoardController = LevelLeaderBoardController();

  void initState(){
    super.initState();
    lvlLeaderBoardController.myInformation(leaderBoardType);
    lvlLeaderBoardController.sortMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/PvPLeaderBoardPage');
          },
        ),
        centerTitle: true,
        title: Text(
          "Leaderboards",
          style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            /// Level name
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border(
                  bottom: BorderSide(
                    width: 1.25,
                    color: Colors.black,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 50,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.blueGrey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        side: BorderSide(width: 1, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(LevelLeaderBoardController().getSelectedLevel(), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Player Name, Time, Score
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    /// Player name
                    Container(
                      width: 285,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text("Player Name", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                    ),


                    /// Score
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Score ", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron', fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 385,
              child: ListView.builder(
                itemCount: LevelLeaderBoardController().itemCount(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: 285,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text((index + 1).toString() + ".", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                                Icon(Icons.face, size: 65),
                                Text(LevelLeaderBoardController()
                                    .getName(leaderBoardType, index), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(LevelLeaderBoardController()
                                    .getScores(leaderBoardType, index)
                                    .toString(), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron'))),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 285,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(LevelLeaderBoardController().myPosition.toString() +
                                ".", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                            Icon(Icons.face, size: 65),
                            Text("(me)", style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child:
                          Text(LevelLeaderBoardController().myScore.toString(), style: TextStyle(fontSize: 18, fontFamily: 'Orbitron')),
                        ),
                      ),
                    ],
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
