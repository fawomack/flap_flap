import 'package:flame/game.dart';
import '../components/bird.dart'; 
import 'package:flame/events.dart'; // <--- This contains TapCallbacks

class GameScreen extends FlameGame with TapCallbacks {
  late BirdComponent bird;
  
  @override
  Future<void> onLoad() async {
    bird = BirdComponent();
    add(bird);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event); // Always call super for overrides
    bird.jump();
  }
}