class WorldController{
  List<int> selectedWorld = [0,0,0,0,0,0];

  static final WorldController _summaryReportController = WorldController._internal();

  factory WorldController(){
    return _summaryReportController;
  }

  WorldController._internal();

  /// This function updates the selected world
  void updateSelect(int position){
    if(selectedWorld[position] == 0){
      selectedWorld[position] = 1;
    }
    else{
      selectedWorld[position] = 0;
    }
  }
}