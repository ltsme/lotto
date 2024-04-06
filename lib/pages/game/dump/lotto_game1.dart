// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:lotto/pages/game/game1/ball.dart';

// import 'package:lotto/pages/game/game1/direction.dart';
// import 'package:lotto/pages/game/game1/enemyblock.dart';
// import 'package:lotto/pages/game/game1/joypad.dart';
// import 'package:lotto/pages/game/game1/player.dart';
// import 'package:lotto/pages/game/game1/world.dart';

// class LottoGameOne extends StatelessWidget {
//   final Game1 game1;

//   const LottoGameOne(this.game1, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         // 게임 위젯
//         GameWidget(game: game1),

//         // 조이패드 위젯
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Joypad(onDirectionChanged: onJoypadDirectionChanged),
//           ),
//         )
//       ],
//     ));
//   }

//   void onJoypadDirectionChanged(Direction direction) {
//     game1.onJoypadDirectionChanged(direction);
//   }
// }

// // Game1 클래스
// class Game1 extends FlameGame with HasCollisionDetection, HasGameRef {
//   final Player player = Player();
//   // final EnemyBlock enemyBlock = EnemyBlock();
//   final WorldMap worldMap = WorldMap();
//   double spawnDt = 0;

//   @override
//   Future<void> onLoad() async {
//     addInitialize();
//     stage1();
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//   }

//   void onJoypadDirectionChanged(Direction direction) {
//     player.direction = direction;
//   }

//   void addInitialize() {
//     add(worldMap);
//     add(Ball(Vector2(size.x * 0.5, size.y / 2)));
//     add(player);
//     player.position = Vector2(size.x * 0.5, size.y - 30);
//   }

//   void stage1() async {
//     Vector2 blockSize = Vector2(size.x * 0.1, size.x * 0.1 * 0.75);

//     // 세로 3줄
//     for (int j = 0; j < 3; j++) {
//       // 가로 8개
//       for (int i = 0; i < 7; i++) {
//         add(EnemyBlock(
//           Vector2(
//             (size.x * 0.1) + (size.x * 0.1 * i) * (1 + (1 / 3)),
//             size.y * 0.2 + (size.y * 0.1 * j),
//           ),
//           blockSize,
//           await gameRef.loadSprite('wall1.png'),
//         ));
//       }
//     }
//   }
// }
