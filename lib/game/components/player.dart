import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:mystery_village/game/components/world_collidable.dart';
import 'package:mystery_village/helper/constants.dart';

class Player extends SpriteAnimationComponent with HasGameRef,CollisionCallbacks{
  Player():super(size: Vector2.all(60)){add(RectangleHitbox());}

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is WorldCollidable){
      animation = attackAnimation;
    }
  }

  bool isAttacking = false;

  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;

  final double animationSpeed = 0.15;
  late SpriteAnimation idlingAnimation;

  late SpriteAnimation runRightAnimation;
  late SpriteAnimation runLeftAnimation;
  late SpriteAnimation runUpAnimation;
  late SpriteAnimation runDownAnimation;

  late SpriteAnimation attackAnimation;

  @override
  Future<void> onLoad() async{
      await onLoadAnimation();
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }





  Future<void> onLoadAnimation() async{
     final walkSpriteSheet = SpriteSheet(
         image: await gameRef.images.load('walk.png'),
         srcSize: Vector2(16, 16));

     final idleSpriteSheet = SpriteSheet(
         image: await gameRef.images.load('Idle.png'),
         srcSize: Vector2(16,16)
     );

     final attackSpriteSheet = SpriteSheet(
         image: await gameRef.images.load('attack.png'),
         srcSize: Vector2(16,16)
     );
     
     idlingAnimation = idleSpriteSheet.createAnimation(row: 0, stepTime: animationSpeed,to: 1);
     
     runRightAnimation = walkSpriteSheet.createAnimation(row: 3, stepTime: animationSpeed,to: 6);
     runLeftAnimation = walkSpriteSheet.createAnimation(row: 2, stepTime: animationSpeed,to: 6);
     runUpAnimation = walkSpriteSheet.createAnimation(row: 1, stepTime: animationSpeed,to: 6);
     runDownAnimation = walkSpriteSheet.createAnimation(row: 0, stepTime: animationSpeed,to: 6);

     attackAnimation = attackSpriteSheet.createAnimation(row: 0, stepTime: animationSpeed,to: 4);

     
  }

  onAttack(){
    isAttacking = true;
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>isAttacking=false);
  }



  movePlayer(double dt){
    switch(direction){
      case Direction.none:{
        if(isAttacking) {
          animation = attackAnimation;
        }else{
          animation = idlingAnimation;
        }
      }

      case Direction.right:{
        if(isAttacking){
          animation = attackAnimation;
        }else {
          animation = runRightAnimation;
        }
          moveRight(dt);
      }

      case Direction.left:{
        if(isAttacking){
          animation =  attackAnimation;
        }else {
          animation = runLeftAnimation;
        }
        moveLeft(dt);
      }

      case Direction.up:{
        if(isAttacking) {
          animation = attackAnimation;
        }else{
          animation = runUpAnimation;
        }
        moveUp(dt);
      }

      case Direction.down:{
        if(isAttacking) {
          animation = attackAnimation;
        }else {
          animation = runDownAnimation;
        }
        moveDown(dt);
      }
    }
  }


  void moveDown(double delta) {
    position.add(Vector2(0, delta*_playerSpeed));
  }
  void moveUp(double delta) {
    position.add(Vector2(0, -delta*_playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(-delta*_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta*_playerSpeed, 0));
  }

}