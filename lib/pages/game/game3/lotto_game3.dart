import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/direction.dart';
import 'package:lotto/pages/game/game1/joypad.dart';
import 'package:lotto/pages/game/game1/player.dart';

class LottoGamePage extends StatelessWidget {
  final Game3 game3;

  const LottoGamePage(this.game3, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GameWidget(game: game3),

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
    game3.onJoypadDirectionChanged(direction);
  }
}

// Game3 클래스
class Game3 extends FlameGame {
  final Player player = Player();
  final Image backgroundSprite;

  Game3(this.backgroundSprite) {}

  @override
  onLoad() async {
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void onJoypadDirectionChanged(Direction direction) {
    player.direction = direction;
  }
}
