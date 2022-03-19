import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'HomePage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          "Settings",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("APP SETTINGS",
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 20)),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('Students')
                  .collection('Students')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .set({'music': false}, SetOptions(merge: true));
              advancedPlayer.stop();
            },
            child: Text("STOP"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('Students')
                  .collection('Students')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .set({'music': true}, SetOptions(merge: true));
              advancedPlayer.resume();
            },
            child: Text("PLAY"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("ACCOUNT",
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 20)),
              ),
            ],
          ),
          ListTile(
            onTap: () {
            },
            leading: Icon(Icons.person),
            title:
                Text("Edit Profile", style: TextStyle(fontFamily: 'Orbitron')),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text("Sign out?"),
                      actions: [
                        TextButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            advancedPlayer.stop();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.pushReplacementNamed(
                                context, '/LoginPage');
                          },
                        ),
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            leading: Icon(Icons.logout),
            title: Text("Log Out", style: TextStyle(fontFamily: 'Orbitron')),
            trailing: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
