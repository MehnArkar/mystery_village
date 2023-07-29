import 'package:flame/game.dart';
import 'package:mystery_village/game/components/game_world.dart';
import 'package:mystery_village/game/components/player.dart';
import 'package:mystery_village/game/components/world_collidable.dart';
import 'dart:ui';

import 'package:mystery_village/helper/constants.dart';
import 'package:mystery_village/helper/map_loader.dart';

class MysteryVillageGame extends FlameGame with HasCollisionDetection{

  final GameWorld _gameWorld = GameWorld();
  final Player _player = Player();

  @override
  Future<void> onLoad() async{
    await add(_gameWorld);
    await add(_player);
    addCollidableWorld();
    _player.position = _gameWorld.size/2;
    camera.followComponent(_player,worldBounds: Rect.fromLTRB(0, 0, _gameWorld.size.x, _gameWorld.size.y));
  }

  onDirectionChange(Direction direction){
    _player.direction=direction;
  }

  onPressedAttack(){
    _player.onAttack();
  }

  Future<void> addCollidableWorld() async{
    (await MapLoader.readWorldCollisionMap()).forEach((rect) {
      add(
          WorldCollidable()
              ..position=Vector2(rect.left, rect.top)
              ..width=rect.width
              ..height = rect.height
      );
    });
  }
}