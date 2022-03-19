import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {

  String userId = FirebaseAuth.instance.currentUser.uid;
  String userName;

  @override
  void initState() {
    super.initState();
    init();

  }
  init() async {
    userName = await _getName();
    setState(() {
    });
  }
  Future<String> _getName() async{
    String name;
    await FirebaseFirestore.instance
        .collection('users')
        .doc('Students')
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      name = value.data()['name'];
    });
    return name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: true,
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
            "Select Game Mode",
            style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: new BoxDecoration(color: Colors.white),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Human.png',
                    height: 70,
                    width: 70,
                  ),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 25.0, fontFamily: 'Orbitron'),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 3,
            ),

            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, '/characterSelection');
                      },
                      child: Center(
                        child: Text(
                          'Adventure',
                          style: TextStyle(fontSize: 25.0, fontFamily: 'Orbitron', color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/PVP');
                      },
                      child: Center(
                        child: Text(
                          'PvP',
                          style: TextStyle(fontSize: 25.0, fontFamily: 'Orbitron', color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
