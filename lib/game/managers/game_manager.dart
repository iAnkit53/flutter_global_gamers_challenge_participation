import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';

class GameManager extends Component with HasGameRef<RaceGame> {
  GameManager();
  int amount = 5;

  Character character = Character.Blue;
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> score1 = ValueNotifier(0);
  ValueNotifier<int> score2 = ValueNotifier(0);

  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;
  void reset() {
    score.value = 0;
    score1.value = 0;
    score2.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    score.value++;
  }

  void increaseScore1() {
    score1.value++;
    if(score1.value >= (amount*10)){
    gameRef.onLose();
    }
  }

  void increaseScore2() {
    score2.value++;
    if(score2.value >= (amount*10)){
      gameRef.onLose();
    }
  }

  void selectCharacter(Character selectedCharcter) {
    character = selectedCharcter;
  }

  void plusA(int amt) {
    if(amount <= 50){
      amount++;
    }
  }

  void minusA(int amt) {
    if(amount >= 2){
    amount--;
    }
  }
}

enum GameState { intro, playing, gameOver }
