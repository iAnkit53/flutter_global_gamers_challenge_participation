import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';

class GameScoreDisplay extends StatelessWidget {
  const GameScoreDisplay({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as RaceGame).gameManager.score,
      builder: (context, value, child) {
        double value2 = (value!=null || value!=0) ? value/10:0;
        return Text('Distance: $value2 m',
            style:
            TextStyle(color: Colors.purple,
            fontSize: 35),
            // Theme.of(context).textTheme.displaySmall!
        );
      },
    );
  }
}
