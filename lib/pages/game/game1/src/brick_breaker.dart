import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto/pages/game/game1/src/components/components.dart';
import 'package:lotto/pages/game/game1/src/config.dart';

enum PlayState { welcome, playing, gameOver, won }

class BrickBreaker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  BrickBreaker()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: gameWidth, height: gameHeight));
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
        break;
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
        break;
    }
  }

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft; // 좌상단으로 기준점
    world.add(PlayArea()); // PlayArea를 world에 추가
    playState = PlayState.playing;
  }

  void startGame() {
    if (playState == PlayState.playing) return;
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.playing;

    world.add(Ball(
        difficultyModifier: difficultyModifier,
        // 정규화를 통해 공의 속도가 일정하게 유지 (Vector2 값이 1로 고정, 이후 1/4로 스케일업 된다)
        velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
            .normalized()
          ..scale(height / 2),
        position: size / 2, // 게임 화면의 정중앙
        radius: ballRadius));

    world.add(
      Bat(
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
        size: Vector2(batWidth, batHeight),
      ),
    );
    world.addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);
  }

  @override
  void onTap() {
    // TODO: implement onTap
    super.onTap();
    startGame();
  }

  // 키보드 이벤트 믹스인 추가 및 onKeyEvent 메서드로 키보드 입력 처리
  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    super.onKeyEvent(event, keysPressed);

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      world.children.query<Bat>().first.moveBy(-batStep);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      world.children.query<Bat>().first.moveBy(batStep);
    } else if (event.logicalKey == LogicalKeyboardKey.space) {
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
