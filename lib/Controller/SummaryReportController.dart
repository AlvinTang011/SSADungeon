class SummaryReportController{

  static final SummaryReportController _summaryReportController = SummaryReportController._internal();

  factory SummaryReportController(){
    return _summaryReportController;
  }

  SummaryReportController._internal();

  String selectedStage = "";
  String selectedLevel = "";

  /// This function set the selected stage
  void setSelectedStage(String stage){
    this.selectedStage = stage;
  }

  /// This function gets the selected stage
  String getSelectedStage(){
    return selectedStage;
  }

  /// This function set the selected level
  void setSelectedLevel(String level){
    this.selectedLevel = level;
  }

  /// This function get the selected level
  String getSelectedLevel(){
    return selectedLevel;
  }
}