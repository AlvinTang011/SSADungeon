import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CheckAnswer {
  static String userId = FirebaseAuth.instance.currentUser.uid;

  /// This function saves student attempts
  static void saveStudentAttempt(
    HashMap<String, bool> studentResult,
    String world,
    int stage,
    int level,
  ) async {

    int totalScore = 0;

    studentResult.forEach((k, v) {
      if (v) {
        totalScore++;
      }
    });

    int attemptNumber = await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level $level")
        .get()
        .then((querySnapShot) {
      if (querySnapShot.data()[userId]["StudentTotalAttempt"] == null) {
        return 0;
      }
      return querySnapShot.data()[userId]["StudentTotalAttempt"];

    }).catchError((onError) {
      return 0;
    });

    attemptNumber++;
    String temp = "Attempt " + attemptNumber.toString();

    Map<dynamic, dynamic> teste = await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level $level")
        .get()
        .then((querySnapShot) {
      if (querySnapShot.data()[userId] == null) {
        Map<dynamic, dynamic> temp = {};
        return temp;
      }
      return querySnapShot.data()[userId];
    }).catchError((onError) {
      Map<dynamic, dynamic> temp = {};
      return temp;
    });

    teste[temp] = studentResult;
    teste["StudentTotalAttempt"] = attemptNumber++;
    if (teste["HighScore"] == null) {
      teste["HighScore"] = 0;
    }

    if (teste["HighScore"] < totalScore) {
      int oldHighScore = teste["HighScore"];
      teste["HighScore"] = totalScore;
      //updates the student's total adventure score.
      //calls function to update
      saveAdventureScore(userId, teste["HighScore"], oldHighScore);

      ///updates the stages as well
      saveAdventureScoreinStages(
          userId, teste["HighScore"], oldHighScore, world, stage);
    }

    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level $level")
        .update({
      /// revert to set if cant
      userId: teste,
    }).then((dummy) {
    });

    /// unlock the next stage when user score 5 or more
    if (totalScore >= 5 && totalScore < 8) {
      //unlock next level
      int temp = level + 1;
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(world)
          .collection("Stage")
          .doc("Stage $stage")
          .collection("Level")
          .doc("Level $temp")
          .update({
        "userAccess": FieldValue.arrayUnion([userId])
      });

      ///unlocked users is an array, how do I append?
    } else if (totalScore >= 8) {
      //unlock next 2 levels
      if (!(level + 2 > 5)) {
        for (int i = 1; i <= 2; i++) {
          int temp = level + i;
          await FirebaseFirestore.instance
              .collection("worlds")
              .doc(world)
              .collection("Stage")
              .doc("Stage $stage")
              .collection("Level")
              .doc("Level $temp")
              .update({
            "userAccess": FieldValue.arrayUnion([userId])
          });
        }
      } else if (level == 4) {
        int temp = level + 1;
        await FirebaseFirestore.instance
            .collection("worlds")
            .doc(world)
            .collection("Stage")
            .doc("Stage $stage")
            .collection("Level")
            .doc("Level $temp")
            .update({
          "userAccess": FieldValue.arrayUnion([userId])
        });
      }
    } else {
    }

    bool unlockedLevel = await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level 3")
        .get()
        .then((querySnapShot) async {
      bool result = false;
      List<dynamic> userAccess = await querySnapShot.data()["userAccess"];
      if (userAccess.contains(userId)) {
        result = true;
      }
      return result;
    });
    //
    if (unlockedLevel) {
      int totalStages = await FirebaseFirestore.instance
          .collection("worlds")
          .doc(world)
          .get()
          .then((querySnapShot) {
        return querySnapShot.data()["numberOfStages"];
      });

      int nextStage = stage + 1;

      if (nextStage < totalStages) {
        await FirebaseFirestore.instance
            .collection("worlds")
            .doc(world)
            .collection("Stage")
            .doc("Stage $nextStage")
            .update({
          "userAccess": FieldValue.arrayUnion([userId])
        });
      }
    }
  }

  /// This function saves adventure score
  static void saveAdventureScore(
      String userID, int newHighScore, int oldHighScore) async {
    int previousTotal = await FirebaseFirestore.instance
        .collection("users")
        .doc("Students")
        .collection("Students")
        .doc(userID)
        .get()
        .then((user) {
      return user.data()["adv score"];
    });

    int result = previousTotal + newHighScore - oldHighScore;

    await FirebaseFirestore.instance
        .collection("users")
        .doc("Students")
        .collection("Students")
        .doc(userID)
        .update({"adv score": result}).then(
            (value) => print("It has been save into the database"));
  }

  ///This function saces the score
  static void saveScore(String userID, String levelName, int newScore) async {
    int previousTotal = await FirebaseFirestore.instance
        .collection("CustomLevels")
        .doc(levelName)
        .get()
        .then((createdLevelDoc) {
      if (createdLevelDoc.data()["Leaderboard"][userID] == null) {
        return 0;
      }
      return createdLevelDoc.data()["Leaderboard"][userID];
    });

    if (newScore > previousTotal) {
      await FirebaseFirestore.instance
          .collection("CustomLevels")
          .doc(levelName)
          .update({
        'Leaderboard': {userID: newScore}
      }).then((value) => print('saved to database'));
    }
  }

  /// This functions aves adventure score in stages
  static void saveAdventureScoreinStages(String userID, int newHighScore,
      int oldHighScore, String world, int stage) async {
    if (newHighScore > oldHighScore) {
      int newScore = await FirebaseFirestore.instance
          .collection("worlds")
          .doc(world)
          .collection("Stage")
          .doc("Stage $stage")
          .get()
          .then((stage) {
        Map<String, dynamic> allUserScore = stage.data()["userScore"];
        allUserScore[userID] =
            allUserScore[userID] + (newHighScore - oldHighScore);
        return allUserScore[userID];
      });
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(world)
          .collection("Stage")
          .doc("Stage $stage")
          .update({
        "userScore": {userId: newScore}
      }).then((value) => print("saved into db"));
    }
  }

  ///After change mcq answer, this function checks MCQ
  static Future<int> checkMCQ(int userAns, int qnid) async {
    var x = userAns.toString();
    String ans = "choice $x";

    String correctAns = await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: qnid)
        .get()
        .then((querySnapShot) {
      var temp;
      querySnapShot.docs.forEach((question) {
        temp = question.data()["Answer"];
      });
      return temp;
    });

    if (correctAns == ans) {
      return 1;
    } else {
      return 0;
    }
  }

  /// This function checks true false question
  static Future<bool> checkTrueFalse(bool userAns, int qnid) async {
    bool temp = false;

    return await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: qnid)
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((question) {
        var x = question.data()["Answer"];
        if (x == userAns) {
          temp = true;
        }
      });
      return temp;
    });
  }

  /// This function checks FITB questions
  static Future<bool> checkFillInTheBlanks(String userAns, int qnid) async {
    String originalAns = await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: qnid)
        .get()
        .then((querySnapShot) {
      String temp = "";
      querySnapShot.docs.forEach((element) {
        temp = element.data()["Answer"];
      });
      return temp;
    });
    String orgAns = originalAns.toLowerCase();
    String useAns = userAns.toLowerCase();
    useAns.replaceAll("[-+^]*^,.()!?", "");
    if (useAns == orgAns) {
      return true;
    } else {
      return false;
    }
  }
}
