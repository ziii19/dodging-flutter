import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Obstacle extends PositionComponent with CollisionCallbacks {
  double speed = 100;

  Obstacle() {
    size = Vector2(50, 50);
    position = Vector2(
      (400 - size.x) * math.Random().nextDouble(),
      0,
    );
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: Vector2(5, 5)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    if (position.y > 600) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final Paint paint = Paint()..color = Colors.red;
    canvas.drawRect(toRect(), paint);
    final Paint hitboxPaint = Paint()..color = Colors.blue.withOpacity(0.5);
    canvas.drawRect(toRect(), hitboxPaint);
  }
}
