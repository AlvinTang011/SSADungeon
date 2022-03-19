import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Assignments_Teacher.dart';

class shareAssignment extends StatefulWidget {
  @override
  _shareAssignmentState createState() => _shareAssignmentState();
}

class _shareAssignmentState extends State<shareAssignment> {
  @override
  String text = 'Hi all! '
      'Hope you are doing well!'
      'I have just sent you all an assignment on various topics for your revision before the final exams! Go to the Assignments tab on your app and attempt it';

  String subject = 'Assignment Invitation';

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('PVP Success',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.blueGrey,

            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Assignment was successfully created!',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0)),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitterSquare),
                    iconSize: 50.0,
                    tooltip: 'Share to Twitter',
                    onPressed: () async {
                      var response = await FlutterShareMe().shareToTwitter(
                          url: 'https://github.com/AlvinTang81/CZ3003_Repo',
                          msg: text);
                      if (response == 'success') {
                      }
                    },
                  ),
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
                      child: Text('Share assignment via other platforms',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
                  RaisedButton(
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => assignmentTeacher()));

                    },
                    child: Text('Back to Homepage',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0)),
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                  ),
                ]),
          ),
        ));
  }
}
