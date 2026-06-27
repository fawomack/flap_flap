import 'package:flame/game.dart';
import '../components/bird.dart'; // We will create this next

class GameScreen extends FlameGame {
  @override
  Future<void> onLoad() async {
    // This is where we will add our bird component
    add(BirdComponent());
  }
}