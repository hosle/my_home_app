import 'package:flutter/material.dart';
import 'package:my_home_app/control_board_fan/presenter_board_fan_light.dart';
import 'package:my_home_app/control_board_fan/view_board_fan_light.dart';
import 'control_board__fan_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

const paddingVertical = 10.0;

class ControlBoard extends StatelessWidget {
  const ControlBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    final fanEntity = todo.fanEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(todo.description),
              const LightViewGroup(),
              const Padding(
                padding: EdgeInsets.only(
                    top: paddingVertical * 3, bottom: paddingVertical),
                child: Divider(),
              ),
              FanViewGroup(
                fanEntity: fanEntity,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: paddingVertical),
                child: Divider(),
              ),
              FanExtViewGroup(fanEntity: fanEntity),
            ],
          )),
    );
  }
}


class LightViewGroup extends StatefulWidget {
  const LightViewGroup({super.key});

  @override
  State<LightViewGroup> createState() => _LightViewGroupState();
}

class _LightViewGroupState extends State<LightViewGroup>
    implements ViewBoardLight {
  LightMode currentLightMode = LightMode.warm;
  bool _switchValue = false;

  final _presenter = PresenterBoardLight();

  @override
  void initState() {
    super.initState();
    _presenter.setView = this;
  }

  @override
  void notifyLightSwitchChanged(String result, bool? newValue) {
    setState(() {
      _switchValue = newValue ?? false;
      if (newValue == false) {
        currentLightMode = LightMode.values.first;
      }
    });
  }

  @override
  void notifyLightModeSelected(String result, Set<LightMode> newSelection) {
    setState(() {
      currentLightMode = newSelection.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: const Text('Light'),
            trailing: CupertinoSwitch(
                // This bool value toggles the switch.
                value: _switchValue,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (bool? value) =>
                    _presenter.onLightSwitchChanged(value))),
        SegmentedButton<LightMode>(
          segments: const <ButtonSegment<LightMode>>[
            ButtonSegment<LightMode>(
                value: LightMode.warm,
                label: Text('Warm'),
                icon: Icon(Icons.lightbulb_outline)),
            ButtonSegment<LightMode>(
                value: LightMode.warmWhite,
                label: Text('Warm White'),
                icon: Icon(Icons.lightbulb_outline)),
            ButtonSegment<LightMode>(
                value: LightMode.white,
                label: Text('White'),
                icon: Icon(Icons.lightbulb_outline)),
          ],
          selected: <LightMode>{currentLightMode},
          style: FilledButton.styleFrom(),
          onSelectionChanged: !_switchValue
              ? null
              : (Set<LightMode> newSelection) => _presenter.onLightModeSelected(newSelection),
        )
      ],
    );
  }
}


class FanViewGroup extends StatefulWidget {
  const FanViewGroup({required this.fanEntity, Key? key})
      : super(key: key);
  final FanEntity fanEntity;

  @override
  State<StatefulWidget> createState() {
    return _FanViewGroupState();
  }
}

class _FanViewGroupState extends State<FanViewGroup> implements ViewBoardFan {
  bool _switchValue = false;
  double _currentSliderValue = 0;
  String? _sliderStatus;

  final _presenter = PresenterBoardFan();

  @override
  void notifyFanSwitchChanged(String result, bool? newValue) {
    setState(() {
      _switchValue = newValue ?? false;
      if (newValue == false) {
        _currentSliderValue = 0;
      }
    });
  }

  @override
  void notifyFanGearChanged(String result, double gear) {
    setState(() {
      _currentSliderValue = gear;
    });
  }

  @override
  void initState() {
    super.initState();
    _presenter.setView = this;
  }

  @override
  Widget build(BuildContext context) {
    // developer.log('divisionValue xx: ${divisionValue}');
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
            title: const Text('Fan'),
            trailing: CupertinoSwitch(
                // This bool value toggles the switch.
                value: _switchValue,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (bool? value) => _presenter.onFanSwitchChanged(value))),
        Text('$_currentSliderValue'),
        SizedBox(
          width: double.infinity,
          child: Slider(
            key: const Key('slider'),

            value: _currentSliderValue,
            // This allows the slider to jump between divisions.
            // If null, the slide movement is continuous.
            divisions: widget.fanEntity.gearLevel - 1,
            // The maximum slider value
            min: 0,
            max: 100,
            activeColor: CupertinoColors.systemPurple,
            thumbColor: CupertinoColors.systemPurple,
            // This is called when sliding is started.
            onChangeStart: (double value) {
              setState(() {
                _sliderStatus = 'Sliding';
              });
            },
            // This is called when sliding has ended.
            onChangeEnd: (double value) {
              setState(() {
                _sliderStatus = 'Finished sliding';
              });
            },
            // This is called when slider value is changed.
            onChanged: !_switchValue
                ? null
                : (double value) => _presenter.onFanGearChanged(value),
          ),
        ),
        Text(
          _sliderStatus ?? '',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}

class FanExtViewGroup extends StatefulWidget {
  const FanExtViewGroup({required this.fanEntity, Key? key}) : super(key: key);

  final FanEntity fanEntity;

  @override
  State<StatefulWidget> createState() {
    return _FanExtViewGroupState();
  }
}

class _FanExtViewGroupState extends State<FanExtViewGroup> implements ViewBoardFanExt {
  bool _swingHead = false;
  bool _windDown = true;

  final _presenter = PresenterBoardFanExt();

  @override
  void notifySwingStateChanged(String result, bool newValue) {
    setState(() {
      _swingHead = newValue;
    });
  }

  @override
  void notifyReverseStateChanged(String result, bool newValue) {
    setState(() {
      _windDown = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _presenter.setView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: widget.fanEntity.enableSwingHead,
          child: ListTile(
            title: const Text('Swing Head'),
            trailing: CupertinoSwitch(
              value: _swingHead,
              activeColor: CupertinoColors.activeBlue,
              onChanged: (bool value) => _presenter.onFanSwingOptionChanged(value),
            ),
          ),
        ),
        Visibility(
          visible: widget.fanEntity.enableSwingHead,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: paddingVertical),
            child: Divider(),
          ),
        ),
        Visibility(
          visible: widget.fanEntity.enableReverseFan,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Wind Up', textScaleFactor: 1.1),
              CupertinoSwitch(
                  value: _windDown,
                  trackColor: CupertinoColors.activeGreen,
                  activeColor: CupertinoColors.activeBlue,
                  onChanged: (bool value) =>
                    _presenter.onFanReverseOptionChanged(value)),
              const Text('Wind Down', textScaleFactor: 1.1)
            ],
          ),
        )
      ],
    );
  }
}
