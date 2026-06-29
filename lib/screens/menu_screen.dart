import 'package:flutter/material.dart';
import '../screens/game_screen.dart';
import '../constants.dart';

class MenuScreen extends StatelessWidget {
  final GameScreen game;
  final bool isGameOver;

  const MenuScreen({super.key, required this.game, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isGameOver ? "Game Over!" : "FlapFlap",
              style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            if (isGameOver)
              Text("Score: ${game.score}", 
                style: const TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isGameOver) {
                  game.resetGame();
                }
                // Remove the menu overlay
                game.overlays.remove('Menu');
                // Resume the game
                game.gameState = GameState.playing;
                game.resumeEngine();
                // If it was game over, we would call a reset() method here
              },
              child: Text(isGameOver ? "Restart" : "Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}