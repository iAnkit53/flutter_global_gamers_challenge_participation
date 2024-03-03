// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/background.dart';
import 'package:ggc_ankit1/game/managers/game_manager.dart';
import 'package:ggc_ankit1/game/managers/object_manager.dart';
import 'package:ggc_ankit1/game/sprites/competitor.dart';
import 'package:ggc_ankit1/game/sprites/player.dart';
import 'package:ggc_ankit1/game/sprites/player_two.dart';

enum Character {
  Blue,
  Red,
}

class RaceGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  RaceGame({
    super.children,
  });

  final BackGround _backGround = BackGround();
  final GameManager gameManager = GameManager();
  ObjectManager objectManager = ObjectManager();
  int screenBufferSpace = 300;
  int amt = 5;

  EnemyPlatform platFrom = EnemyPlatform();

  late Player player;
  late PlayerTwo player2;

  late AudioPool pool;
  @override
  FutureOr<void> onLoad() async {
    await add(_backGround);
    await add(gameManager);
    overlays.add('gameOverlay');
    pool = await FlameAudio.createPool(
      'sound.mp3',
      minPlayers: 3,
      maxPlayers: 4,
    );
  }

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('sound.mp3', volume: 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameManager.isGameOver) {
      return;
    }
    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    }
    if (gameManager.isPlaying) {
      final Rect worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + _backGround.size.y,
      );
      camera.worldBounds = worldBounds;
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void setCharacter() {
    player = Player(
      // character: gameManager.character,
      character: Character.Blue,
      moveLeftRightSpeed: 600,
    );
    player2 = PlayerTwo(
      character: Character.Red,
      moveLeftRightSpeed: 600,
    );
    add(player);
    add(player2);
  }

  void initializeGameStart() {
    setCharacter();

    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();

    player.reset();
    player2.reset();
    camera.worldBounds = Rect.fromLTRB(
      0,
      -_backGround
          .size.y, // top of screen is 0, so negative is already off screen
      camera.gameSize.x,
      _backGround.size.y +
          screenBufferSpace + 100, // makes sure bottom bound of game is below bottom of screen //LBAnkit
    );
    camera.followComponent(player);

    player.resetPosition();
    player2.resetPosition();

    objectManager = ObjectManager();

    add(objectManager);
    startBgmMusic();
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    player2.removeFromParent();
    FlameAudio.bgm.stop();
    overlays.add('gameOverOverlay');
  }

  void onMainMenu() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    player2.removeFromParent();
    FlameAudio.bgm.stop();
    overlays.add('mainMenuOverlay');
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
      FlameAudio.bgm.resume();
    } else {
      FlameAudio.bgm.pause();
      pauseEngine();
    }
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
    overlays.remove('gameOverOverlay');
  }
}
