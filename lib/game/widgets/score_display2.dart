import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';

class GameScoreDisplay2 extends StatelessWidget {
  const GameScoreDisplay2({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as RaceGame).gameManager.score,
      builder: (context, value, child) {
        double value2 = (value!=null || value!=0) ? value/10:0;
        return Column(
          children: [
            SizedBox(height: 26,),
            Text('Distance: \n $value2 m',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 24,
                )),
          ],
        );
      },
    );
  }
}
