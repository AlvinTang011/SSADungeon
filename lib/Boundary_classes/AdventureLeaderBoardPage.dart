import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/AdventureLeaderBoardController.dart';

import '../Controller/AdventureLeaderBoardController.dart';

class AdventureLeaderBoardPage extends StatefulWidget {
  @override
  _AdventureLeaderBoardPageState createState() =>
      _AdventureLeaderBoardPageState();
}

class _AdventureLeaderBoardPageState extends State<AdventureLeaderBoardPage> {
  List<StudentInfo> studentList;

  void initState() {
    super.initState();
    initTest();
  }

  void initTest() async {
    List<StudentInfo> temp = [];
    temp = await AdventureLeaderBoardController().loadStudentInfo();
    List<StudentInfo> newTemp =
        AdventureLeaderBoardController().sortStudent(temp);
    setState(
      () {
        studentList = newTemp;
      },
    );
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
            Navigator.popAndPushNamed(context, '/HomePage');
          },
        ),
        centerTitle: true,
        title: Text(
          "Leaderboards",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15),
              height: 65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border(
                  bottom: BorderSide(
                    width: 1.00,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 100,
                    child: GestureDetector(
                      child: Card(
                        elevation: 4.0,
                        color: Colors.orange[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(width: 1.25, color: Colors.black),
                        ),
                        child: Center(
                          child: Text("Adventure",
                              style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, '/PvPLeaderBoardPage');
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(width: 1.25, color: Colors.black),
                        ),
                        child: Center(
                          child: Text("PVP",
                              style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.25,
                    color: Colors.black,
                  ),
                ),
                color: Colors.grey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: AdventureLeaderBoardController());
                      },
                      child: Card(
                        elevation: 4.0,
                        color: Colors.blueGrey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(width: 1, color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("    Search for name",
                                style: TextStyle(fontFamily: 'Orbitron'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.9,
              child: ListView.builder(
                itemCount: AdventureLeaderBoardController().itemCount(),
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
                            width: MediaQuery.of(context).size.width / 1.3,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text((index + 1).toString() + ".",
                                    style: TextStyle(fontSize: 18)),
                                Text("   "), //Padding
                                Icon(Icons.face, size: 65),
                                Text("  "), //Padding
                                Text(studentList[index].name,
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Orbitron')),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(studentList[index].score.toString(),
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Orbitron')),
                            ),
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
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          AdventureLeaderBoardController()
                                                  .myPosition()
                                                  .toString() +
                                              ".",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Orbitron')),
                                    ),
                                  ),
                                  Icon(Icons.face, size: 65),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                        AdventureLeaderBoardController()
                                            .myInfo()
                                            .name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Orbitron')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                AdventureLeaderBoardController()
                                    .myInfo()
                                    .score
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Orbitron')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
