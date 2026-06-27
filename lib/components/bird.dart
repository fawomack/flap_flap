import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../logic/bird_logic.dart';

class BirdComponent extends PositionComponent {
  // We hold the logic "brain" here
  final BirdLogic logic = BirdLogic();

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50); // Give it a size
    position = Vector2(100, 100);
  }

  @override
  void render(Canvas canvas) {
    // Draw a simple yellow square instead of an image
    canvas.drawRect(size.toRect(), Paint()..color = Colors.yellow);
  }

  @override
  void update(double dt) {
    // 1. Tell logic to calculate physics
    logic.update(dt);
    // 2. Update our position based on that logic
    position.y = logic.yPosition;
  }

  /// Triggers the jump action by communicating with the logic layer.
  /// This method is called by the GameScreen when a user tap is detected.
  void jump() {
    // We delegate the actual math/physics calculation to our logic class.
    // This keeps the component (visuals) separate from the logic (math).
    logic.jump();
  }
}