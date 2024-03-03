import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ggc_ankit1/game/race_file.dart';
import 'package:ggc_ankit1/game/utils/color_theme.dart';
import 'package:ggc_ankit1/game/widgets/game_over_overlay.dart';
import 'package:ggc_ankit1/game/widgets/game_overlay.dart';
import 'package:ggc_ankit1/game/widgets/main_menu_overlay.dart';
import 'package:ggc_ankit1/game/utils/color_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race Game',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.aladinTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const RaceGameHomePage(),
    );
  }
}

final Game game = RaceGame();

class RaceGameHomePage extends StatelessWidget {
  const RaceGameHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
              minWidth: 550,
            ),
            child: GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        }),
      ),
    );
  }
}
