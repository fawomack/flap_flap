// This file acts as the "Control Panel" for your game. //
// Use these classes to adjust gameplay, UI, and asset paths.

class GameConfig {
  // Physics - The "unforgiving" factors
  static const double gravity = 500;
  static const double jumpStrength = -250;
  static const double pipeSpeed = 2.0;

  // Spawning
  static const double pipeSpawnInterval = 1.5; // seconds
  static const double pipeGapSize = 150.0;     // pixels
}

class AssetPaths {
  // Use these to avoid typos when loading images/sounds
  static const String birdImage = 'assets/images/bird.png';
  static const String pipeTop = 'assets/images/pipe_top.png';
  static const String pipeBottom = 'assets/images/pipe_bottom.png';
  
  static const String flapSound = 'assets/audio/flap.wav';
  static const String collisionSound = 'assets/audio/collision.wav';
}

class UIConstants {
  // Design tokens that apply across all screens
  static const double padding = 16.0;
  static const double borderRadius = 12.0;
  
  // Scoring
  static const double fontSize = 24.0;
}