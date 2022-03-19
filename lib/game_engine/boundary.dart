import 'package:bonfire/bonfire.dart';

class Boundary extends GameDecoration {
  Boundary(Position initPosition, double tileSize)
      : super.sprite(
          Sprite('blue_button1.png'),
          initPosition: initPosition,
          width: tileSize,
          height: tileSize,
          collision: Collision(height: tileSize, width: tileSize),
        );
}
