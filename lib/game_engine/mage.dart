import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter/cupertino.dart' as Router;
import 'package:flutter/material.dart' as Navigation;
import 'package:ssadgame/Controller/CheckAnswer.dart';
import 'DataInterface.dart';
import 'Menu.dart';

class Mage extends SimplePlayer {
  String userId = FirebaseAuth.instance.currentUser.uid;
  double stamina = 100;
  bool test = false;
  DataInterface cd;

  Mage(Position initPosition, double tileSize, DataInterface cd)
      : this.cd = cd,
        super(
          initPosition: initPosition,
          height: 1.2 * tileSize,
          width: 0.5 * tileSize,
          life: 80,
          speed: 100,
          collision: Collision(height: tileSize / 2, width: tileSize / 2),
          initDirection: Direction.right,
          animIdleLeft: Animation.sequenced(
            "wizard_run_left.png",
            4,
            textureWidth: 16,
            textureHeight: 32,
          ),
          animIdleRight: Animation.sequenced(
            "wizard_run_right.png",
            4,
            textureWidth: 16,
            textureHeight: 32,
          ),
          animRunLeft: Animation.sequenced(
            "wizard_run_left.png",
            4,
            textureWidth: 16,
            textureHeight: 32,
          ),
          animRunRight: Animation.sequenced(
            "wizard_run_right.png",
            4,
            textureWidth: 16,
            textureHeight: 32,
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
      //does nothing
    } else if (event.id == 1 && event.event == ActionEvent.DOWN) {
      actionAttack();
    }
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
    this.simpleAttackRange(
      damage: 40,
      animationBottom: FlameAnimation.Animation.sequenced(
        "fireball_bottom.png",
        6,
        textureWidth: 21,
        textureHeight: 21,
      ),
      animationLeft: FlameAnimation.Animation.sequenced(
        'fireball_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationRight: FlameAnimation.Animation.sequenced(
        'fireball_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationTop: FlameAnimation.Animation.sequenced(
        'fireball_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationDestroy: FlameAnimation.Animation.sequenced(
        'explosion_fire.png',
        6,
        textureWidth: 32,
        textureHeight: 32,
      ),
      width: 32 * 0.8,
      height: 32 * 0.8,
      collision: Collision(
        width: 32 * 0.6,
        height: 32 * 0.6,
        align: Offset(32 * 0.1, 32 * 0.1),
      ),
    );
  }

  @override
  void die() {
    //remove();
    super.die();
    remove();

    /// if its a created level
    try {
      saveRecords();
    } catch (e) {
      saveLevelScore();
    }
    gameFinished();
  }

  void die2() {
    //remove();
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
    print("DOES IT REACH");
    CheckAnswer.saveStudentAttempt(cd.getStudentAttempt(), cd.getWorldName(),
        cd.getStage(), cd.getLevel());
  }

  /// This function saves the student's level score into the database
  void saveLevelScore() {
    print("DOES IT REACH CREATED");
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
      //(Router.Route<dynamic> route) => false,
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
      // (Router.Route<dynamic> route) => false,
    );
  }
}
