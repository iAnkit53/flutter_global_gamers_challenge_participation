import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';

class GameScoreDisplayP1 extends StatelessWidget {
  const GameScoreDisplayP1({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as RaceGame).gameManager.score1,
      builder: (context, value, child) {
        double value2 = (value != null || value!=0) ? value/10 :0;
        return Container(
          color: Colors.white54,
          child: Row(
            children: [
              Icon(Icons.person_2_rounded, color: Colors.orangeAccent),
              Text(' $value2 \$', style: TextStyle(color: Colors.black, fontSize: 26,),),
            ],
          ),
        );
      },
    );
  }
}
