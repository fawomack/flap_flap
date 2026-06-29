import 'package:flame/game.dart';
import '../components/bird.dart'; 
import 'package:flame/events.dart'; // <--- This contains TapCallbacks
//import 'package:flame/components.dart'; // Need this for overlays
//import 'package:flutter/material.dart'; // Standard Flutter UI
import 'package:flutter/foundation.dart'; // This is where debugPrint lives
import '../constants.dart';
import '../components/boundary.dart';
import '../logic/obstacle_logic.dart';
import '../components/obstacle_pipe.dart';

class GameScreen extends FlameGame with TapCallbacks, HasCollisionDetection {
  late BirdComponent bird;
  int score = 0;
  
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

    add(PipeManager());

    overlays.add('Menu');

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
    overlays.remove('Menu'); // Ensure the menu is GONE
    resumeEngine();
    // Activate any moving components (Pipes, when you add them)
    // overlays.remove('initial'); 
  }

  void triggerGameOver() {
    if (gameState == GameState.gameOver) return; // Guard clause: already dead!
    gameState = GameState.gameOver;
    pauseEngine(); // This stops the game logic entirely
    overlays.add('Menu');
    // Deactivate moving components (Pipes, when you add them)
    // overlays.add('gameOver'); // Show the visual overlay
    
    debugPrint('GAME OVER! Total Score: [Score Not Yet Implemented]');
  }

  void resetGame() {
    // 1. Reset Game State
    gameState = GameState.initial;
  
    // 2. Reset Bird
    bird.reset(); 
  
    // 3. Clear the World (The critical step for "Zombie" avoidance)
    // This removes all Pipes currently in the game
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
  
    // 4. Reset Score
    score = 0;
  
    // 5. Restart the Engine 
    // (In case it was paused during a Game Over)
    resumeEngine();
  
    debugPrint('Game fully reset. Ready to start again.');
}
}