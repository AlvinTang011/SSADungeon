import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'ChallengePVP.dart';

class PVPGame extends StatefulWidget {
  String levelName;
  PVPGame({this.levelName});

  @override
  _PVPGameState createState() => _PVPGameState();
}

class _PVPGameState extends State<PVPGame> {
  String text =
      'Hey! I just challenged you to this game I created. See if you can beat my score. If you have not installed the app yet, go and download from https://github.com/AlvinTang81/CZ3003_Repo';

  String subject = 'Game invitation';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PVP Success'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Text(
              'Custom Level was successfully created with name ${widget.levelName}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0)),
          SizedBox(height: 30.0),
          RaisedButton(
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share(text,
                    subject: subject,
                    sharePositionOrigin:
                    box.localToGlobal(Offset.zero) & box.size);
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
              child: Text('Share game with friends',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
          Center(
            child: RaisedButton(
              child: Text('View all PVP Levels',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChallengeUI()));
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
