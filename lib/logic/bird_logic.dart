// lib/logic/bird_logic.dart
import '../constants.dart';

class BirdLogic {
  double yPosition = GameConfig.initialBirdY;// initial position
  double velocity = 0.0;  // Initial velocity (how fast it's falling)
  bool isDead = false; // Add a state to track if the bird hit something

  void reset({double? startY}) {
    // If startY is provided, use it; otherwise, use the constant
    yPosition = startY ?? GameConfig.initialBirdY;
    velocity = 0.0;
    isDead = false;
  }

  // This method will be called every frame
  void update(double dt, double screenHeight) {
    if (isDead) return;

    //apply gravity and update position
    velocity += GameConfig.gravity * dt;    // 1. Apply simple gravity: increase velocity over time
    yPosition += velocity * dt;    // 2. Update position based on velocity

    // Boundary Logic Floor
    // Check if bird hit the floor
    if (yPosition + GameConfig.birdSize >= screenHeight) {
      yPosition = screenHeight - GameConfig.birdSize;
      isDead = true; 
    } 
    // Boundary Logic Ceiling
    // Check if bird hit the ceiling
    else if (yPosition <= 0) {
      yPosition = 0;
      isDead = true;
    }
  }

  void jump() {
    if (!isDead) { //can't jump if dead
      velocity = GameConfig.jumpStrength;    // Negative velocity moves the bird up
    }
  }
}