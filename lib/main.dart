import 'package:flame/game.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:flutter/material.dart';
import 'screens/game_screen.dart';
import 'screens/menu_screen.dart'; // Make sure this path matches where your file is located

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
  runApp(const FlapFlapApp());
}

class FlapFlapApp extends StatelessWidget {
  const FlapFlapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Everything inside here remains exactly as you built it
        body: GameWidget(
          game: GameScreen(),
          overlayBuilderMap: {
            'Menu': (context, game) {
              // You can decide if it's Game Over or Start based on game state
              // For now, let's just pass false for 'Start'
              return MenuScreen(game: game as GameScreen, isGameOver: false);
            },
          },
        initialActiveOverlays: const ['Menu'], // Show the menu when the app launches
        ),
      ),
    );
  }
}