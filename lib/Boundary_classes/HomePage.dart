import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/SettingsPage.dart';
import 'package:ssadgame/Boundary_classes/TeacherAssignmentPage.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'TeacherAssignmentPage.dart';

AudioPlayer advancedPlayer = new AudioPlayer();
AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConfigurationManager configManager = ConfigurationManager.single_instance;
  String userId = FirebaseAuth.instance.currentUser.uid;
  String userName;

  @override
  void initState() {
    super.initState();
    advancedPlayer.stop();
    FirebaseFirestore.instance
        .collection('users')
        .doc('Students')
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      try {
        if (value.data()['music']) {
          audioCache.loop('maplestory.mp3');
        } else {
        }
      } catch (e) {
        audioCache.loop('maplestory.mp3');
        advancedPlayer.stop();
      }
    });
  }

  Future<bool> _stopMusic() async {
    advancedPlayer.stop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _stopMusic,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/homepage.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Adventure or PVP button
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/choices');
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _titleContainer('Play'),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    /// Teacher assignment button
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => teacherAssignmentPage()),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Teachers Assignments'),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[400]),
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
                                context, '/AdventureLeaderBoardPage');
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _titleContainer('Leaderboards'),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[400]),
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
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _titleContainer('Settings'),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Orbitron'),
  );
}
