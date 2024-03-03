import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:ggc_ankit1/game/race_file.dart';
import 'package:ggc_ankit1/game/widgets/player_one_score_s.dart';
import 'package:ggc_ankit1/game/widgets/player_two_score_s.dart';
import 'package:ggc_ankit1/game/widgets/score_display2.dart';
import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  final Game game = RaceGame();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: GameScoreDisplay2(game: widget.game),
          ),
          Positioned(
            top: 150,
            left: 30,
            child: GameScoreDisplayP1(game: widget.game),
          ),
          Positioned(
            top: 200,
            left: 30,
            child:GameScoreDisplayP2(game: widget.game),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton(
              child: const Icon(
                      Icons.stop_rounded,
                      size: 48,
                    ),
              onPressed: () {
                (widget.game as RaceGame).player.gameRef.onLose();
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 120,
            child: ElevatedButton(
              child: isPaused
                  ? const Icon(
                      Icons.play_arrow,
                      size: 48,
                    )
                  : const Icon(
                      Icons.pause,
                      size: 48,
                    ),
              onPressed: () {
                (widget.game as RaceGame).togglePauseState();
                setState(
                  () {
                    isPaused = !isPaused;
                  },
                );
              },
            ),
          ),
          // if (isMobile)
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const WhiteSpace(
                    height: 20,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Joystick(
                    mode: JoystickMode.all,
                    stick: JoystickStick(size: 42,),
                    base: JoystickBase(mode: JoystickMode.all,
                      size: 150,
                      drawArrows: false,
                      // color:  Colors.redAccent,
                      color:  Colors.orangeAccent.withOpacity(0.4),
                    ),
                      // color:  Colors.blue,),
                    listener: (details) {
                      if (details.x > 0.15) {
                        (widget.game as RaceGame).player.moveRight(); // Call rightMoved() when joystick is more than halfway to the right
                      } else if (details.x < -0.15) {
                        (widget.game as RaceGame).player.moveLeft(); // Call leftMoved() when joystick is more than halfway to the left
                      } else{
                        (widget.game as RaceGame).player.resetDirection();
                      }
                    },
                  ),
                  Joystick(
                    mode: JoystickMode.all,
                    stick: JoystickStick(size: 42,),
                    base: JoystickBase(mode: JoystickMode.all,
                      size: 150,
                      drawArrows: false,
                      // color:  Colors.red,),
                      color:  Colors.redAccent.withOpacity(0.4),
                    ),
                    listener: (details) {
                      if (details.x > 0.15) {
                        (widget.game as RaceGame).player2.moveRight(); // Call rightMoved() when joystick is more than halfway to the right
                      } else if (details.x < -0.15) {
                        (widget.game as RaceGame).player2.moveLeft(); // Call leftMoved() when joystick is more than halfway to the left
                      } else{
                        (widget.game as RaceGame).player2.resetDirection();
                      }
                    },
                  ),
                ],
              ),
                ],
              ),
            ),
          ),
          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_presentation_rounded,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
