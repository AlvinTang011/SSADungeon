import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ChallengePVP.dart';
import 'LevelCreatorPVP.dart';

class PVPage extends StatefulWidget {
  @override
  _PVPageState createState() => _PVPageState();
}

class _PVPageState extends State<PVPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "PvP",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/HomePage');
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/PvP_Background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 150),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChallengeUI()),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.whatshot_rounded, size: 50)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Challenge",
                            style:
                                TextStyle(fontFamily: 'Orbitron', fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => createLevel()),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.add_circle_outline_sharp,
                                  size: 50)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create PvP\nlevels",
                              style: TextStyle(
                                  fontFamily: 'Orbitron', fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
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