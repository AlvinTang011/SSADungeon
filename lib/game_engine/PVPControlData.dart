import 'dart:collection';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';

import 'ControlData.dart';

class PVPControlData extends DataInterface {
  int score;
  int totalQuestions;
  int numberOfQuestionsLeft;
  int numMcq;
  int numOE;
  int numTF;
  int oeDifficulty;
  int mcqDifficulty;
  int tfDifficulty;
  int world;
  String levelName;
  List<int> questionsDone;
  int questionType;
  HashMap<String, bool> studentAttempt = new HashMap();
  QuestionConfiguration qf;

  PVPControlData(int numMcq, int numOE, int numTF, int oeDifficulty,
      int mcqDifficulty, int tfDifficulty, String levelName, int world) {
    this.questionType = -1;
    this.score = 0;
    this.totalQuestions = 0;
    this.numberOfQuestionsLeft = 10;
    questionsDone = [];
    this.numTF = numTF;
    this.numMcq = numMcq;
    this.numOE = numOE;
    this.oeDifficulty = oeDifficulty;
    this.mcqDifficulty = mcqDifficulty;
    this.tfDifficulty = tfDifficulty;
    this.levelName = levelName;
    this.qf = QuestionConfiguration(numMcq, numTF, numOE);
    this.world = world;
  }

  @override
  /// This function gets MCQ questions from world
  Future<int> getMcqQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdOfAllMcqWorldLevel(world, mcqDifficulty);

    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function gets Open Ended questions from world
  @override
  Future<int> getOEQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdOfAllOEWorldLevel(world, oeDifficulty);

    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function gets True/False questions from world
  @override
  Future<int> getTFQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdOfAllTFWorldLevel(world, oeDifficulty);

    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function gets the question type
  @override
  int getQuestionType() {
    questionType++;
    if (qf.checkRemaining(questionType % 3) == 0) {
      //no more such questions should be asked
      questionType++;
    } else {
      var x = questionType % 3;
      qf.numLeft[x] -= 1;
      return x;
    }
    if (qf.checkRemaining(questionType % 3) == 0) {
      questionType++;
    } else {
      var x = questionType % 3;
      qf.numLeft[x] -= 1;
      return x;
    }
    if (qf.checkRemaining(questionType % 3) == 0) {
      questionType++;
    } else {
      var x = questionType % 3;
      qf.numLeft[x] -= 1;
      return x;
    }
  }

  /// This function returns the current score
  @override
  String getScoreFormat() {
    return ('$score / $totalQuestions');
  }

  /// This function returns the student attempts
  @override
  Map<String, bool> getStudentAttempt() {
    return this.studentAttempt;
  }

  /// This functions return the total questions
  @override
  int getTotalQuestions() {
    return totalQuestions;
  }

  /// This function returns the right world name based on the world number
  @override
  String getWorldName() {
    switch (this.world) {
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

  /// This function updates the current correct score
  @override
  void updateScoreCorrectAnswer(int qnID) {
    score++;
    totalQuestions++;
    studentAttempt[qnID.toString()] = true;
  }

  /// This function udpates the current total score
  @override
  void updateTotal(int qnID) {
    studentAttempt[qnID.toString()] = false;
    totalQuestions++;
  }

  /// This function returns the level
  @override
  int getLevel() {
    return 1;
  }

  /// This function returns the stage
  @override
  int getStage() {
    throw UnimplementedError();
  }

  /// This function returns the level name
  @override
  String getLevelName() {
    return levelName;
  }

  /// This function returns the score
  @override
  int getScore() {
    return score;
  }
}
