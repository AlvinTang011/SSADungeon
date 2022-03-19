import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/customLevelsController.dart';
import 'package:ssadgame/game_engine/PVPMain.dart';


class ChallengeUI extends StatefulWidget {
  @override
  _ChallengeUIState createState() => _ChallengeUIState();
}

class _ChallengeUIState extends State<ChallengeUI> {
  customLevelsController cLController = customLevelsController.getInstance();
  String challenge;
  final levelname = TextEditingController();
  List<CustomLevels> collatedLevels = [];


  void onSubmit() {
  }

  @override
  void initState() {
    super.initState();
    initTest();
  }


  initTest() async {
    /// query all the levels
    collatedLevels = await getAllCustomLevels();
    setState(() {
    });
  }

  Future<List<CustomLevels>> getAllCustomLevels() async {
    List<CustomLevels> temp = [];

    await FirebaseFirestore.instance.collection("CustomLevels").get()
        .then((documentSnapshot) {
      documentSnapshot.docs.forEach((levelName){
        int tempMCQDif = levelName.data()['mcqDifficulty'];
        int tempMCQNum = levelName.data()['numMCQ'];
        int tempOENum = levelName.data()['numOE'];
        int tempTFNum = levelName.data()['numTF'];
        int tempOEDif = levelName.data()['oeDifficulty'];
        int tempRating = levelName.data()['rating'];
        int tempTFDiff = levelName.data()['tfDifficulty'];
        int tempWS = levelName.data()['worldSelected'];
        String tempLN = levelName.id;


        CustomLevels temp1 = CustomLevels(tempMCQNum, tempOENum, tempTFNum, tempOEDif, tempMCQDif,
            tempTFDiff, tempRating, tempWS, tempLN);

        temp.add(temp1);
      });

    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Challenge",
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/PvPage');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:30),
              ),
              Text(
                'Created Levels',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Orbitron',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 10.0, color: Colors.grey[400]),
                )),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container (
                height: 400,
                child: new ListView.builder(
                  itemCount: collatedLevels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      height: 100,
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PVPMain(
                                customlevels: collatedLevels[index],
                              ),
                            ),
                          );
                        }, //Need to link to the next page
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  collatedLevels[index].levelName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    fontFamily: 'Orbitron',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.blueGrey[200],
                        shape: new RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLevels {
  int numMcq;
  int numOE;
  int numTF;
  int oeDifficulty;
  int mcqDifficulty;
  int tfDifficulty;
  int rating;
  int worldNum;
  String levelName;

  CustomLevels (
      int numMcq, int numOE, int numTF, int oeDifficulty,
      int mcqDifficulty, int tfDifficulty, int rating, int worldSelected, String levelName
      ) {
    this.numTF = numTF;
    this.numMcq = numMcq;
    this.numOE = numOE;
    this.oeDifficulty = oeDifficulty;
    this.mcqDifficulty = mcqDifficulty;
    this.tfDifficulty = tfDifficulty;
    this.rating = rating;
    this.worldNum = worldSelected;
    this.levelName = levelName;
  }

}