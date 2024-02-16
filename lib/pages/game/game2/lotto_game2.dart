import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game2/asteroids.dart';
import 'package:lotto/pages/game/game2/game_engine.dart';
import 'package:lotto/pages/game/game2/joystick.dart';
import 'package:lotto/pages/game/game2/ship.dart';

class LottoGameTwo extends StatelessWidget {
  LottoGameTwo({super.key}) {
    _joystick = JoyStick(onMove: (direction) => {_ship.move(direction)});

    _ship = Ship();

    _asterois = Asteroids(onCheckCollison: (GameControl target) {
      return _ship.checkCollisionAndExplode(target);
    });

    _gameEngine.getControls().addControl(_joystick);
    _gameEngine.getControls().addControl(_ship);
    _gameEngine.getControls().addControl(_asterois);
    _gameEngine.start();
  }
  final _gameEngine = GameEngine();
  late final _joystick;
  late final _ship;
  late final _asterois;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _gameEngine.getCustomPaint(),
      ),
    );
  }
}
