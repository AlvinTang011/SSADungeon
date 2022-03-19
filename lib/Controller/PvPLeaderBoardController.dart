import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'LevelLeaderBoardController.dart';

class PvPLeaderBoardController extends SearchDelegate<LevelInfo> {
  static final PvPLeaderBoardController _pleaderBoardController =
      PvPLeaderBoardController._internal();

  factory PvPLeaderBoardController() {
    return _pleaderBoardController;
  }

  PvPLeaderBoardController._internal();

  List<LevelInfo> levelList;

  LevelInfo chosenLevel;

  /// This function gets all the list of created levels
  Future<List<LevelInfo>> loadLevelInfo() async {
    levelList = [];
    await FirebaseFirestore.instance
        .collection("CustomLevels")
        .get()
        .then((levels) {
      levels.docs.forEach((level) {
        if(level.data()["ratings"] ==null){

        }
        else{
          int rating = level.data()["ratings"];
          String name = level.id;
          String creator = "Student";
          levelList.add(
              LevelInfo(title: name, nameOfCreator: creator, ratings: rating));
        }

      });
    });
    this.levelList = levelList;
    return levelList;
  }

  /// itemCount for list builder
  int itemCount() {
    if (levelList.length > 50) {
      return 50;
    }
    return levelList.length;
  }

  /// Search bar stuff
  @override
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

  List<LevelInfo> levelListTemp = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    levelListTemp = query.isEmpty
        ? levelList
        : levelList.where((p) => p.title.contains(query)).toList();
    return levelListTemp.isEmpty
        ? Text(
            "No Results Found...",
            style: TextStyle(fontSize: 20, fontFamily: 'Orbitron'),
          )
        : ListView.builder(
            itemCount: levelListTemp.length,
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 235,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                            child: Text(
                                (index + 1).toString() +
                                    ". " +
                                    levelListTemp[index].title,
                                style: TextStyle(fontFamily: 'Orbitron')),
                            onTap: () {
                              LevelLeaderBoardController()
                                  .setSelectedLevel(levelList[index].title);
                              Navigator.popAndPushNamed(
                                  context, '/LevelLeaderBoardPage');
                            }),
                      ),
                      Container(
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(levelListTemp[index].ratings.toString(),
                            style: TextStyle(fontFamily: 'Orbitron')),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_sharp, size: 30),
                            onPressed: () {
                            },
                          ),
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
    List<LevelInfo> levelListTemp = [];
    levelListTemp = query.isEmpty
        ? levelList
        : levelList.where((p) => p.title.contains(query)).toList();
    return levelListTemp.isEmpty
        ? Text(
            "No Results Found...",
            style: TextStyle(fontSize: 20),
          )
        : ListView.builder(
            itemCount: levelListTemp.length,
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 235,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                            child: Text(
                                (index + 1).toString() +
                                    ". " +
                                    levelListTemp[index].title,
                                style: TextStyle(fontFamily: 'Orbitron')),
                            onTap: () {
                              LevelLeaderBoardController()
                                  .setSelectedLevel(levelListTemp[index].title);
                              Navigator.popAndPushNamed(
                                  context, '/LevelLeaderBoardPage');
                            }),
                      ),
                      Container(
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                            levelListTemp[index].ratings.toStringAsFixed(2),
                            style: TextStyle(fontFamily: 'Orbitron')),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_sharp, size: 30),
                            onPressed: () {
                            },
                          ),
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

class LevelInfo {
  final String title;
  final String nameOfCreator;
  final int ratings;

  LevelInfo({
    this.title,
    this.nameOfCreator,
    this.ratings,
  });
}
