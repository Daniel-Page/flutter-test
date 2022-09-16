import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ball.dart';
import 'package:flutter_application_1/brick.dart';
import 'package:flutter_application_1/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

enum direction { UP, DOWN }

class _HomePage extends State<HomePage> {
  // ball variables
  double ballX = 0;
  double ballY = 0;
  var ballDirection = direction.DOWN;

  // game settings

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        ballY += 0.0001;
      });
    });
  }

  void updateDirection() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: startGame,
        child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: Center(
                child: Stack(
              children: [
                CoverScreen(gameStarted: gameHasStarted), // tap to play
                MyBrick(x: 0.0, y: -0.8), // top brick
                MyBrick(x: 0.0, y: 0.8), // bottom brick
                Ball(x: ballX, y: ballY) // ball
              ],
            ))));
  }
}
