import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';
import 'package:ggc_ankit1/game/utils/color_theme.dart' as Col;
import 'package:ggc_ankit1/game/widgets/player_one_score_s.dart';
import 'package:ggc_ankit1/game/widgets/player_two_score_s.dart';
import 'widgets.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Col.ga5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/game/bgo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style:
                TextStyle(color: Colors.black,
                    fontSize: 44),
                // Theme.of(context).textTheme.displayMedium!.copyWith(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90,
                    right: 90.0),
                child: GameScoreDisplayP1(
                  game: game,
                ),
              ),
              SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.only(left: 90,
                    right: 90.0),
                child: GameScoreDisplayP2(
                  game: game,
                ),
              ),
              const WhiteSpace(height: 80),
              GameScoreDisplay(
                game: game,
                isLight: true,
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  (game as RaceGame).resetGame();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 50),
                  ),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Return the color based on the button state
                      if (states.contains(MaterialState.pressed)) {
                        return Col.g6; // Color for pressed state
                      }
                      return Col.g5; // Color for normal state
                    },
                  ),
                  // Other button styles can be added here
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.headlineMedium),
                ),
                child: const Text('Retry'),
              ),
              const WhiteSpace(
                height: 26,
              ),
              ElevatedButton(
                onPressed: () {
                  (game as RaceGame).onMainMenu();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 50),
                  ),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Return the color based on the button state
                      if (states.contains(MaterialState.pressed)) {
                        return Col.g6; // Color for pressed state
                      }
                      return Col.g5; // Color for normal state
                    },
                  ),
                  // Other button styles can be added here
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.headlineMedium),
                ),
                child: const Text('Main Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
