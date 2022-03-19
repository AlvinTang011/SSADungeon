import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorldQuizController {
  List<int> questionList = [];
  int world;
  List<int> questionDone = [];
  int totalScore = 0;
  String userID;

  WorldQuizController(int world) {
    this.world = world;
    this.userID = FirebaseAuth.instance.currentUser.uid;
  }

  /// This function gets questions
  Future<int> getQuestion(List<int> qnIDList) async {
    Random random = new Random();
    while (true) {
      int randomNumber =
          random.nextInt(qnIDList.length - 1);
      if (questionDone.contains(qnIDList[randomNumber]) == false) {
        questionDone.add(qnIDList[randomNumber]);
        return qnIDList[randomNumber];
      }
    }
  }

  /// This function adds the total score
  void addTotalScore() {
    this.totalScore++;
  }

  /// This function gets all the world MCQ questions
  Future<List<int>> getAllWorldMcQQuestions(int worldNum) async {
    List<int> tempQuestionList = [];
    await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((questions) {
      questions.docs.forEach((question) {
        if (question.data()["World"] == worldNum &&
            question.data()["Type"] == "mcq") {
          tempQuestionList.add(question.data()["qnid"]);
        }
      });
    });

    return tempQuestionList;
  }

  /// This function checks the Access and saves it
  void checkAndSaveAccess() async {
    if (totalScore >= 10) {
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(getNextWorld())
          .update({
        "userAccess": FieldValue.arrayUnion([userID])
      }).then((value) => print("Successfully saved world access"));
    }
  }

  /// This function gets the next world accord to the world number
  String getNextWorld() {
    switch (this.world + 1) {
      case 1:
        return "Architectural design";
        break;
      case 2:
        return "Code Building";
        break;
      case 3:
        return "Requirement Specification";
        break;
      case 4:
        return "Software Deployment";
        break;
      case 5:
        return "Software Maintenance";
        break;
      case 6:
        return "Software Testing";
        break;
      default:
        break;
    }
  }
}
