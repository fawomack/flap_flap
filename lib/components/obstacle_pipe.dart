import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../screens/game_screen.dart';

class Pipe extends PositionComponent with HasGameReference<GameScreen> {
  final double speed = 200; // Speed moving to the left
  final bool isTop;
  bool passed = false; // use this for scoring when the bird passes through the gap

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

  // If the pipe has passed the bird's x position (bird is at a fixed x)
  if (!passed && (position.x + size.x) < game.bird.position.x) {
    passed = true;
    game.score++;//increment score when the bird passes through the gap
    debugPrint("Score: ${game.score}");
  }

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