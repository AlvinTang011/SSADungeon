import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/ChallengePVP.dart';

import 'PVPMenu.dart';

double tileSize = 20.0;

class PVPMain extends StatefulWidget {

  /// user created level name is stageName
  CustomLevels customlevels;
  /// fixed character selected
  String characterSelected = 'Knight';
  PVPMain({this.customlevels});
  @override
  _PVPMainState createState() => _PVPMainState();
}

class _PVPMainState extends State<PVPMain> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PVP_Game_Engine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PVPMenu(
        customlevels: widget.customlevels,
        characterSelected: widget.characterSelected,
      ),
    );
  }
}
