import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:ssadgame/Boundary_classes/LevelCreatorPVP.dart';
import 'package:ssadgame/Boundary_classes/PastAttemptsPage.dart';
import 'package:ssadgame/Boundary_classes/Teacher/Assignments_Teacher.dart';
import 'package:ssadgame/Boundary_classes/level_review.dart';

import 'Boundary_classes/ChallengePVP.dart';
import 'Boundary_classes/GameCreatorPVP.dart';
import 'Boundary_classes/LoginPage.dart';
import 'Boundary_classes/HomePage.dart';
import 'Boundary_classes/PVP.dart';
import 'Boundary_classes/Teacher/BestPerformingStagePage.dart';
import 'Boundary_classes/Teacher/BestPerformingWorldPage.dart';
import 'Boundary_classes/Teacher/CreateFITBPage.dart';
import 'Boundary_classes/Teacher/CreateMCQPage.dart';
import 'Boundary_classes/Teacher/CreateTFPage.dart';
import 'Boundary_classes/Teacher/LevelPage_Teacher.dart';
import 'Boundary_classes/Teacher/SelectQuestionPage.dart';
import 'Boundary_classes/Teacher/StagePage_Teacher.dart';
import 'Boundary_classes/Teacher/SummaryReportPage.dart';
import 'Boundary_classes/Teacher/WorstPerformingStagePage.dart';
import 'Boundary_classes/Teacher/WorstPerformingWorldPage.dart';
import 'Boundary_classes/TeacherAssignmentPage.dart';
import 'Boundary_classes/choices.dart';
import 'Boundary_classes/characterSelection.dart';
import 'Boundary_classes/WorldPage.dart';
import 'Boundary_classes/StagePage.dart';
import 'Boundary_classes/LevelPage.dart';
import 'Boundary_classes/AdventureLeaderBoardPage.dart';
import 'Boundary_classes/PvPLeaderBoardPage.dart';
import 'Boundary_classes/LevelLeaderBoardPage.dart';
import 'Boundary_classes/SummaryReportWorldPage.dart';
import 'Boundary_classes/SummaryReportLevelPage.dart';
import 'Boundary_classes/SummaryReportStagePage.dart';
import 'Boundary_classes/WorldQuizQuestion.dart';
import 'Boundary_classes/Teacher/HomePage_Teacher.dart';
import 'Boundary_classes/Teacher/WorldPage_Teacher.dart';

import 'game_engine/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Hides the Status bar
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/LoginPage', routes: {
      '/LoginPage': (context) => LoginPage(),
      '/HomePage': (context) => HomePage(),
      '/choices': (context) => GameMode(),
      '/characterSelection': (context) => CharacterSelection(),
      '/WorldPage': (context) => WorldPage(),
      '/StagePage': (context) => StagePage(),
      '/LevelPage': (context) => LevelPage(),
      '/game_engine/main': (context) => GameEngine(),
      '/AdventureLeaderBoardPage': (context) => AdventureLeaderBoardPage(),
      '/PvPLeaderBoardPage': (context) => PvPLeaderBoardPage(),
      '/LevelLeaderBoardPage': (context) => LevelLeaderBoardPage(),
      '/SummaryReportWorldPage': (context) => SummaryReportWorldPage(),
      '/SummaryReportStagePage': (context) => SummaryReportStagePage(),
      '/SummaryReportLevelPage': (context) => SummaryReportLevelPage(),
      '/PVP': (context) => PVPage(),
      '/LevelCreatorPVP': (context) => createLevel(),
      '/GameCreatorPVP': (context) => PVPGame(),
      '/ChallengePVP': (context) => ChallengeUI(),
      '/Teacher/HomePage_Teacher': (context) => HomePage_Teacher(),
      '/Teacher/Assignments_Teacher': (context) => assignmentTeacher(),
      '/Teacher/WorldPage_Teacher': (context) => WorldPage_Teacher(),
      '/Teacher/StagePage_Teacher': (context) => StagePage_Teacher(),
      '/Teacher/LevelPage_Teacher': (context) => LevelPage_Teacher(),
      '/Teacher/BestPerformingStages': (context) => BestPerformingStagePage(),
      '/Teacher/BestPerformingWorldPage': (context) =>
          BestPerformingWorldPage(),
      '/Teacher/SummaryReportPage': (context) => SummaryReportPage(),
      '/Teacher/BestPerformingStagePage': (context) =>
          BestPerformingStagePage(),
      '/Teacher/BestPerformingWorldPage': (context) =>
          BestPerformingWorldPage(),
      '/Teacher/WorstPerformingStagePage': (context) =>
          WorstPerformingStagePage(),
      '/Teacher/WorstPerformingWorldPage': (context) =>
          WorstPerformingWorldPage(),
      '/Teacher/CreateFITBPage': (context) => CreateFITBPage(),
      '/Teacher/CreateMCQPage': (context) => CreateMCQPage(),
      '/Teacher/CreateTFPage': (context) => CreateTFPage(),
      '/Teacher/SelectQuestionPage': (context) => SelectQuestionPage(),
      '/PastAttemptsPage': (context) => PastAttemptsPage(),
      '/level_reviewPage': (context) => level_review(),
      '/WorldQuiz': (context) => WorldQuizQuestion(),
      '/TeacherAssignmentPage':(context) => teacherAssignmentPage(),
    });
  }
}
