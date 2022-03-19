abstract class DataInterface {
  int getQuestionType();
  String getScoreFormat();
  Future<int> getMcqQuestion();
  Future<int> getTFQuestion();
  Future<int> getOEQuestion();
  void updateScoreCorrectAnswer(int qnID);
  int getTotalQuestions();
  void updateTotal(int qnID);
  Map<String, bool> getStudentAttempt();
  String getWorldName();
  int getStage();
  int getLevel();
  String getLevelName();
  int getScore();
}
