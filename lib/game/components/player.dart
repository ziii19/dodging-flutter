import 'package:dodging/game/components/obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef, CollisionCallbacks {
  final BuildContext context;
  static const double playerHeight = 20.0;
  static const double bottomMargin = 30.0;
  static const double moveAmount = 10.0;

  Player(this.context) {
    size = Vector2(80, playerHeight);
    position = Vector2(85, 500 - size.y - bottomMargin);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: Vector2.zero()));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle) {
      gameRef.pauseEngine();
    }
  }

  @override
  void render(Canvas canvas) {
    final Paint paint = Paint()..color = Colors.grey;
    canvas.drawRect(toRect(), paint);
    final Paint hitboxPaint = Paint()..color = Colors.blue.withOpacity(0.5);
    canvas.drawRect(toRect(), hitboxPaint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = position.x.clamp(0, 500 - size.x);
  }

  void onPanUpdate(DragUpdateInfo info) {
    final dragX = info.raw.localPosition.dx;
    position.x = dragX - size.x / 2;
    position.x = position.x.clamp(0, 500 - size.x);
  }
}
