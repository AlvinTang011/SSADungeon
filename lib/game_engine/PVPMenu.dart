import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/ChallengePVP.dart';
import 'package:ssadgame/game_engine/game.dart';
import 'PVPControlData.dart';

class PVPMenu extends StatefulWidget {
  CustomLevels customlevels;
  String characterSelected;

  PVPMenu({this.customlevels, this.characterSelected});

  @override
  _PVPMenuState createState() => _PVPMenuState();
}

class _PVPMenuState extends State<PVPMenu> {
  @override
  String getWorldName(int worldNum) {
    switch (worldNum) {
      case 1:
        return "World 1";
        break;
      case 2:
        return "World 2";
        break;
      case 3:
        return "World 3";
        break;
      case 4:
        return "World 4";
        break;
      case 5:
        return "World 5";
        break;
      case 6:
        return "World 6";
        break;
      default:
        break;
    }
  }

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
                  child: Text('Start Game', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'Orbitron')),
                  onPressed: () {
                    PVPControlData pd = new PVPControlData(
                        widget.customlevels.numMcq,
                        widget.customlevels.numOE,
                        widget.customlevels.numTF,
                        widget.customlevels.oeDifficulty,
                        widget.customlevels.mcqDifficulty,
                        widget.customlevels.tfDifficulty,
                        widget.customlevels.levelName,
                        widget.customlevels.worldNum);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Game(
                                title:
                                    getWorldName(widget.customlevels.worldNum),
                                characterSelected: widget.characterSelected,
                                dataInterface: pd,
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
