import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewController {
  /// This function gets the student attempts
  static Future<Map<String, dynamic>> getStudentAttempt(String userID,
      int attemptNumber, String world, int stage, int level) async {

    Map<String, dynamic> studentAttempt = await FirebaseFirestore.instance
        .collection("worlds")
        .doc(world)
        .collection("Stage")
        .doc("Stage $stage")
        .collection("Level")
        .doc("Level $level")
        .get()
        .then((users) {
      return users.data()[userID]["Attempt $attemptNumber"];
    });

    return studentAttempt;
  }

  /// This function gets the list of questions attempted
  static Future<Map<String, QuestionAnswer>> getListOfQnAttempted(
      Map<String, dynamic> studentAttempt) async {
    Map<String, QuestionAnswer> questionMap = {};
    //
    for (var studentAttempt in studentAttempt.entries) {
      await Future.delayed(const Duration(milliseconds: 200));
      int qnID = int.parse(studentAttempt.key);
      QuestionAnswer dummy = await FirebaseFirestore.instance
          .collection("QuestionDatabase")
          .get()
          .then((querySnapShot) async {
        String temp;
        String correctAns;
        String tempType;
        querySnapShot.docs.forEach((question) async {
          if (question.data()["qnid"] == qnID) {
            temp = question.data()["Question"];
            tempType = question.data()["Type"];
            if (question.data()["Answer"].runtimeType == bool) {
              if (question.data()["Answer"] == true) {
                correctAns = "True";
              } else {
                correctAns = "False";
              }
            } else {
              correctAns = question.data()["Answer"];
            }
          }
        });
        QuestionAnswer set = new QuestionAnswer(
            temp, correctAns, studentAttempt.value, qnID, tempType);
        return set;
      });
      questionMap[qnID.toString()] = dummy;
    }
    return questionMap;
  }
}

class QuestionAnswer {
  String question;
  String answer;
  bool userAns;
  int qnID;
  String type;

  QuestionAnswer(
      String question, String answer, bool userAns, int qnID, String tempType) {
    this.question = question;
    this.answer = answer;
    this.userAns = userAns;
    this.qnID = qnID;
    this.type = tempType;
  }
}
