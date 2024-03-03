import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/services.dart';
import 'package:ggc_ankit1/game/race_file.dart';
import 'package:ggc_ankit1/game/sprites/competitor.dart';
import 'package:ggc_ankit1/game/sprites/player_two.dart';

enum PlayerState {
  left,
  right,
  center,
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<RaceGame>, KeyboardHandler, CollisionCallbacks {
  Player({
    required this.character,
    this.moveLeftRightSpeed = 700,
  }) : super(
    size: Vector2(69, 69),
    anchor: Anchor.topCenter,
    priority: 1,
  );
  double moveLeftRightSpeed;
  Character character;

  double _hAxisInput = 0.0; //speed of right //or left
  int scoreZ = 0; //
  final double movingLeftInput = -0.62; //-1
  final double movingRightInput = 0.62; //1
  Vector2 _velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    await add(CircleHitbox());
    await _loadCharacterSprites();
    current = PlayerState.center;
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isIntro || gameRef.gameManager.isGameOver) return;

    _velocity.x = _hAxisInput * moveLeftRightSpeed;

    final double marioHorizontalCenter = size.x / 2; //2

    if (position.x < marioHorizontalCenter+ 35) { //Left
      position.x = size.x + 35;//gameRef.size.x - (marioHorizontalCenter);
      // position.x = marioHorizontalCenter;//gameRef.size.x - (marioHorizontalCenter);
    }
    if (position.x > gameRef.size.x - (marioHorizontalCenter)) { //Right
      position.x = gameRef.size.x - (marioHorizontalCenter);//marioHorizontalCenter;
      // position.x = marioHorizontalCenter;
    }

    position += _velocity * dt;

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(other is PlayerTwo){
      print('LBAnkit - CircleHitbox 1 ');
      // moveLeft();
      Future.delayed(Duration(milliseconds: 60)).then((value) {
        moveLeft();
      });
      Future.delayed(Duration(milliseconds: 150)).then((value) {
        resetDirection();
      });
    }else{
      // scoreZ++;
      // scorePlayer();
    // gameRef.onLose();
      gameRef.gameManager.increaseScore1();
      print('LBAnkit - NOTCircleHitbox 1 ');
    }
    return;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0.0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }

    return true;
  }

  void moveLeft() {
    _hAxisInput = 0.0;

    current = PlayerState.left;

    _hAxisInput += movingLeftInput;
    print('LAKLog _hAxisInput' +_hAxisInput.toString());
    print('LAKLog movingRightInput' +movingLeftInput.toString());
  }

  String scorePlayer(){
    scoreZ++;
    // String sz = scoreZ.toString();
    return scoreZ.toString();
  }

  void moveRight() {
    _hAxisInput = 0.0; // by default not going left or right

    current = PlayerState.right;

    _hAxisInput += movingRightInput;
    print('LAKLog _hAxisInput' +_hAxisInput.toString());
    print('LAKLog movingRightInput' +movingRightInput.toString());
  }

  void resetDirection() {
    _hAxisInput = 0.0;
    current = PlayerState.center;
  }

  void reset() {
    _velocity = Vector2.zero();
    current = PlayerState.center;
  }

  void resetPosition() {
    // position = Vector2.zero(
    position = Vector2(
      (gameRef.size.x - size.x) / 3, //2
      // (gameRef.size.y - size.y), //y axis position
      (gameRef.size.y + 86), //y axis position
    );
  }

  Future<void> _loadCharacterSprites() async {
    final left = await gameRef.loadSprite('game/${character.name}left.png');
    final right = await gameRef.loadSprite('game/${character.name}right.png');
    final center = await gameRef.loadSprite('game/${character.name}.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
      PlayerState.center: center,
    };
  }
}
