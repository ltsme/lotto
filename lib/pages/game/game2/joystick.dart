import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game2/button.dart';
import 'package:lotto/pages/game/game2/game_engine.dart';

typedef MoveCallBack = void Function(int direction);

class JoyStick extends GameControl {
  final MoveCallBack onMove;

  JoyStick({required this.onMove});

  @override
  void onStart(Canvas canvas, Size size, int current) {
    // 좌 버튼 생성
    getGameControlGroup()?.addControl(
      Button(
          onDown: () {
            onMove(-1);
          },
          onUp: () {
            onMove(0);
          },
          direction: -1),
    );
    // 오른쪽 버튼 생성
    getGameControlGroup()?.addControl(
      Button(
          onDown: () {
            onMove(1);
          },
          onUp: () {
            onMove(0);
          },
          direction: 1),
    );
  }
}
