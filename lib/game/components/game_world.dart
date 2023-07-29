import 'package:flame/components.dart';

class GameWorld extends SpriteComponent with HasGameRef{
  @override
  Future<void> onLoad() async{
    sprite = await gameRef.loadSprite('background.png');
    size = sprite!.originalSize;
  }
}