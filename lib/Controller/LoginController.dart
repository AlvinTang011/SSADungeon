import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginController{

  /// Singleton
  static LoginController single_instance = null;

  static LoginController getInstance()
  {
    if (single_instance == null)
      single_instance = new LoginController();

    return single_instance;
  }


  /// This function gets the student object in the database
  Future<Map<String, dynamic>> getStudentObject(String email, String password, String identifier) async {
    /// Get list of User objects
    Map<String, dynamic> userInfo = {};
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      String userId =
          FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(identifier).collection(identifier).doc(userId)
          .get()
          .then((documentSnapshot) {
        userInfo = (documentSnapshot.data());
      });
      return userInfo;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print(
            'Wrong password provided for that user.');
      }
    }
  }

  /// This function gets the teacher object in the database
  Future<Map<String, dynamic>> getTeacherObject(String email, String password, String identifier) async {
    Map<String, dynamic> teacherInfo = {};
    /// Get list of User objects
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      String teacherId =
          FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(identifier).collection(identifier).doc(teacherId)
          .get()
          .then((documentSnapshot) {
        teacherInfo = (documentSnapshot.data());
      });

    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print(
            'Wrong password provided for that user.');
      }
    }
  }


}

class Teacher {
  String _tID;
  static final Teacher _inst = new Teacher._internal();

  Teacher._internal();
  factory Teacher(
      String _tID,
      )
  {
    _inst._tID = _tID;

    return _inst;
  }

  String get tID => _tID;

  /// This function is a setter for the local variable emailAddress
  set tID(String value) {
    _tID = value;
  }


}

class Student {
  String _sID;
  String _advScore;
  String _name;

  static final Student _inst = new Student._internal();

  Student._internal();
  factory Student(
      String _sID,
      String _advScore,
      String _name
      )
  {
    _inst._sID = _sID;
    _inst._advScore = _advScore;
    _inst._name = _name;

    return _inst;
  }

  String get sID => _sID;

  /// This function is a setter for the local variable emailAddress
  set sID(String value) {
    _sID = value;
  }

  String get advScore => _advScore;

  /// This function is a setter for the local variable emailAddress
  set advScore(String value) {
    _advScore = value;
  }

  String get name => _name;

  /// This function is a setter for the local variable emailAddress
  set name(String value) {
    _name = value;
  }


}