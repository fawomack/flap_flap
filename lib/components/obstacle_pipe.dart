import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../screens/game_screen.dart';

class Pipe extends PositionComponent with HasGameReference<GameScreen> {
  final double speed = 200; // Speed moving to the left
  final bool isTop;

  Pipe({required Vector2 size, required Vector2 position, required this.isTop}) {
    this.size = size;
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Move to the left
    position.x -= speed * dt;

    // Remove if it goes off screen
    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), Paint()..color = Colors.green);
  }
}