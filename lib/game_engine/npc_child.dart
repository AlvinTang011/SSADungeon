import 'dart:math';
import 'dart:ui';
import 'package:ssadgame/Boundary_classes/HomePage.dart';
import 'package:ssadgame/Boundary_classes/question_type/questions_1.dart';
import 'package:ssadgame/Boundary_classes/question_type/questions_3.dart';
import 'package:ssadgame/Boundary_classes/question_type/questions_2.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Npc_child extends SimpleEnemy {
  Position initPosition;
  double tileSize = 32;
  DataInterface cd;
  double attack = 25;

  Npc_child(this.initPosition, double tileSize, DataInterface cd)
      : this.cd = cd,
        super(
          initPosition: initPosition,
          height: tileSize,
          width: tileSize,
          life: 100,
          speed: 100,
          collision: Collision(height: tileSize, width: tileSize),
          initDirection: Direction.right,
          animIdleRight: FlameAnimation.Animation.sequenced(
            "goblin_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "goblin_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "goblin_run_right.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "goblin_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  void update(double dt) {
    super.update(dt);
    // if the unit dies, the unit stops
    if (this.isDead) return;
    this.seePlayer(
      observed: (player) {
        this.seeAndMoveToPlayer(
          closePlayer: (player) {
            execAttack();
          },
          radiusVision: tileSize * 4,
        );
      },
      radiusVision: tileSize * 4,
    );
  }

  void die() {
    showAnswer();
    remove();
    super.die();
  }

  /// This function retrieves and displays the question
  void fightMe() {
    String question = "Don't think this is the end! Solve this question, HAH!";
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          question,
          Container(
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }

  void showResult() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          "Well done, it's time for you to move on to the next challenge!",
          Container(
            width: 50,
            height: 50,
            child: AnimationWidget(
              playing: true,
            ),
          ),
        ),
      ],
    );
  }

  void execAttack() {
    this.simpleAttackMelee(
      damage: 5,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        "atack_effect_bottom.png",
        6,
        textureWidth: 21,
        textureHeight: 21,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      heightArea: 32,
      widthArea: 32,
    );
  }

  /// This function navigates the user to the question page
  void showAnswer() async {
    int choice = cd.getQuestionType();
    switch (choice) {
      case 0:
        await Navigator.push(gameRef.context,
            MaterialPageRoute(builder: (context) => mcq1(test: cd)));
        break;
      case 1:
        await Navigator.push(gameRef.context,
            MaterialPageRoute(builder: (context) => mcq2(test: cd)));
        break;
      case 2:
        await Navigator.push(gameRef.context,
            MaterialPageRoute(builder: (context) => mcq3(test: cd)));
        break;
      default:
        break;
    }
  }


  void receiveDamage(double damage, int id) {
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }
}
