import 'control_board__fan_model.dart';

class ViewBoardLight{
  void notifyLightSwitchChanged(String result, bool? newValue){}

  void notifyLightModeSelected(String result, Set<LightMode> newSelection){}
}

class ViewBoardFan{
  void notifyFanSwitchChanged(String result, bool? newValue){}

  void notifyFanGearChanged(String result, double gear){}
}


class ViewBoardFanExt{
  void notifySwingStateChanged(String result, bool newValue){}

  void notifyReverseStateChanged(String result, bool newValue){}
}