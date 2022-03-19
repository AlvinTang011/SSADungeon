import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadQuestions {

  ///gets all the mcq question inside a world for a specific level
  static Future<List<int>> getIdOfAllMcqWorldLevel(
      int worldName, int levelName) async {
    List<int> listOfQnID = [];

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((question) {
        if (question.data()["World"] == worldName &&
            question.data()["Level"] == levelName &&
            question.data()["Type"] == "mcq") {
          listOfQnID.add(question.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  ///gets all the true false question inside a world for a specific level
  static Future<List<int>> getIdOfAllTFWorldLevel(
      int worldName, int levelName) async {
    List<int> listOfQnID = [];
    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((question) {
        if (question.data()["World"] == worldName &&
            question.data()["Level"] == levelName &&
            question.data()["Type"] == "T/F") {
          listOfQnID.add(question.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  ///gets all the OE question inside a world for a specific level
  static Future<List<int>> getIdOfAllOEWorldLevel(
      int worldName, int levelName) async {
    List<int> listOfQnID = [];

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((question) {
        if (question.data()["World"] == worldName &&
            question.data()["Level"] == levelName &&
            question.data()["Type"] == "short ans") {
          listOfQnID.add(question.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  /// get all the Id of all MCQ uestions
  static Future<List<int>> getIdOfAllMcqQuestions(
      int worldName, int stageName, int levelName) async {
    List<int> listOfQnID = [];

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((questions) {
        if (questions.data()["World"] == worldName &&
            questions.data()["Stage"] == stageName &&
            questions.data()["Level"] == levelName &&
            questions.data()["Type"] == "mcq") {
          listOfQnID.add(questions.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  /// This function gets the answer
  static Future<List<String>> getAnswer(int mcqID) async {
    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: mcqID)
        .get()
        .then((querySnapShot) {
      return querySnapShot.docs[0].reference.collection("Answers").get();
    }).then((querySnapShot) {
      List<String> tempAnswers = [];
      querySnapShot.docs.forEach((answer) {
        tempAnswers.add(answer.data()["choice 1"]);
        tempAnswers.add(answer.data()["choice 2"]);
        tempAnswers.add(answer.data()["choice 3"]);
        tempAnswers.add(answer.data()["choice 4"]);
      });
      return tempAnswers;
    });
  }

  /// This function gets the MCQ
  static Future<McqQuestion> getMcq(int mcqID) async {
    int tempQID;
    String tempQuestion;

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: mcqID)
        .get()
        .then((querySnapShot) async {
      querySnapShot.docs.forEach((element) async {
        tempQuestion = element.data()["Question"];
        tempQID = element.data()["qnid"];
      });
      List<String> tempAnswers = await getAnswer(mcqID);
      return McqQuestion(tempAnswers, tempQuestion, tempQID);
    });
  }

  /// This function gets the ID for all Open Ended questions
  static Future<List<int>> getIdofAllOEQuestions(
      int worldName, int stageName, int levelName) async {
    List<int> listOfQnID = [];

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((questions) {
        if (questions.data()["World"] == worldName &&
            questions.data()["Stage"] == stageName &&
            questions.data()["Level"] == levelName &&
            questions.data()["Type"] == "short ans") {
          listOfQnID.add(questions.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  /// This function gets the open ended questions
  static Future<OEQuestion> getOEQuestion(int oeID) {
    int tempID;
    String tempQn;
    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: oeID)
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((element) {
        tempQn = element.data()["Question"];
        tempID = element.data()["qnid"];
      });
      return OEQuestion(tempQn, tempID);
    });
  }

  /// This function gets the ID of all TF questions
  static Future<List<int>> getIdOfAllTFQuestions(
      int worldName, int stageName, int levelName) async {
    List<int> listOfQnID = [];

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((querySnapShot) {
      querySnapShot.docs.forEach((questions) {
        if (questions.data()["World"] == worldName &&
            questions.data()["Stage"] == stageName &&
            questions.data()["Level"] == levelName &&
            questions.data()["Type"] == "T/F") {
          listOfQnID.add(questions.data()["qnid"]);
        }
      });
      return listOfQnID;
    });
  }

  /// This function gets the True False question
  static Future<TrueFalseQuestion> getTrueFalse(int tfID) async {
    int tempQID;
    String tempQuestion;
    bool tempAnswers;

    return FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .where("qnid", isEqualTo: tfID)
        .get()
        .then((querySnapShot) async {
      querySnapShot.docs.forEach((element) async {
        tempQuestion = element.data()["Question"];
        tempQID = element.data()["qnid"];
        tempAnswers = element.data()["Answer"];
      });
      return TrueFalseQuestion(tempAnswers, tempQuestion, tempQID);
    });
  }
}

class OEQuestion {
  String question;
  int qID;

  OEQuestion(question, qID) {
    this.question = question;
    this.qID = qID;
  }
}

class TrueFalseQuestion {
  String question;
  int qID;
  bool answer;
  TrueFalseQuestion(answers, question, qID) {
    this.question = question;
    this.qID = qID;
    this.answer = answers;
  }
}

class McqQuestion {
  List<String> answers;
  String question;
  int qID;

  McqQuestion(answers, question, qID) {
    this.answers = answers;
    this.question = question;
    this.qID = qID;
  }
}
