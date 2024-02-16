import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game2/game_engine.dart';

const double BUTTON_SIZE = 60.0;

typedef NotificationCallback = void Function();

class Button extends GameControl {
  final NotificationCallback onDown;
  final NotificationCallback onUp;
  final int direction;

  Button({required this.onDown, required this.onUp, required this.direction});

  @override
  void onStart(Canvas canvas, Size size, int current) {
    width = BUTTON_SIZE;
    height = BUTTON_SIZE;
    y = size.height - (BUTTON_SIZE * 2);
    switch (direction) {
      case -1:
        x = 20;
        break;
      case 1:
        x = size.width - width * 2;
    }

    paint.color = Colors.grey.withOpacity(0.1);
  }

  @override
  void onHorizontalDragStart(DragStartDetails details) {
    onDown();
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    onUp();
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    const radius = BUTTON_SIZE / 2;
    canvas.drawCircle(Offset(x + radius, y + radius), radius, paint);
  }
}
