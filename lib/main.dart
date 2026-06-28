import 'package:flame/game.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() async{
  // Initialize the Flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  
// Force the app into Landscape mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Launch the GameScreen directly
  // Note: There is NO 'MyApp' class here anymore!
  runApp(GameWidget(game: GameScreen()));
}