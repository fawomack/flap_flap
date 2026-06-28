import 'package:flame/game.dart';
import '../components/bird.dart'; 
import 'package:flame/events.dart'; // <--- This contains TapCallbacks
//import 'package:flame/components.dart'; // Need this for overlays
//import 'package:flutter/material.dart'; // Standard Flutter UI
import 'package:flutter/foundation.dart'; // This is where debugPrint lives
import '../constants.dart';
import '../components/boundary.dart';

class GameScreen extends FlameGame with TapCallbacks, HasCollisionDetection {
  late BirdComponent bird;
  
  // Declare the initial game state
  GameState gameState = GameState.initial;

  @override
  Future<void> onLoad() async {
    // add bird
    bird = BirdComponent();
    add(bird);

    // 2. Add Floor (at the bottom of the screen)
    add(Boundary(
      size: Vector2(size.x, 20), // 20 pixels thick
      position: Vector2(0, size.y - 20),
    ));

    // 3. Add Ceiling (at the top of the screen)
    add(Boundary(
      size: Vector2(size.x, 20),
      position: Vector2(0, 0),
    ));

    // Setup and add the overlays (UI)
    // Overlays will be described later in this process.
    // add(GameOverOverlay()); // (You will implement this)
    // add(InitialOverlay());   // (Optional, for pre-game)
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Check if the bird just died this frame
    if (gameState == GameState.playing && bird.logic.isDead) {
      triggerGameOver();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event); // Always call super for overrides

    switch (gameState) {
      case GameState.initial:
        startGame();
        bird.jump(); // The initial tap should also make the bird jump
        break;
      case GameState.playing:
        bird.jump();
        break;
      case GameState.gameOver:
        resetGame();
        break;
    }
  }

  void startGame() {
    gameState = GameState.playing;
    // Activate any moving components (Pipes, when you add them)
    // overlays.remove('initial'); 
  }

  void triggerGameOver() {
    gameState = GameState.gameOver;
    // Deactivate moving components (Pipes, when you add them)
    // overlays.add('gameOver'); // Show the visual overlay
    
    debugPrint('GAME OVER! Total Score: [Score Not Yet Implemented]');
  }

  void resetGame() {
    gameState = GameState.initial;
    bird.reset(); // Call the component's reset method
    // overlays.remove('gameOver');
    
    debugPrint('Game Reset. Ready to start again.');
  }
}