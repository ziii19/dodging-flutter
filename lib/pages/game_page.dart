import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/dodging_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  DodgingGame? _game;

  @override
  void initState() {
    super.initState();
    _game = DodgingGame(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _game!),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_game!.isPaused) {
                            _game!.resumeGame();
                          } else {
                            _game!.pauseGame();
                          }
                        });
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          _game!.isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    if (_game!.isGameOver) ...[
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _game!.restartGame();
                          });
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.replay,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
