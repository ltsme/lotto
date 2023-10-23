import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/ball.dart';

import 'package:lotto/pages/game/game1/direction.dart';
import 'package:lotto/pages/game/game1/joypad.dart';
import 'package:lotto/pages/game/game1/player.dart';
import 'package:lotto/pages/game/game1/enemyblock.dart';
import 'package:lotto/pages/game/game1/world.dart';

class LottoGamePage extends StatelessWidget {
  final Game1 game1;

  const LottoGamePage(this.game1, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 게임 위젯
        GameWidget(game: game1),

        // 조이패드 위젯
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
          ),
        )
      ],
    ));
  }

  void onJoypadDirectionChanged(Direction direction) {
    game1.onJoypadDirectionChanged(direction);
  }
}

// Game1 클래스
class Game1 extends FlameGame with HasCollisionDetection {
  final Player player = Player();
  final EnemyBlock enemyplayer = EnemyBlock();
  final WorldMap worldMap = WorldMap();
  double spawnDt = 0;

  @override
  Future<void> onLoad() async {
    add(worldMap);
    add(player);
    player.position = Vector2(size.x * 0.5, size.y - 30);
    add(enemyplayer);
    enemyplayer.position = Vector2(size.x * 0.5, 50);
    add(Ball(Vector2(size.x * 0.5, size.y / 2)));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void onJoypadDirectionChanged(Direction direction) {
    player.direction = direction;
  }
}
