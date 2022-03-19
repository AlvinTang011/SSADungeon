import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdventureLeaderBoardController extends SearchDelegate<StudentInfo> {
  String userID = FirebaseAuth.instance.currentUser.uid;
  StudentInfo myStudentInfo;
  List<StudentInfo> studentList;

  static final AdventureLeaderBoardController _adventureleaderBoardController =
      AdventureLeaderBoardController._internal();

  factory AdventureLeaderBoardController() {
    return _adventureleaderBoardController;
  }

  AdventureLeaderBoardController._internal();

  /// This function gets all the list of students
  Future<List<StudentInfo>> loadStudentInfo() async {
    studentList = [];

    await FirebaseFirestore.instance
        .collection("users")
        .doc("Students")
        .collection("Students")
        .get()
        .then((students) {
      students.docs.forEach((student) {
        int score = student.data()["adv score"];
        try {
          String name = student.data()["name"];
          String id = student.id;
          studentList.add(StudentInfo(name: name, score: score, studentID: id));
        } catch (e) {}
      });
    });

    for (int i = 0; i < studentList.length; i++) {
      if (studentList[i].studentID == userID) {
        myStudentInfo = studentList[i];
      }
    }
    this.studentList = studentList;
    return studentList;
  }

  /// Get method to get my Info
  StudentInfo myInfo() {
    return myStudentInfo;
  }

  /// Find your position
  int myPosition() {
    return 1;
  }

  /// itemCount for list builder
  int itemCount() {
    if (studentList.length > 50) {
      return 50;
    }
    return studentList.length;
  }

  /// This function sorts the student
  List<StudentInfo> sortStudent(List<StudentInfo> studentList) {
    StudentInfo temp;
    for (int i = 0; i < studentList.length; i++) {
      for (int j = i + 1; j < studentList.length; j++) {
        try {
          if (studentList[i].score < studentList[j].score) {
            temp = studentList[i];
            studentList[i] = studentList[j];
            studentList[j] = temp;
          }
        } catch (e) {}
      }
    }
    return studentList;
  }

  /// Search Bar
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  List<StudentInfo> studentListTemp = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    /// If nothing in textbox, display everything, else only those that start with what is typed in textbox
    studentListTemp = query.isEmpty
        ? studentList
        : studentList.where((p) => p.studentID.contains(query)).toList();
    return studentListTemp.isEmpty
        ? Text(
            "No Results Found...",
            style: TextStyle(fontSize: 20),
          )
        : ListView.builder(
            itemCount: studentListTemp.length,
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Text((index + 1).toString() + ".",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Orbitron')),
                            Text("   "), //Padding
                            Icon(Icons.face, size: 65),
                            Text("  "), //Padding
                            Text(studentListTemp[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Orbitron')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(studentListTemp[index].score.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Orbitron')),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget buildResults(BuildContext context) {
    studentListTemp = query.isEmpty
        ? studentList
        : studentList.where((p) => p.name.contains(query)).toList();
    return studentListTemp.isEmpty
        ? Text(
            "No Results Found...",
            style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
          )
        : ListView.builder(
            itemCount: studentListTemp.length,
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Text((index + 1).toString() + ".",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Orbitron')),
                            Text("   "), //Padding
                            Icon(Icons.face, size: 65),
                            Text("  "), //Padding
                            Text(studentListTemp[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Orbitron')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(studentListTemp[index].score.toString(),
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class StudentInfo {
  final String name;
  final int score;
  final String studentID;

  StudentInfo({this.name, this.score, this.studentID});
}
