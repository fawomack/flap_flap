import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../logic/bird_logic.dart';
import '../screens/game_screen.dart';
import '../constants.dart';

class BirdComponent extends PositionComponent with HasGameReference<GameScreen> {
  // We hold the logic "brain" here
  final BirdLogic logic = BirdLogic();

  @override
  Future<void> onLoad() async {
    size = Vector2(GameConfig.birdSize, GameConfig.birdSize); // Give it a size
    reset();
  }

  void reset() {
    position = Vector2(GameConfig.initialBirdX, GameConfig.initialBirdY);
    logic.reset();
  }

  @override
  void render(Canvas canvas) {
    // Draw a simple yellow square instead of an image
    canvas.drawRect(size.toRect(), Paint()..color = Colors.yellow);
  }

  @override
  void update(double dt) {
    if (game.gameState == GameState.playing) {// CRITICAL: Only update logic if the game is in the 'playing' state
      logic.update(dt, game.size.y);//Tell logic to calculate physics & game screen height
      position.y = logic.yPosition; // Update our position based on that logic
    }
  }

  /// Triggers the jump action by communicating with the logic layer.
  /// This method is called by the GameScreen when a user tap is detected.
  void jump() {
    // We delegate the actual math/physics calculation to our logic class.
    // This keeps the component (visuals) separate from the logic (math).
    logic.jump();
  }
}