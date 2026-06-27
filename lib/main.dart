import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  // Initialize the Flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  
  // Launch the GameScreen directly
  // Note: There is NO 'MyApp' class here anymore!
  runApp(GameWidget(game: GameScreen()));
}