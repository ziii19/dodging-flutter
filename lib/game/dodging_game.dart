// ignore_for_file: invalid_use_of_internal_member

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';
import 'components/player.dart';
import 'components/obstacle.dart';

class DodgingGame extends FlameGame with PanDetector {
  late Player player;
  late Timer _obstacleTimer;
  double _obstacleSpeed = 100;
  bool isPaused = false;
  bool isGameOver = false;
  final BuildContext context;

  DodgingGame(this.context);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    player = Player(context);
    add(player);
    _obstacleTimer = Timer(1, onTick: _createObstacle, repeat: true);
    _obstacleTimer.start();
  }

  @override
  void update(double dt) {
    if (isPaused || isGameOver) return;

    super.update(dt);
    _obstacleTimer.update(dt);

    for (final obstacle in children.whereType<Obstacle>()) {
      if (player.toRect().overlaps(obstacle.toRect())) {
        _gameOver();
        return;
      }
    }

    _obstacleSpeed += dt * 10;
    for (final obstacle in children.whereType<Obstacle>()) {
      obstacle.speed = _obstacleSpeed;
    }
  }

  void _createObstacle() {
    final obstacle = Obstacle();
    obstacle.speed = _obstacleSpeed;
    add(obstacle);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.onPanUpdate(info);
  }

  void pauseGame() {
    isPaused = true;
    pauseEngine();
  }

  void resumeGame() {
    isPaused = false;
    resumeEngine();
  }

  void restartGame() {
    _obstacleSpeed = 100;
    children.clear();
    player = Player(context);
    add(player);
    _obstacleTimer.start();
    resumeGame();
    isGameOver = false;
  }

  void _gameOver() {
    isGameOver = true;
    pauseGame();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (isGameOver) {
      TextPainter(
        text: const TextSpan(
          text: 'Game Over',
          style: TextStyle(
            color: Colors.red,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(
          minWidth: size.x,
          maxWidth: size.x,
        )
        ..paint(
          canvas,
          Offset(size.x / 2 - 430 / 2, size.y / 2 - 50 / 2),
        );
    }
  }
}
