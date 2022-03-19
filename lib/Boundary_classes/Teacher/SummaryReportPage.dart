import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryReportPage extends StatefulWidget {
  @override
  _SummaryReportPageState createState() => _SummaryReportPageState();
}

class _SummaryReportPageState extends State<SummaryReportPage> {
  @override
  void initState() {}

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
            Navigator.popAndPushNamed(context, '/Teacher/HomePage_Teacher');
          },
        ),
        centerTitle: true,
        title: Text(
          "Summary Report",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Orbitron',
          ),
        ),
      ),
      body: Column(
        children: [
          /// Adventure Report
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Adventure Summary Report",
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Orbitron')))),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 30,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/SummaryReportWorldPage');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Best Performing Report
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Best Performing Report",
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Orbitron')))),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 30,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/Teacher/BestPerformingWorldPage');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Areas to Improve Report
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Areas to Improve Report",
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Orbitron')))),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 30,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/Teacher/WorstPerformingWorldPage');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
