import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ssadgame/Controller/ConfigurationManager.dart';
import 'package:ssadgame/Controller/customLevelsController.dart';
import 'GameCreatorPVP.dart';

class createLevel extends StatefulWidget {
  @override
  _createLevelState createState() => _createLevelState();
}

class _createLevelState extends State<createLevel> {
  customLevelsController cLController = customLevelsController.getInstance();
  ConfigurationManager configManager = ConfigurationManager.getInstance();
  String selected;
  String mcq;
  String open;
  String tru;
  String text =
      'Hey! I just challenged you to this game I created. See if you can beat my score. If you have not installed the app yet, go and download from https://github.com/AlvinTang81/CZ3003_Repo';
  String subject = 'Game invitation';
  double currentmcq = 1;
  double currenttf = 1;
  double currentopen = 1;
  String chosenValue;
  String levelname = '';
  final name = TextEditingController();
  List<String> temp = [];
  List<String> fullCategoryList = [];
  List<String> categorylist = [];
  int worldSelected;

  bool _showSpinner;

  @override
  void initState() {
    super.initState();
    initTest();
  }

  initTest() async {
    setState(() {
      _showSpinner = true;
    });
    temp = await configManager.getWorldName();
    fullCategoryList = await configManager.getWorldFName(temp);
    categorylist = [
      fullCategoryList[0].substring(9),
      fullCategoryList[1].substring(9),
      fullCategoryList[2].substring(9),
      fullCategoryList[3].substring(9),
      fullCategoryList[4].substring(9),
      fullCategoryList[5].substring(9),
    ];
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<String> doubleList =
        List<String>.generate(10, (int index) => '${index + 1}');
    List<DropdownMenuItem> menuItemList = doubleList
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();

    List<DropdownMenuItem> category = categorylist
        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
        .toList();
    bool _validatename = false;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "PvP Level Creator",
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    items: category,
                    hint: Text('Choose world for level', style: TextStyle()),
                    value: chosenValue,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                    onChanged: (value) => setState(() {
                      chosenValue = value;
                      for (int i = 0; i < fullCategoryList.length; i++) {
                        if (fullCategoryList[i].contains(value))
                          worldSelected = i + 1;
                      }
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            SizedBox(
              height: 625.0,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    Card(
                      child: TextFormField(
                        controller: name,
                        autocorrect: true,
                        decoration: new InputDecoration(
                          errorText:
                              _validatename ? 'Value Can\'t Be Empty' : null,
                          border: InputBorder.none,
                          hintText: 'Enter a name for this custom level',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Choose 10 Questions"),
                      ),
                    ),
                    Text('  MCQs',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                            fontFamily: 'Orbitron',
                            letterSpacing: 1.0)),
                    ListTile(
                      trailing: DropdownButton(
                        items: menuItemList,
                        value: mcq,
                        onChanged: (val) => setState(() => mcq = val),
                      ),
                      title: Text("Enter the number of MCQs"),
                    ),
                    Card(
                        child: ListTile(
                            title: Text(
                      'Enter the difficulty level of MCQ questions',
                    ))),
                    Slider(
                      value: currentmcq,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: currentmcq.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          currentmcq = value;
                        });
                      },
                    ),
                    Text('  True/False',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                            fontFamily: 'Orbitron',
                            letterSpacing: 1.0)),
                    Card(
                      child: ListTile(
                        trailing: DropdownButton(
                          items: menuItemList,
                          value: tru,
                          onChanged: (val) => setState(() => tru = val),
                        ),
                        title: Text("Enter the number of True/False Questions"),
                      ),
                    ),
                    Card(
                        child: ListTile(
                            title: Text(
                      'Enter the difficulty level of T/F questions',
                    ))),
                    Slider(
                      value: currenttf,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: currenttf.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          currenttf = value;
                        });
                      },
                    ),
                    Text('  Open-Ended',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                            fontFamily: 'Orbitron',
                            letterSpacing: 1.0)),
                    Card(
                      child: ListTile(
                        trailing: DropdownButton(
                          items: menuItemList,
                          value: open,
                          onChanged: (val) => setState(() => open = val),
                        ),
                        title: Text("Enter the number of Open-Ended Questions"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          'Enter the difficulty level of open-ended questions',
                        ),
                      ),
                    ),
                    Slider(
                      value: currentopen,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: currentopen.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          currentopen = value;
                        });
                      },
                    ),
                    RaisedButton(
                      onPressed: () async {
                        bool clash;
                        clash =
                            await cLController.savePVPConfigurationForStudent(
                                currentmcq.toInt(),
                                currentopen.toInt(),
                                currenttf.toInt(),
                                worldSelected,
                                int.parse(mcq),
                                int.parse(open),
                                int.parse(tru),
                                name.text);
                        if (!clash) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PVPGame(levelName: name.text),
                            ),
                          );
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
                      child: Text('Create Custom Level'),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(10.0),
                    ),
                  ],
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
