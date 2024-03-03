import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:ggc_ankit1/game/race_file.dart';
import 'package:ggc_ankit1/game/utils/color_theme.dart' as Col;

class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.Blue;// LAWLog Initial selected item
  int amount = 5;

  void incrementNumber() {
    setState(() {
      if(amount <= 50){
      amount++;
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if(amount >= 2){
      amount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RaceGame game = widget.game as RaceGame;

    return
      // LayoutBuilder(builder: (context, constraints) {
      // return
        // Material(
        Container(
        // color: Col.ga5,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/game/bg12.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        child:

        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child:

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          decrementNumber();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(20, 50),
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
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.headlineMedium
                          ),
                        ),
                        child: const Text('-'),
                      ),
                      Container(
                        color: Colors.white54,
                        child: Text(
                          ' Bet '+amount.toString() +'\$ ',
                          style:
                          TextStyle(
                              color: Colors.black,
                              // color: Colors.deepPurple,
                              fontSize:35),
                          // Theme.of(context).textTheme.displayMedium!.copyWith(),
                        ),
                      ),
                      ElevatedButton(
                        onLongPress: () async {
                        },
                        onPressed: () async {
                          incrementNumber();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(20, 50),
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
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.headlineMedium
                          ),
                        ),
                        child: const Text('+'),
                      ),
                      SizedBox(width: 8,),
                      ElevatedButton(
                        onLongPress: () async {

                        },
                        onPressed: () async {
                          game.gameManager.amount = amount;
                            game.startGame();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(80, 50),
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
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.headlineMedium
                          ),
                        ),
                        // child: const Text('PLAY'),
                        child: const Text('START'),
                      ),
                    ],
                  ),
                ),
            //   ],
            // ),
          // ),
        ),
      );
    // }
    // );
  }
}

class CharacterButton extends StatelessWidget {
  const CharacterButton(
      {super.key,
      required this.character,
      this.selected = false,
      required this.onSelectChar,
      required this.characterWidth});

  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Col.ga3)
                  // const Color.fromARGB(31, 64, 195, 255))
      )
          : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}.png',
              height: characterWidth,
              width: characterWidth,
            ),
            const WhiteSpace(height: 18),
            Text(
              character.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
