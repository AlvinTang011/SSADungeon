import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/cupertino.dart' as Router;
import 'package:flutter/material.dart' as Navigation;
import 'package:ssadgame/game_engine/DataInterface.dart';
import 'package:ssadgame/Controller/CheckAnswer.dart';
import 'Menu.dart';


class Knight extends SimplePlayer {
  String userId = FirebaseAuth.instance.currentUser.uid;
  double stamina = 100;
  bool test = false;
  DataInterface cd;

  Knight(Position initPosition, double tileSize, DataInterface cd)
      : this.cd = cd,
        super(
          initPosition: initPosition,
          height: tileSize,
          width: tileSize,
          life: 100,
          speed: 100,
          collision: Collision(height: tileSize / 2, width: tileSize / 2),
          initDirection: Direction.right,
          animIdleLeft: Animation.sequenced(
            "knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleRight: Animation.sequenced(
            "knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: Animation.sequenced(
            "knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: Animation.sequenced(
            "knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
        );

  @override
  void update(double dt) {
    // do anything
    int totalAnswered = cd.getTotalQuestions();

    if (totalAnswered == 10) {
      die2();
      return;
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // do anything
    super.render(canvas);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    // do anything with event of the joystick
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    // do anything with event of the joystick
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      actionAttack();
    } else if (event.id == 2) {}
    super.joystickAction(event);
  }

  @override
  void receiveDamage(double damage, int id) {
    if (isDead) return;
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Navigation.Colors.orange,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }

  void actionAttack() {
    this.simpleAttackMelee(
      damage: 25,
      animationBottom: FlameAnimation.Animation.sequenced(
        "atack_effect_bottom.png",
        6,
        textureWidth: 21,
        textureHeight: 21,
      ),
      animationLeft: FlameAnimation.Animation.sequenced(
        'atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationRight: FlameAnimation.Animation.sequenced(
        'atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationTop: FlameAnimation.Animation.sequenced(
        'atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      heightArea: 32,
      widthArea: 32,
    );
  }

  @override
  void die() {
    super.die();
    remove();

    // if its a created level
    try {
      saveRecords();
    } catch (e) {
      saveLevelScore();
    }
    gameFinished();
  }

  void die2() {
    super.die();
    remove();
    try {
      saveRecords();
    } catch (e) {
      saveLevelScore();
    }
    gameFinished2();
  }

  /// This function saves the student's high score into the database
  void saveRecords() {
    CheckAnswer.saveStudentAttempt(cd.getStudentAttempt(), cd.getWorldName(),
        cd.getStage(), cd.getLevel());
  }

  /// This function saves the student's level score into the database
  void saveLevelScore() {
    CheckAnswer.saveScore(userId, cd.getLevelName(), cd.getScore());
  }

  void gameFinished2() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          "You have finished this stage!",
          Router.Container(
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
    Navigation.Navigator.of(gameRef.context).pop(
      Navigation.MaterialPageRoute(builder: (context) => Menu()),
      //  (Router.Route<dynamic> route) => false,
    );
  }

  void gameFinished() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          "You have ran out of HP, Game Over!",
          Router.Container(
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
    Navigation.Navigator.of(gameRef.context).pop(
      Navigation.MaterialPageRoute(builder: (context) => Menu()),
      //   (Router.Route<dynamic> route) => false,
    );
  }
}
