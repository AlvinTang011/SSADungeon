import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';
import 'package:ssadgame/game_engine/bar_life_component.dart';

class KnightInterface extends GameInterface {
  DataInterface cd;

  KnightInterface(DataInterface cd)
      : this.cd = cd,
        super();

  void resize(Size size) {
    add(BarLifeComponent(cd));
    add(InterfaceComponent(
      sprite: Sprite('blue_button1.png'),
      spriteSelected: Sprite('blue_button2.png'),
      height: 40,
      width: 40,
      id: 5,
      position: Position(150, 20),
      onTapComponent: () {
        if (gameRef.player != null) {
        }
      },
    ));
    super.resize(size);
  }
}
