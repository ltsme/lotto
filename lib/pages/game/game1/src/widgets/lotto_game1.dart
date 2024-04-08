import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lotto/pages/game/game1/src/brick_breaker.dart';
import 'package:lotto/pages/game/game1/src/config.dart';
import 'package:lotto/pages/game/game1/src/widgets/score_card.dart';

class LottoGameOne extends StatefulWidget {
  LottoGameOne({super.key});

  @override
  State<LottoGameOne> createState() => _LottoGameOneState();
}

class _LottoGameOneState extends State<LottoGameOne> {
  late final BrickBreaker game;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget.controlled(
                            gameFactory: BrickBreaker.new,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) => Center(
                                    child: Text(
                                      'TAP TO PLAY',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                              PlayState.gameOver.name: (context, game) =>
                                  Center(
                                    child: Text(
                                      'G A M E O V E R',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                              PlayState.won.name: (context, game) => Center(
                                    child: Text(
                                      'Y O U W O N !',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
