import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/src/brick_breaker.dart';
import 'package:lotto/pages/game/game1/src/components/components.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Ball({
    required this.velocity, // 시간에 따른 위치 변화를 나타내는 Vector2 개채, 속도와 방향을 의미
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff1e6091)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );
  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    // dt는 프레임 당 간격, position을 프레임마다 이동
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        // game(brick_breaker의 가로 크기)
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(
          RemoveEffect(
              delay: 0.35,
              onComplete: () => game.playState = PlayState.gameOver),
        );
      }
    } else if (other is Bat) {
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
      velocity.y = -velocity.y;
    } else if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);
    } else {
      debugPrint('collision with $other');
    }
  }
}
