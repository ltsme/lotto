// Ball 클래스
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:lotto/pages/game/game1/player.dart';
import 'package:lotto/pages/game/game1/enemyblock.dart';

class Ball extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Player _player = Player();

  static const ballSize = 35.0;
  double velocity_x = 5.0;
  double velocity_y = 5.0;
  Vector2 _velocity = Vector2(0, 5);
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

    // 공이(position) 화면 왼쪽에 부딪힌 경우
    // 공의 y 이동방향 반대
    if (position.x < (ballSize / 2)) {
      _velocity.x = -_velocity.x;
      print("debug : 공 왼쪽 부딪힘");
    }

    // 공이(position) 화면 오른쪽에 부딪힌 경우
    // 공의 y 이동방향 반대
    if (position.x > gameRef.size.x - ballSize / 2) {
      _velocity.x = -_velocity.x;
      print("debug : 공 오른쪽 부딪힘");
    }

    // 공이(position) 화면 위에 부딪힌 경우
    // 공의 y 이동방향 반대
    if (position.y < ballSize) {
      _velocity.y = -_velocity.y;
      print("debug : 공 위 부딪힘");
    }

    // 공이(position) 화면 아래(gameRef.size)을 벗어날 경우
    // Star의 anchor가 bottomCenter 이므로, position.y 값에서 size.y를 뺀다.
    // if (position.y - ballSize > gameRef.size.y) {
    //   removeFromParent();
    //   print("debug : 공 아래 부딪힘, 공 삭제");
    // }
    // -----임시 테스트 용
    if (position.y > gameRef.size.y) {
      _velocity.y = -_velocity.y;
      print("debug : 공 아래 부딪힘");
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // 공이 Player와 부딪히면,
    bool isCollidingUpside =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    if (isCollidingUpside && other is Player) {
      print("debug : Ball 충돌, onCollision Player");
      // Player 오른쪽 이동
      if (_player.speed > 0) {
        _velocity.x = velocity_x;
        _velocity.y = -_velocity.y;
      } else {
        _velocity.x = -velocity_x;
        _velocity.y = -_velocity.y;
      }

      return;
    }

    // 공이 EnemyBlock와 부딪히면,
    if (isCollidingUpside && other is EnemyBlock) {
      print("debug : Ball 충돌, onCollision EnemyBlock");
      return;
    }
  }
}
