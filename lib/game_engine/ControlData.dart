import 'dart:collection';
import 'package:ssadgame/Controller/LoadQuestion.dart';
import 'package:ssadgame/game_engine/DataInterface.dart';

class ControlData extends DataInterface {
  int score;
  int totalQuestions;
  int numberOfQuestionsLeft;
  List<int> questionsDone;
  int questionType;
  int world;
  int stage;
  int level;
  HashMap<String, bool> studentAttempt = new HashMap();
  QuestionConfiguration qf;

  /// This function gets the question configuration in terms of world, stages and levels as well as the defined question configuration
  ControlData(String world, String stage, int level, QuestionConfiguration qf) {
    this.questionType = -1;
    this.score = 0;
    this.totalQuestions = 0;
    this.numberOfQuestionsLeft = 10;
    questionsDone = [];
    this.world = int.parse('${world[6]}');
    this.stage = int.parse(stage.substring(6));
    this.level = level;
    this.qf = qf;
  }

  /// This function gets the question type
  int getQuestionType() {
    questionType++;
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
    if (qf.checkRemaining(questionType % 3) == 0) {
      questionType++;
    } else {
      var x = questionType % 3;
      qf.numLeft[x] -= 1;
      return x;
    }
  }

  /// This function returns the current score
  String getScoreFormat() {
    return ('$score / $totalQuestions');
  }

  /// This function gets the MCQ Questions
  Future<int> getMcqQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdOfAllMcqQuestions(world, stage, level);

    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function gets the True False Questions
  Future<int> getTFQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdOfAllTFQuestions(world, stage, level);
    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function gets the Open Ended Questions
  Future<int> getOEQuestion() async {
    List<int> allQuestions =
        await LoadQuestions.getIdofAllOEQuestions(world, stage, level);
    for (int i = 0; i < allQuestions.length; i++) {
      if (questionsDone.contains(allQuestions[i])) {
        continue;
      } else {
        questionsDone.add(allQuestions[i]);
        return allQuestions[i];
      }
    }
  }

  /// This function updates the current correct score
  void updateScoreCorrectAnswer(int qnID) {
    score++;
    totalQuestions++;
    studentAttempt[qnID.toString()] = true;
  }

  /// This functions return the total questions
  int getTotalQuestions() {
    return totalQuestions;
  }

  /// This function udpates the current total score
  void updateTotal(int qnID) {
    studentAttempt[qnID.toString()] = false;
    totalQuestions++;
  }

  /// This function returns the student attempts
  Map<String, bool> getStudentAttempt() {
    return this.studentAttempt;
  }

  /// This function returns the right world name based on the world number
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

  /// This function returns the level
  @override
  int getLevel() {
    return level;
  }

  /// This function returns the level name
  @override
  String getLevelName() {
    throw UnimplementedError();
  }

  /// This function returns the score
  @override
  int getScore() {
    return score;
  }

  /// This function returns the stage
  @override
  int getStage() {
    return stage;
  }
}

class QuestionConfiguration {
  List<int> numLeft = [];
  int numberOfMcqQn;
  int numberOfTrueFalse;
  int numberOfOpenEnded;

  QuestionConfiguration(int numMCQ, int numTF, int numOE) {
    this.numberOfMcqQn = numMCQ;
    this.numberOfTrueFalse = numTF;
    this.numberOfOpenEnded = numOE;
    numLeft.add(numMCQ);
    numLeft.add(numTF);
    numLeft.add(numOE);
  }

  /// This function returns the remaining questions left
  int checkRemaining(int choice) {
    return numLeft[choice];
  }
}
