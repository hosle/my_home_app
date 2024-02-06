import 'control_board__fan_model.dart';
import 'view_board_fan_light.dart';

class PresenterBoardLight {
  ViewBoardLight _view = ViewBoardLight();

  void onLightSwitchChanged(bool? isOn) {
    _view.notifyLightSwitchChanged(
        'Light is ${isOn == true ? 'on' : 'off'}', isOn);
  }

  void onLightModeSelected(Set<LightMode> modes) {
    _view.notifyLightModeSelected('Light has changed to ${modes.first}', modes);
  }

  set setView(ViewBoardLight view) => _view = view;
}

class PresenterBoardFan {
  ViewBoardFan _view = ViewBoardFan();

  void onFanSwitchChanged(bool? isOn) {
    _view.notifyFanSwitchChanged('Fan is ${isOn == true ? 'on' : 'off'}', isOn);
  }

  void onFanGearChanged(double gear) {
    _view.notifyFanGearChanged('Fan gear has changed to $gear', gear);
  }

  set setView(ViewBoardFan view) => _view = view;
}

class PresenterBoardFanExt {
  ViewBoardFanExt _view = ViewBoardFanExt();

  void onFanSwingOptionChanged(bool value) {
    _view.notifySwingStateChanged('Fan swing option is ${value ? 'on' : 'off'}', value);
  }

  void onFanReverseOptionChanged(bool value) {
    _view.notifyReverseStateChanged(
        'Fan reverse option is ${value ? 'Wind down' : 'Wind up'}', value);
  }

  set setView(ViewBoardFanExt viewBoardFanExt) => _view = viewBoardFanExt;
}
