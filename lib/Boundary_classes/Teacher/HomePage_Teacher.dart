import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/SettingsPage.dart';

class HomePage_Teacher extends StatefulWidget {
  @override
  _HomePage_TeacherState createState() => _HomePage_TeacherState();
}

class _HomePage_TeacherState extends State<HomePage_Teacher> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/homepage.png'),
              fit: BoxFit.fill,
            ))),

            ///Play Button
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, '/Teacher/WorldPage_Teacher');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Add Question'),
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, '/Teacher/Assignments_Teacher');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Give Assignment'),
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  ///Leaderboards Button
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, '/Teacher/SummaryReportPage');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Summary Report'),
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  ///Settings Button
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Settings'),
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      )),
                ],
              ),
            ),
          ],
        ),);
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Orbitron',
        fontWeight: FontWeight.bold),
  );
}
