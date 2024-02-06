import 'package:flutter/material.dart';
import 'package:my_home_app/control_board_curtain/control_board_curtain.dart';
import 'control_board_fan/control_board_fan.dart';
import 'control_board_fan/control_board__fan_model.dart';

void main() {
  runApp(const MyApp());
}

final fanConfigs = <FanEntity>[
  const FanEntity(11, 3, false, false),
  const FanEntity(12, 3, false, true),
  const FanEntity(13, 6, false, false),
  const FanEntity(14, 3, false, false),
  const FanEntity(15, 6, true, true),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo'),
          ),
          body: _buildList(context),
        ));
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        ActionableTile(
            id: 11,
            title: "Living Room",
            iconPath: "assets/images/fan_w.png",
            fanEntity: fanConfigs[0]),
        ActionableTile(
            id: 12,
            title: "Dinning Room",
            iconPath: "assets/images/fan_w.png",
            fanEntity: fanConfigs[1]),
        ActionableTile(
            id: 13,
            title: "Master Bedroom",
            iconPath: "assets/images/fan_b.png",
            fanEntity: fanConfigs[2]),
        ActionableTile(
            id: 14,
            title: "Common Bedroom",
            iconPath: "assets/images/fan_b.png",
            fanEntity: fanConfigs[3]),
        ActionableTile(
            id: 15,
            title: "Study Room",
            iconPath: "assets/images/fan_round.png",
            fanEntity: fanConfigs[4]),
        const ActionableTile2(
            title: "Balcony",
            iconPath: "assets/images/curtain_blind.png"),
      ],
    );
  }
}

class ActionableTile extends StatelessWidget {
  const ActionableTile(
      {required this.id,
      required this.title,
      required this.iconPath,
      required this.fanEntity,
      Key? key})
      : super(key: key);

  final int id;
  final String title;
  final String iconPath;

  final FanEntity fanEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ControlBoard(),
                    settings: RouteSettings(
                        arguments: Todo(
                      title,
                      'This is a description',
                      fanEntity,
                    ))));
          },
          title: Text(title),
          leading: Image.asset(iconPath,
              height: 100, width: 100, fit: BoxFit.fitHeight),
        ));
  }
}

class ActionableTile2 extends StatelessWidget {
  const ActionableTile2({required this.title, required this.iconPath, Key? key})
      : super(key: key);

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: ListTile(
          onTap: () {
            // SnackBar snackBar = SnackBar(content: Text('$title , tapped'));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ControlBoardCurtain(),
                    ));
          },
          title: Text(title),
          leading: Image.asset(iconPath,
              height: 100, width: 100, fit: BoxFit.fitHeight),
        ));
  }
}
