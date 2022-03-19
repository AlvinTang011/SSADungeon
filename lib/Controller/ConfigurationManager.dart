import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfigurationManager {
  String userId = FirebaseAuth.instance.currentUser.uid;

  /// Singleton
  static ConfigurationManager single_instance = null;

  static ConfigurationManager getInstance() {
    if (single_instance == null) single_instance = new ConfigurationManager();

    return single_instance;
  }

  /// This function gets the world name i.e. architecture design
  Future<List<String>> getWorldName() async {
    List<String> nameOfWorlds = [];
    await FirebaseFirestore.instance
        .collection("worlds")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((world) {
        nameOfWorlds.add(world.id);
      });
    });

    return nameOfWorlds;
  }

  /// This function gets the world full name i.e. world 1 : architecture design
  Future<List<String>> getWorldFName(List<String> wNames) async {
    List<String> nameOfWorldsFNames = [];

    for (int i = 0; i < wNames.length; i++) {
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(wNames[i])
          .get()
          .then((world) {
        nameOfWorldsFNames.add(world.data()['world']);
      });
    }
    return nameOfWorldsFNames;
  }

  /// This function gets the stage name i.e. architecture design
  Future<List<String>> getStageName(String worldName) async {
    List<String> nameOfStages = [];
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((stage) {
        nameOfStages.add(stage.data()['name']);
      });
    });
    return nameOfStages;
  }

  /// This function gets the stage number i.e. Stage 1, Stage 2
  Future<List<String>> getStageNumber(String worldName) async {
    List<String> nameOfStages = [];
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((stage) {
        nameOfStages.add(stage.id);
      });
    });
    return nameOfStages;
  }

  /// This function gets the stage scores by querying all the levels and append / totalScore to it
  Future<List<String>> getStagesScores(String wName, List<String> sNumbers) async {
    List<String> stagesScore = [];
    int stageScore = 0;
    int numberOfLevels = sNumbers.length;
    int totalScore = 10 * numberOfLevels;
    for (int i = 0; i < sNumbers.length; i++) {
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(wName)
          .collection("Stage")
          .doc(sNumbers[i])
          .get()
          .then((info) {
            if (info.data()['userScore'][userId] != null) {
              stageScore = info.data()['userScore'][userId];
            } else {
              stageScore = 0;
            }
            stagesScore.add('$stageScore/$totalScore');

        });
    }
    return stagesScore;
  }

  /// This function gets the stage scores by querying all the levels
  Future<List<int>> getStagesScoresInt(
      String wName, List<String> sNumbers) async {
    List<int> stagesScore = [];
    for (int i = 0; i < sNumbers.length; i++) {
      await FirebaseFirestore.instance
          .collection("worlds")
          .doc(wName)
          .collection("Stage")
          .doc(sNumbers[i])
          .get()
          .then((info) {
            try {
              if (info.data()['userScore'][userId] != null) {
                stagesScore.add(info.data()['userScore'][userId]);
              } else {
                stagesScore.add(0);
              }
            } catch (e) {}
      });
    }
    return stagesScore;
  }

  /// This function gets the worlds scores by querying all the levels and append / totalScore to it
  Future<List<String>> getWorldsScores(List<String> wNames) async {
    List<String> worldScores = [];
    List<String> stagesNumbers = [];
    List<int> stagesScores = [];

    /// For each world, get all the stages information
    for (int i = 0; i < wNames.length; i++) {
      int sum = 0;


      /// get all the stages id
      await getStageNumber(wNames[i]).then((stagesNumbersData) {
        stagesNumbers = stagesNumbersData;
      });

      /// get all the stages scores
      await getStagesScoresInt(wNames[i], stagesNumbers)
          .then((stagesScoresData) {
        stagesScores = stagesScoresData;
      });

      /// sum up the stages scores change total score possible dynamically
      int totalScorePossibleWorlds;
      totalScorePossibleWorlds = stagesScores.length * 50;
      for (int j = 0; j < stagesScores.length; j++) {
        sum += stagesScores[j];
      }
      worldScores.add("$sum/$totalScorePossibleWorlds");
    }
    return worldScores;
  }

  /// This function gets the worlds scores by querying all the levels and append / totalScore to it
  Future<List<int>> getWorldsScoresInt(List<String> wNames) async {
    List<int> worldScoresInt = [];
    List<String> stagesNames = [];
    List<String> stagesNumbers = [];
    List<int> stagesScores = [];

    /// For each world, get all the stages information
    for (int i = 0; i < wNames.length; i++) {
      int sum = 0;

      /// get all the stages names
      await getStageName(wNames[i]).then((stagesNamesData) {
        stagesNames = stagesNamesData;
      });

      /// get all the stages id
      await getStageNumber(wNames[i]).then((stagesNumbersData) {
        stagesNumbers = stagesNumbersData;
      });

      /// get all the stages scores
      await getStagesScoresInt(wNames[i], stagesNumbers)
          .then((stagesScoresData) {
        stagesScores = stagesScoresData;
      });

      /// sum up the stages scores change total score possible dynamically
      int totalScorePossibleWorlds;
      //totalScorePossibleWorlds = 250;
      totalScorePossibleWorlds = stagesScores.length * 50;
      for (int j = 0; j < stagesScores.length; j++) {
        sum += stagesScores[j];
      }
      worldScoresInt.add(sum);
    }
    return worldScoresInt;
  }

  /// This function gets the level number i.e. level 1, level 2
  Future<List<String>> getLevelNumber(
      String worldName, String stageNumber) async {
    List<String> nameOfLevels = [];
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .doc(stageNumber)
        .collection("Level")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((level) {
        nameOfLevels.add(level.id);
      });
    });
    return nameOfLevels;
  }

  /// This function inputs a t/f qn created
  void createNewTrueFalseQn(int wNumber, int sNumber, int lNumber, String question, bool answerQ) async {

    String typeQ = "T/F";
    int qnID = await findMaxQnId();

    await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .doc('q$qnID').set(
        {'Answer': answerQ,
        'Level': lNumber,
        'Question': question,
        'Stage' : sNumber,
        'Type':  typeQ,
        'World': wNumber,
        'qnid': qnID}
    );
  }

  /// This function inputs a open ended qn created
  void createNewFITBQn(int wNumber, int sNumber, int lNumber, String question, String answerQ) async {
    String typeQ = "short ans";
    int qnID = await findMaxQnId();

    await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .doc('q$qnID').set(
        {'Answer': answerQ,
          'Level': lNumber,
          'Question': question,
          'Stage' : sNumber,
          'Type':  typeQ,
          'World': wNumber,
          'qnid': qnID}
    );
  }

  /// This function inputs a mcq created
  void createNewMCQQn(int wNumber, int sNumber, int lNumber, String question, List<String> answers, String answerQ) async {
    String typeQ = "mcq";
    int qnID = await findMaxQnId();

    await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .doc('q$qnID').set(
        {'Answer': answerQ,
          'Level': lNumber,
          'Question': question,
          'Stage' : sNumber,
          'Type':  typeQ,
          'World': wNumber,
          'qnid': qnID}
    );

    await FirebaseFirestore.instance
        .collection("QuestionDatabaseTest")
        .doc('q$qnID').collection("Answers").doc("Answers").set(
      {'choice 1' : answers[0],
        'choice 2' : answers[1],
        'choice 3' : answers[2],
        'choice 4' : answers[3],
      }
    );

  }

  /// This function inputs a t/f qn created
  Future<int> findMaxQnId() async {
    int maxQnID;
    await FirebaseFirestore.instance
        .collection("QuestionDatabase")
        .get()
        .then((documentSnapshot) {
        maxQnID = documentSnapshot.docs.length + 1;
    });
    return maxQnID;
  }

  /// This function gets the levels scores and append / totalScore to it
  Future<List<String>> getLevelsScores(String wName, String sName) async {
    List<String> levelScores = [];
    int totalScore = 10;
    await getAllLevelsHighscoreForStudent(wName, sName).then((highscore) {
      for (int i = 0; i < highscore.length; i++) {
        int individualLevelScore = highscore[i];
        levelScores.add('$individualLevelScore/$totalScore');
      }
    });
    return levelScores;
  }

  /// This function gets all the highscore for the levels within a stage
  Future<List<int>> getAllLevelsHighscoreForStudent(
      String worldName, String stageName) async {
    /// First check is to see if the user has unlocked the previous level
    /// User Highscore for each level
    List<int> studentHighscore = [];

    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .doc(stageName)
        .collection("Level")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((level) {
        try {
          studentHighscore.add(level.data()[userId]['HighScore']);
        } catch (e) {
          studentHighscore.add(0);
        }
      });
    });

    return studentHighscore;
  }

  /// this function gets the total score for that stage by summing all the levels score wihtin
  Future<int> totalScoreForStage(String worldName, String stageName) async {
    List<int> totalHighscores = [];
    totalHighscores =
        await getAllLevelsHighscoreForStudent(worldName, stageName);
    int sum = 0;
    for (int i = 0; i < totalHighscores.length; i++) {
      sum += totalHighscores[i];
    }
    return sum;
  }

  /// this function gets the total number of level access
  Future<int> getTotalAccessForLevels(
      String worldName, String stageNumber) async {
    int counterForTotalAccess = 0;
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .doc(stageNumber)
        .collection("Level")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((level) {
        bool check = false;
        try {
          check = level.data()['userAccess'].contains(userId);
          if (check) counterForTotalAccess++;
          if (counterForTotalAccess == 0) counterForTotalAccess = 1;
        } catch (e) {
          counterForTotalAccess = 1;
        }
      });
    });
    return counterForTotalAccess;
  }

  /// this function gets the total number of level access
  Future<bool> checkAccessForWorlds(String worldName) async {
    bool checkAccess = false;
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .get()
        .then((world) {
      try {
        checkAccess = world.data()['userAccess'].contains(userId);
      } catch (e) {}
    });
    return checkAccess;
  }

  /// this function gets the total number of stages access
  Future<int> getTotalAccessForStages(String worldName) async {
    int counterForTotalAccess = 0;
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((level) {
        bool check = false;
        try {
          check = level.data()['userAccess'].contains(userId);
          if (check) counterForTotalAccess++;
        } catch (e) {}
      });
    });
    return counterForTotalAccess;
  }

  /// this function gets the total number of stages access
  Future<int> getCharacterSelection() async {
    int characterChoice = 0;
    await FirebaseFirestore.instance
        .collection("users")
        .doc("Students")
        .collection("Students")
        .doc(userId)
        .get()
        .then((characterSelection) {
      characterChoice = characterSelection.data()['characterSelection'];
    });
    return characterChoice;
  }

  Future<int> test() async {
    int score = 0;

    return score;
  }

  /// This function returns the specific levels to be displayed
  Future<List<int>> getAllHighscoresForStudent(
      String worldName, String stageName) async {
    /// First check is to see if the user has unlocked the previous level

    /// User Highscore for each level
    List<Map<String, dynamic>> studentScore = [];
    List<int> studentHighscore = [];
    await FirebaseFirestore.instance
        .collection("worlds")
        .doc(worldName)
        .collection("Stage")
        .doc(stageName)
        .collection("Level")
        .get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((level) {
        studentScore.add(level.data()['score']);
      });
    });
    for (int i = 0; i < studentScore.length; i++) {
      Map<String, dynamic> temp = studentScore[i];
      temp.forEach((key, value) {
        if (key == userId) {
          studentHighscore.add(value);
        }
      });
    }
    return studentHighscore;
  }

  ///After change mcq answer, I have to change the way I check
  Future<List<String>> getListOfAccess(int userAns, int qnid) async {
    //load the question
    //parse user ans into string
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
  }
}
