// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:lotto/pages/game/game1/lotto_game1.dart';

// // abstract class Block extends SpriteComponent
// //     with HasGameRef<Game1>, CollisionCallbacks {
// //   Block({super.position})
// //       : super(
// //           size: Vector2(50, 30),
// //           anchor: Anchor.bottomCenter,
// //         );
// //   @override
// //   Future<void>? onLoad() async {
// //     await super.onLoad();
// //     await add(RectangleHitbox());
// //   }
// // }

// class EnemyBlock extends SpriteComponent
//     with CollisionCallbacks, HasGameRef<Game1> {
//   // final Map<String, Vector2> spriteOptions = {
//   //   'block_A': Vector2(50, 30),
//   //   'block_B': Vector2(100, 60),
//   //   'block_C': Vector2(150, 90),
//   //   'block_D': Vector2(200, 120),
//   // };

//   EnemyBlock(position, size, sprite)
//       : super(
//           position: position,
//           size: size,
//           anchor: Anchor.bottomCenter,
//           sprite: sprite,
//         );

//   @override
//   Future<void> onLoad() async {
//     // var randSpriteIndex = Random().nextInt(spriteOptions.length);
//     // String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);
//     // size = spriteOptions[randSprite]!;
//     sprite = await gameRef.loadSprite('wall1.png');
//     await add(RectangleHitbox());
//     await super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     //super.update(dt);
//   }
// }
