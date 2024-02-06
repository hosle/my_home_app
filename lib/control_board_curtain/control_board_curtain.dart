import 'package:flutter/material.dart';
import 'package:my_home_app/control_board_curtain/view_board_curtain.dart';
import 'control_board_curtain_model.dart';
import 'presenter_board_curtain.dart';

class ControlBoardCurtain extends StatelessWidget {
  const ControlBoardCurtain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curtain Control Board')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: ControlPanel(),
      ),
    );
  }
}

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ControlPanelState();
  }
}


const paddingVerticalValue = 10.0;

class _ControlPanelState extends State<ControlPanel> implements ViewBoardCurtain {
  Set<Piece> selection = <Piece>{Piece.front};

  final _presenter = PresenterBoardCurtain();
  
  @override
  void initState() {
    super.initState();
    _presenter.setView = this;
  }

  @override
  void notifyCurtainSelectionChanged(String result, Set<Piece> newSelection) {
    setState(() {
      selection = newSelection;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child: SizedBox()),
        const Padding(
          padding: EdgeInsets.only(bottom: paddingVerticalValue),
          child: Text('This is Description'),
        ),
        SegmentedButton<Piece>(
          segments: const <ButtonSegment<Piece>>[
            ButtonSegment<Piece>(
                value: Piece.front,
                label: Text('Front'),
                icon: Icon(Icons.circle_outlined)),
            ButtonSegment<Piece>(
                value: Piece.side,
                label: Text('Side'),
                icon: Icon(Icons.circle_outlined)),
            ButtonSegment<Piece>(
                value: Piece.both,
                label: Text('Both'),
                icon: Icon(Icons.circle_outlined))
          ],
          selected: selection,
          onSelectionChanged: (Set<Piece> newSelection) => _presenter.onCurtainSelectionChanged(newSelection),
          style: FilledButton.styleFrom(
            fixedSize: const Size(250, 80),
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
              top: paddingVerticalValue * 3, bottom: paddingVerticalValue),
          child: Divider(),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: paddingVerticalValue * 2),
            child: _buildButton('Up', Icons.arrow_upward, _presenter.onCurtainUpClicked)),
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: paddingVerticalValue * 2),
            child: _buildButton('Stop', Icons.stop_rounded, _presenter.onCurtainStopClicked)),
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: paddingVerticalValue * 2),
            child: _buildButton('Down', Icons.arrow_downward, _presenter.onCurtainDownClicked)),
        const Expanded(flex: 3, child: SizedBox()),
      ],
    );
  }

  Widget _buildButton(String content, IconData icon, Function onClickCallback) {
    return ElevatedButton.icon(
      onPressed: () => onClickCallback(),
      icon: Icon(icon),
      label: Text(content),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 60),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
