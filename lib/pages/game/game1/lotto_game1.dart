import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/src/brick_breaker.dart';

class LottoGameOne extends StatelessWidget {
  LottoGameOne({super.key});

  final game = BrickBreaker();

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
