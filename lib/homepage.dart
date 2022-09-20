import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pong/ball.dart';
import 'package:mobile_pong/brick.dart';
import 'package:mobile_pong/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePage extends State<HomePage> {
  // player variables (bottom brick)
  double playerX = 0;
  double playerWidth = 0.4; // out of 2

  // ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  // game settings

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      // update direction
      updateDirection();

      // move ball
      moveBall();

      // check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        resetGame();
      }
    });
  }

  void resetGame() {
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = 0;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      // update vertical direction
      if (ballY >= 0.9 && playerX + playerWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      // horizontal movement
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      // vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.001;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.001;
      }

      // horizontal movement
      if (ballXDirection == direction.RIGHT) {
        ballX += 0.001;
      } else if (ballXDirection == direction.LEFT) {
        ballX -= 0.001;
      }
    });
  }

  void moveLeft() {
    setState(() {
      playerX -= 0.05;
    });
  }

  void moveRight() {
    setState(() {
      playerX += 0.05;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
              event.isKeyPressed(LogicalKeyboardKey.keyA)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
              event.isKeyPressed(LogicalKeyboardKey.keyD)) {
            moveRight();
          }
        },
        child: GestureDetector(
            onTap: startGame,
            child: Scaffold(
                backgroundColor: Colors.grey[900],
                body: Center(
                    child: Stack(
                  children: [
                    CoverScreen(gameStarted: gameHasStarted), // tap to play
                    MyBrick(
                        x: 0.0, y: -0.9, brickWidth: playerWidth), // top brick
                    MyBrick(
                        x: playerX,
                        y: 0.9,
                        brickWidth: playerWidth), // bottom brick
                    Ball(x: ballX, y: ballY) // ball
                  ],
                )))));
  }
}
