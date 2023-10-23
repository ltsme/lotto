// Player 클래스
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:lotto/pages/game/game1/direction.dart';

class Player extends SpriteComponent with CollisionCallbacks, HasGameRef {
  final double _playerSpeed = 300.0;
  double speed = 0.0;

  int totalCount = 0;
  Direction direction = Direction.none;

  Player()
      : super(
          size: Vector2(150, 30),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('stick_space.png');
    await add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }

  void movePlayer(double dt) {
    switch (direction) {
      case Direction.left:
        moveLeft(dt);
        break;
      case Direction.right:
        moveRight(dt);
        break;
      case Direction.none:
        break;
    }
  }

  void moveLeft(double delta) {
    speed = -_playerSpeed;
    position.add(Vector2(delta * speed * 1.2, 0));
  }

  void moveRight(double delta) {
    speed = _playerSpeed;
    position.add(Vector2(delta * speed * 1.2, 0));
  }
}
