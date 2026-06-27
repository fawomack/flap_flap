// lib/logic/bird_logic.dart

class BirdLogic {
  // Current position
  double yPosition = 100.0;
  
  // Current velocity (how fast it's falling)
  double velocity = 0.0;

  // This method will be called every frame
  void update(double dt) {
    // 1. Apply simple gravity: increase velocity over time
    velocity += 9.8 * dt;
    
    // 2. Update position based on velocity
    yPosition += velocity * dt;
  }

  void jump() {
    // Negative velocity moves the bird up
    velocity = -5.0; 
  }
}