import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class customLevelsController {
  /// Singleton
  static customLevelsController single_instance = null;

  static customLevelsController getInstance() {
    if (single_instance == null) single_instance = new customLevelsController();

    return single_instance;
  }

  String userId = FirebaseAuth.instance.currentUser.uid;


  /// saves the user input
  Future<bool> savePVPConfigurationForStudent(int mcqDifficulty, int OEDifficulty, int TFDifficulty,
      int worldSelected, int noOfMCQ, int noOfOE, int noOfTF, String createdLevelName) async {

    int currentRating = 0;
    bool documentExist = false;
    /// Check if document already exist
    await FirebaseFirestore.instance.collection("CustomLevelsTest").get()
        .then((documentSnapshot) {
          documentSnapshot.docs.forEach((levelName){
            if (levelName.id == createdLevelName) documentExist = true;
          });
    });

    /// after checking if document does not clash, create the new level
    if(!documentExist) {
      await FirebaseFirestore.instance
          .collection("CustomLevelsTest")
          .doc(createdLevelName).set(
          {
            'mcqDifficulty ': mcqDifficulty,
            'numMCQ': noOfMCQ,
            'numOE': noOfOE,
            'numTF' : noOfTF,
            'oeDifficulty':  OEDifficulty,
            'rating': currentRating,
            'tfDifficulty': TFDifficulty,
            'worldSelected': worldSelected
          }
      );
    }
    /// return type bool to inform user if document clash or not
    return documentExist;
  }

  /// This function gives the student of that tutorial group access to the assignment
  void giveAccessToTutorialGroup(String levelName, String tutorialGroupNum) async {
    await FirebaseFirestore.instance.collection('CustomLevelsTest').doc(levelName).update(
        {
      'Tutorial group': tutorialGroupNum,
    }
    );

  }

  /// This function checks if there is a teacher assignment
  Future<List<String>> checkTeacherAssignment() async {
    String tutorialGroupUser;

    tutorialGroupUser = await FirebaseFirestore.instance
        .collection("users")
        .doc('Students').collection('Students').doc(userId).get().then((user) {
      return user.data()['Tutorial group'];
    });

    List<String> teacherAssignedLevels = [];
    await FirebaseFirestore.instance.collection('CustomLevelsTest')
        .get().then((documentSnapshot) {
      documentSnapshot.docs.forEach((levelCreated){
        if (levelCreated.data()['Tutorial group'] == tutorialGroupUser)
          teacherAssignedLevels.add(levelCreated.id);
      });
    });

    return(teacherAssignedLevels);

  }


}