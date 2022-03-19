import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';

import 'WorldPage.dart';

class CharacterSelection extends StatefulWidget {
  _CharacterSelection createState() => _CharacterSelection();
}

class _CharacterSelection extends State<CharacterSelection> {
  int currentCharacter = 0;
  String characterChoice = 'Knight';
  final numCharacter = 2;
  ConfigurationManager configManager = ConfigurationManager.getInstance();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    /// get the worldsnames
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          toolbarHeight: 60,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/choices');
            },
          ),
          centerTitle: true,
          title: Text(
            "Choose Your Character",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontFamily: 'Orbitron'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(color: Colors.white),
            ),

            Container(
              child: Image.asset(
                'assets/images/downArrow.png',
                height: 100,
                width: 100,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/images/characters$currentCharacter.png',
                scale: 0.2,
                height: 220,
                width: 220,
              ),
            ),
            Container(
              child: Text(
                characterChoice,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Orbitron'),
              ),
            ),

            /// 0 is knight, 1 is mage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (currentCharacter == 0) {
                        currentCharacter = numCharacter - 1;
                        characterChoice = 'Mage';
                      } else {
                        currentCharacter--;
                        characterChoice = 'Knight';
                      }
                    });
                  },
                  child: Image.asset(
                    'assets/images/leftArrow.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorldPage(
                                  characterSelected: characterChoice,
                                )));
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron'),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.orange[100]),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (currentCharacter == numCharacter - 1) {
                        currentCharacter = 0;
                        characterChoice = 'Knight';
                      } else {
                        currentCharacter++;
                        characterChoice = 'Mage';
                      }
                    });
                  },
                  child: Image.asset(
                    'assets/images/rightArrow.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
