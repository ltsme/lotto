import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:lotto/pages/game/game1/src/brick_breaker.dart';
import 'package:lotto/pages/game/game1/src/config.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<BrickBreaker> {
  Bat({
    required this.cornerRadius, // 시간에 따른 위치 변화를 나타내는 Vector2 개채, 속도와 방향을 의미
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );
  final Radius cornerRadius;
  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size.toSize(), cornerRadius),
        _paint);
  }

  // 손가락이나 마우스로 드래그, DragCallbacks
  @override
  void onDragUpdate(DragUpdateEvent event) {
    // TODO: implement onDragUpdate
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }

  // 키보드 제어에 반응
  // MoveToEffect 객체를 추가해서, 막대가 새 위치로 애니메이트 되어진다.
  // effect는 생성자로써 게임의 참조를 포함하므로, HasGameReference 믹스인을 포함한다.
  void moveBy(double dx) {
    add(
      MoveToEffect(
        Vector2((position.x + dx).clamp(0, gameWidth), position.y),
        EffectController(duration: 0.1),
      ),
    );
  }
}
