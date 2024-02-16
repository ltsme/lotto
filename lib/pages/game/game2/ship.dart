import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game2/game_engine.dart';

const double SHIP_SIZE = 60.0;

class Ship extends GameControl {
  void move(int direction) {
    _direction = direction;
  }

  bool checkCollisionAndExplode(GameControl target) {
    var result = checkCollision(target);
    if (result) deleted = true;
    return result;
  }

  @override
  void onStart(Canvas canvas, Size size, int current) {
    width = SHIP_SIZE;
    height = SHIP_SIZE;
    x = (size.width - width) / 2;
    y = size.height - (SHIP_SIZE * 2);
    paint.color = Colors.blue;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    x = x + _direction;
    const radius = SHIP_SIZE / 2;
    canvas.drawCircle(Offset(x + radius, y + radius), radius, paint);
  }

  int _direction = 0;
}
