// PlayerEnemy 클래스
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:lotto/pages/game/game1/direction.dart';

class EnemyBlock extends SpriteComponent with CollisionCallbacks, HasGameRef {
  int totalCount = 0;
  Direction direction = Direction.none;

  EnemyBlock()
      : super(
          size: Vector2(50, 30),
          anchor: Anchor.bottomCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('wall2.png');
    await add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }

  void movePlayer(double dt) {}
}
