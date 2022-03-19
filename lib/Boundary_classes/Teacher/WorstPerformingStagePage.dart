import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorstPerformingStagePage extends StatefulWidget {
  @override
  _WorstPerformingStagePageState createState() =>
      _WorstPerformingStagePageState();
}

class _WorstPerformingStagePageState extends State<WorstPerformingStagePage> {
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
            Navigator.popAndPushNamed(context, '/Teacher/WorstPerformingWorldPage');
          },
        ),
        centerTitle: true,
        title: Text(
          "Worst Performing Stage",
          style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'Orbitron'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.25,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Text(
                  "Requirement Specification",
                  style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'), //HARDCODED
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: (MediaQuery.of(context).size.height - 125) / 3,
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
                        Text("Worst", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Stage 1", style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          Text(""),
                          Text("Stage Name", style: TextStyle(fontSize: 16, fontFamily: 'Orbitron')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 125) / 3,
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
                        Text("Worst", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Stage 2", style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          Text(""),
                          Text("Stage Name", style: TextStyle(fontSize: 16, fontFamily: 'Orbitron')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 125) / 3,
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
                        Text("Worst", style: TextStyle(fontSize: 22, fontFamily: 'Orbitron')),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Stage 3", style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),
                          Text(""),
                          Text("Stage Name", style: TextStyle(fontSize: 16, fontFamily: 'Orbitron')),
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
