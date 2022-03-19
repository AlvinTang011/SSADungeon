import 'package:flutter/material.dart';
import 'package:ssadgame/game_engine/Menu.dart';

double tileSize = 20.0;

class GameEngine extends StatefulWidget {
  String title;
  String stageNumber;
  int levelNumber;
  String characterSelected;
  GameEngine(
      {this.title, this.stageNumber, this.levelNumber, this.characterSelected});
  @override
  _GameEngineState createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game_Engine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Menu(
        title: widget.title,
        stageNumber: widget.stageNumber,
        levelNumber: widget.levelNumber,
        characterSelected: widget.characterSelected,
      ),
    );
  }
}
