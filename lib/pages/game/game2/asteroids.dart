import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game2/game_engine.dart';

const double ASTER_SIZE = 30.0;
typedef CheckCollisionCallback = bool Function(GameControl target);

class Asteroids extends GameControl {
  var _term = 0;
  var _random = Random();

  final CheckCollisionCallback onCheckCollison;
  Asteroids({required this.onCheckCollison});

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    _term = _term + term;
    while (_term >= 500) {
      _term = _term - 500;
      _createAsteroid(size);
    }
  }

  void _createAsteroid(Size size) {
    var _x = _random.nextDouble() * (size.width - 30);
    getGameControlGroup()?.addControl(Asteroid(_x, 0, onCheckCollison));
  }
}

class Asteroid extends GameControl {
  Asteroid(double ax, double ay, CheckCollisionCallback onCheckCollision) {
    x = ax;
    y = ay;
    width = ASTER_SIZE;
    height = ASTER_SIZE;
    paint.color = Colors.red;
    _onCheckCollision = onCheckCollision;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    y = y + 2;
    if (y > size.height) deleted = true;

    if (_onCheckCollision(this)) deleted = true;
    const radius = ASTER_SIZE / 2;
    canvas.drawCircle(Offset(x + radius, y + radius), radius, paint);
  }

  late CheckCollisionCallback _onCheckCollision;
}
