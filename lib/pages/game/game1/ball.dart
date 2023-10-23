// Ball 클래스
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:lotto/pages/game/game1/player.dart';
import 'package:lotto/pages/game/game1/enemyblock.dart';

class Ball extends SpriteComponent with HasGameRef, CollisionCallbacks {
  static const ballSize = 35.0;
  final Vector2 _velocity = Vector2(0.0, 5.0);
  double ballSpeed = 100;

  Ball(position)
      : super(
          position: position,
          size: Vector2.all(ballSize),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(CircleHitbox());
    sprite = await gameRef.loadSprite('ball2_space.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 프레임 마다 위치 이동
    // x
    // y
    position += _velocity;

    // 화면 밖을 벗어날 경우, 객체 삭제
    // Star의 anchor가 bottomCenter 이므로, position.y 값에서 size.y를 뺀다.
    if (position.y - ballSize > gameRef.size.y) {
      removeFromParent();
      print("debug : 공 삭제");
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // 공이 Player와 부딪히면, 공 컴포넌트 삭제
    bool isCollidingUpside =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    if (isCollidingUpside && other is Player) {
      print("debug : Ball 충돌, onCollision Player");
      goUpside();
      return;
    }

    if (isCollidingUpside && other is EnemyBlock) {
      print("debug : Ball 충돌, onCollision EnemyBlock");
      goUpside();
      return;
    }
  }

  void goUpside() {
    _velocity.y = -_velocity.y;
  }
}
