// // Ball 클래스
// import 'dart:developer';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:lotto/pages/game/game1/enemyblock.dart';
// import 'package:lotto/pages/game/game1/player.dart';

// class Ball extends SpriteComponent with HasGameRef, CollisionCallbacks {
//   static const ballSize = 30.0;
//   double speedX = 0.0;
//   double speedY = 5.0;

//   Ball(
//     position,
//   ) : super(
//           position: position,
//           size: Vector2.all(ballSize),
//           anchor: Anchor.bottomCenter,
//         );

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     await add(CircleHitbox());
//     sprite = await gameRef.loadSprite('ball2_space.png');
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);

//     // 프레임 마다 위치 이동
//     position += Vector2(speedX, speedY);

//     // 공이(position) 화면 위에 부딪힌 경우, 공의 y 이동방향 반대
//     if (position.y < ballSize) {
//       speedY = -speedY;
//       log("Game debug : 공 화면 위 부딪힘");
//     }

//     // 공이(position) 화면 아래에 부딪힌 경우, 공 삭제, 라이프 -1
//     // Star의 anchor가 bottomCenter 이므로, position.y 값에서 size.y를 뺀다.
//     if (position.y - ballSize > gameRef.size.y) {
//       removeFromParent();
//       log("Game debug : 공 화면 아래 나감, 공 삭제");
//     }

//     // 공이(position) 화면 왼쪽에 부딪힌 경우, 공의 x 이동방향 반대
//     if (position.x < (ballSize / 2)) {
//       speedX = -speedX;
//       log("Game debug : 공 화면 왼쪽 부딪힘");
//     }

//     // 공이(position) 화면 오른쪽에 부딪힌 경우, 공의 x 이동방향 반대
//     if (position.x > gameRef.size.x - ballSize / 2) {
//       speedX = -speedX;
//       log("Game debug : 공 화면 오른쪽 부딪힘");
//     }
//   }

//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     super.onCollision(intersectionPoints, other);

//     // y
//     bool isCollidingY =
//         (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 3;

//     // 공이 Player와 부딪힐 때
//     if (isCollidingY && other is Player) {
//       log("Game debug : Ball Player와 충돌, onCollision");
//       log("Game debug : Player(other) speed is : ${other.speed}");

//       // Player 오른쪽 이동
//       if (other.speed > 0) {
//         speedX = speedX + 2.5;
//         speedY = -speedY;
//       } else if (other.speed < 0) {
//         // Player 왼쪽 이동
//         speedX = speedX - 2.5;
//         speedY = -speedY;
//       } else {
//         // Player 제자리
//         speedY = -speedY;
//       }
//       return;
//     }

//     // 공이 EnemyBlock와 부딪힐 때
//     if (isCollidingY && other is EnemyBlock) {
//       log("Game debug : Ball Block과 충돌, onCollision");
//       speedY = -speedY;
//       other.removeFromParent();
//       return;
//     }
//   }
// }
