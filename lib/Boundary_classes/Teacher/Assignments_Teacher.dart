import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Boundary_classes/Teacher/assignmentShare.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:ssadgame/Controller/customLevelsController.dart';


class assignmentTeacher extends StatefulWidget {
  @override
  _assignmentTeacherState createState() => _assignmentTeacherState();
}

class _assignmentTeacherState extends State<assignmentTeacher> {

  String chosentut;
  String chosenWorld;
  String chosenStage;
  String chosenLevel;

  String numMCQ;
  String numTF;
  String numOE;

  int totalNumberLeft = 10;
  final name = TextEditingController();


  String worldName;
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  customLevelsController cLController = customLevelsController.getInstance();
  List<String> tempWN = [];
  List<String> fullCategoryList = [];
  List<String> category = [];
  List<String> stage = [];
  List<String> level = [];


  @override
  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {

    tempWN = await configManager.getWorldName();
    fullCategoryList = await configManager.getWorldFName(tempWN);
    category = [
      fullCategoryList[0].substring(9),
      fullCategoryList[1].substring(9),
      fullCategoryList[2].substring(9),
      fullCategoryList[3].substring(9),
      fullCategoryList[4].substring(9),
      fullCategoryList[5].substring(9),
    ];


  }


  @override
  Widget build(BuildContext context) {


    List<String> stage = ['Stage 1', 'Stage 2', 'Stage 3', 'Stage 4', 'Stage 5'];
    List<String> level = [
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
      'Level 5'
    ];

    List<String> doubleList =
    List<String>.generate(totalNumberLeft, (int index) => '${index + 1}');
    List<DropdownMenuItem> menuItemList = doubleList
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();



    List<DropdownMenuItem> stagelist = stage
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();


    List<DropdownMenuItem> levelist = level
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();

    List<String> tutorialgroup = ['T1', 'T2', 'T3'];
    List<DropdownMenuItem> tutcategory = tutorialgroup
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();
    List<DropdownMenuItem> categorylist = category
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();

    bool _validatename = false;

    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[100],
            toolbarHeight: 60,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/Teacher/HomePage_Teacher');
              },
            ),
            centerTitle: true,
            title: Text(
              "Assignment",
              style: TextStyle(
                  color: Colors.black, fontSize: 24, fontFamily: 'Orbitron'),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Icon(
                  Icons.description,
                  color: Colors.blueGrey,
                  size: 50,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: Container(
                    child: Center(
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          'Create your assignment.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Orbitron',
                            color: Colors.blueGrey,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, .5),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ],
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: name,
                    autocorrect: true,
                    decoration: new InputDecoration(
                      errorText:
                      _validatename
                          ? 'Value Can\'t Be Empty'
                          : null,
                      border: InputBorder.none,
                      hintText: 'Enter a name for this custom level',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: tutcategory,
                      dropdownColor: Colors.blueGrey,
                      hint: Text("Tutorial Group"),
                      value: chosentut,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() {
                        chosentut = val;
                      }),
                    ),
                    title: Text("Choose tutorial group",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: categorylist,
                      dropdownColor: Colors.blueGrey,
                      hint: Text("World"),
                      value: chosenWorld,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() {
                        chosenWorld = val;
                        /// get the stages for that world only

                        for(int i = 0; i<fullCategoryList.length; i++) {
                          if (fullCategoryList[i].contains(val)) {
                            worldName = fullCategoryList[i];
                          }
                        }
                        setState(() {
                        });
                      }),
                    ),
                    title: Text("Choose World for assignment",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: stagelist,
                      hint: Text('Stage'),
                      dropdownColor: Colors.blueGrey,
                      value: chosenStage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() {
                        chosenStage = val;
                      }),
                    ),
                    title: Text("Choose Stage for assignment",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: levelist,
                      hint: Text('Level'),
                      dropdownColor: Colors.blueGrey,
                      value: chosenLevel,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() {
                        chosenLevel = val;
                      }),
                    ),
                    title: Text("Choose Level for assignment",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 10.0, color: Colors.blueGrey),
                      )),
                  child: Text('MCQs',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          fontFamily: 'Orbitron',
                          letterSpacing: 1.0)),
                ),


                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: menuItemList,
                      dropdownColor: Colors.blueGrey,
                      value: numMCQ,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() {
                        numMCQ = val;
                      }),
                    ),
                    title: Text("Select number of MCQ",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 10.0, color: Colors.blueGrey),
                      )),
                  child: Text('True/False Questions',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Orbitron',
                          fontSize: 21.0,
                          letterSpacing: 1.0)),
                ),

                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: menuItemList,
                      dropdownColor: Colors.blueGrey,
                      value: numTF,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() => numTF = val),
                    ),
                    title: Text("Select number of T/F",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 10.0, color: Colors.blueGrey),
                      )),
                  child: Text('Open-Ended Questions',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Orbitron',
                          fontSize: 21.0,
                          letterSpacing: 1.0)),
                ),
                Card(
                  child: ListTile(
                    trailing: DropdownButton(
                      items: menuItemList,
                      dropdownColor: Colors.blueGrey,
                      value: numOE,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      onChanged: (val) => setState(() => numOE = val),
                    ),
                    title: Text("Select number of Open Ended",
                        style: TextStyle(fontSize: 19.0)),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () async {
                    bool clash = true;
                    clash = await cLController
                        .savePVPConfigurationForStudent(
                        int.parse('${chosenLevel[6]}'),
                        int.parse('${chosenLevel[6]}'),
                        int.parse('${chosenLevel[6]}'),
                        int.parse('${worldName[6]}'),
                        int.parse(numMCQ),
                        int.parse(numOE),
                        int.parse(numTF),
                        name.text);

                    cLController.giveAccessToTutorialGroup(name.text, chosentut);
                    if (!clash) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => shareAssignment()));

                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text(
                                  "Name already exist, please input a new level name"),
                              actions: [
                                TextButton(
                                  child: Text("Okay"),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Text('Create Custom Level',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(10.0),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        );
  }
}


