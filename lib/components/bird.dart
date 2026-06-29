import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../logic/bird_logic.dart';
import '../screens/game_screen.dart';
import '../constants.dart';
import 'boundary.dart';
import 'obstacle_pipe.dart';
import 'package:flame/collisions.dart'; // Import this for collissions

class BirdComponent extends PositionComponent with HasGameReference<GameScreen>, CollisionCallbacks {
  // We hold the logic "brain" here
  final BirdLogic logic = BirdLogic();

  @override
  Future<void> onLoad() async {
    size = Vector2(GameConfig.birdSize, GameConfig.birdSize); // Give it a size
    add(RectangleHitbox());// Add a circular or rectangular hitbox to the bird
    reset();
  }

  void reset() {
    double spawnX = game.size.x * 0.2;// Spawn at 20% of the screen width
    //double spawnY = (game.size.y / 2) - (GameConfig.birdSize / 2);//was originally centered vertically; now trying higher than midway 
    double spawnY = game.size.y *0.4; // Spawn at 40% of the screen height
    //position = Vector2(GameConfig.initialBirdX, GameConfig.initialBirdY);//was originally hardcoded, now uses screen size dynamically
    logic.reset(startY: spawnY);
    position = Vector2(spawnX, spawnY);
  }

  // Handle collision events--old collision logic only handling boundaries, now we handle combination of whatevery we want
  /*@override 
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // If we hit anything, kill the bird!
    logic.isDead = true;
  }*/

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    // The "Body" asks the "Brain" to update its state
    if (other is Boundary || other is Pipe) {
      logic.isDead = true;
      game.pauseEngine(); // This stops everything (pipes, gravity, movement)
      game.overlays.add('Menu'); // This shows your UI
    }
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