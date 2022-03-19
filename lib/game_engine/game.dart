import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/game_engine/knight.dart';
import 'package:ssadgame/game_engine/knight_interface.dart';

import 'package:ssadgame/game_engine/npc_child.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';
import 'boundary.dart';
import 'package:ssadgame/game_engine/mage.dart';

class Game extends StatelessWidget {
  String title;
  String characterSelected;
  DataInterface dataInterface;

  Game(
      {this.title,
      this.characterSelected,
      this.dataInterface});

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    var tileSize = ((sizeScreen.height < sizeScreen.width)
            ? sizeScreen.height
            : sizeScreen.width) /
        9;
    tileSize = tileSize.roundToDouble();

    int currentWorld = 3;

    var userCharacterSelection;
    if (characterSelected == 'Knight') {
      userCharacterSelection = Knight(
          Position((tileSize * 2), (tileSize * 3)), tileSize, dataInterface);
    } else if (characterSelected == 'Mage') {
      userCharacterSelection = Mage(
          Position((tileSize * 2), (tileSize * 3)), tileSize, dataInterface);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return BonfireTiledWidget(
          joystick: Joystick(
            directional: JoystickDirectional(
              spriteBackgroundDirectional: Sprite('joystick_background.png'),
              spriteKnobDirectional: Sprite('joystick_knob.png'),
              size: 100,
              isFixed: false,
            ),
            actions: [
              JoystickAction(
                actionId: 0,
                sprite: Sprite('joystick_atack.png'),
                align: JoystickActionAlign.BOTTOM_RIGHT,
                size: 50,
                margin: EdgeInsets.only(bottom: 50, right: 50),
              ),
              JoystickAction(
                actionId: 1,
                sprite: Sprite('joystick_atack_range.png'),
                spriteBackgroundDirection: Sprite('joystick_background.png'),
                enableDirection: true,
                size: 50,
                margin: EdgeInsets.only(bottom: 50, right: 160),
              )
            ],
          ),
          player: userCharacterSelection,
          interface: KnightInterface(dataInterface),
          map: TiledWorldMap(
            'world_$currentWorld.json',
            forceTileSize: Size(32, 32),
          )
            ..registerObject(
                'Npc-child',
                (x, y, width, height) =>
                    Npc_child(Position(x, y), tileSize, dataInterface))
            ..registerObject("Boundary",
                (x, y, width, height) => Boundary(Position(x, y), tileSize)),
          background: BackgroundColorGame(Colors.blueGrey[900]),
          lightingColorGame: Colors.black.withOpacity(0.3),
          cameraZoom:
              1.2, // you can change the game zoom here or directly on camera
        );
      },
    );
  }
}
