import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Animation get idleLeft => Animation.sequenced(
        "knight_idle_left.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      );

  static Animation get idleRight => Animation.sequenced(
        "knight_idle.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      );

  static Animation get runRight => Animation.sequenced(
        "knight_run.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      );

  static Animation get runLeft => Animation.sequenced(
        "knight_run_left.png",
        6,
        textureWidth: 16,
        textureHeight: 16,
      );

  static Animation get attack => Animation.sequenced("human_damage.png", 6,
      textureHeight: 16, textureWidth: 16);

}
