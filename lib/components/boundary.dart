import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Boundary extends PositionComponent with CollisionCallbacks {
  Boundary({required Vector2 size, required Vector2 position}) {
    this.size = size;
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    // Optional: Draw a line so you can see your boundaries while testing
    canvas.drawRect(size.toRect(), Paint()..color = Colors.blue.withValues(alpha: 0.5));
  }
}