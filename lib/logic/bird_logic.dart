// lib/logic/bird_logic.dart
import '../constants.dart';

class BirdLogic {
  double yPosition = 100.0;// initial position
  

  double velocity = 0.0;  // Initial velocity (how fast it's falling)

  // This method will be called every frame
  void update(double dt) {
    // 1. Apply simple gravity: increase velocity over time
    velocity += GameConfig.gravity * dt;
    
    // 2. Update position based on velocity
    yPosition += velocity * dt;
  }

  void jump() {
    // Negative velocity moves the bird up
    velocity = GameConfig.jumpStrength;
  }
}