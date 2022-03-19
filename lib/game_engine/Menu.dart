import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/game_engine/game.dart';

import 'ControlData.dart';

class Menu extends StatefulWidget {
  String title;
  String stageNumber;
  int levelNumber;
  String characterSelected;

  Menu(
      {this.title, this.stageNumber, this.levelNumber, this.characterSelected});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Menu_Background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 80,
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange[100]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Text('Start Game',
                      style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'Orbitron')),
                  onPressed: () {
                    QuestionConfiguration qf = QuestionConfiguration(4, 4, 2);
                    ControlData cd = new ControlData(widget.title,
                        widget.stageNumber, widget.levelNumber, qf);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Game(
                                title: widget.title,
                                characterSelected: widget.characterSelected,
                                dataInterface: cd,
                              )),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 80,
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange[100]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Text('Select another level', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'Orbitron')),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
