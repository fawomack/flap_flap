import 'dart:math';
import 'package:flame/components.dart';
import '../components/obstacle_pipe.dart';
import '../screens/game_screen.dart';
import '../constants.dart';

class PipeManager extends Component with HasGameReference<GameScreen> {
  double timer = 0;
  final double spawnInterval = 2.0; // Seconds between pipes

  @override
  void update(double dt) {
    // If the game isn't playing, do not update movement!
    if (game.gameState != GameState.playing) return;
    timer += dt;
    if (timer >= spawnInterval) {
      spawnPipes();
      timer = 0;
    }
  }

  void spawnPipes() {
    final double gapHeight = 150;
    final double pipeWidth = 50;
    
    // Random height for the gap
    final double minHeight = 50;
    final double maxHeight = game.size.y - gapHeight - minHeight;
    final double topPipeHeight = minHeight + Random().nextDouble() * (maxHeight - minHeight);

    // Add Top Pipe
    game.add(Pipe(
      size: Vector2(pipeWidth, topPipeHeight),
      position: Vector2(game.size.x, 0),
      isTop: true,
    ));

    // Add Bottom Pipe
    game.add(Pipe(
      size: Vector2(pipeWidth, game.size.y - topPipeHeight - gapHeight),
      position: Vector2(game.size.x, topPipeHeight + gapHeight),
      isTop: false,
    ));
  }
}