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
  double brickWidth = 0.4; // out of 2
  double brickHeight = 0.05; // out of 2
  double playerY = 0.90;

  bool isMovingLeft = false;
  bool isMovingRight = false;

  // enemy variables (top brick)
  double enemyX = 0;

  // ball variables
  double ballX = 0;
  double ballY = 0;
  double ballDiameter = 0.05;
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

      // move enemy
      moveEnemy();

      if (isMovingLeft) {
        moveLeft(0.003);
      } else if (isMovingRight) {
        moveRight(0.003);
      }

      // check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        resetGame();
      }
    });
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
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
      if (ballY >= playerY - 0.5 * brickHeight - ballDiameter / 2 + 0.01 &&
          ballX >= playerX - brickWidth / 2 &&
          ballX <= playerX + brickWidth / 2) {
        ballYDirection = direction.UP;
      } else if (ballY <= -playerY + 0.5 * (1 / 40) * 2) {
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

  void moveLeft(incr) {
    setState(() {
      if (playerX > -1) {
        playerX -= incr;
      }
    });
  }

  void moveRight(incr) {
    setState(() {
      if (playerX < 1) {
        playerX += incr;
      }
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
            moveLeft(0.05);
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
              event.isKeyPressed(LogicalKeyboardKey.keyD)) {
            moveRight(0.05);
          }
        },
        child: GestureDetector(
            onTap: startGame,
            child: Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                    child: Stack(
                  children: [
                    CoverScreen(gameStarted: gameHasStarted), // tap to play
                    MyBrick(
                        x: enemyX,
                        y: -playerY,
                        brickWidth: brickWidth,
                        brickHeight: brickHeight), // top brick
                    MyBrick(
                        x: playerX,
                        y: playerY,
                        brickWidth: brickWidth,
                        brickHeight: brickHeight), // bottom brick
                    Ball(x: ballX, y: ballY), // ball,
                    // Container(
                    //     alignment: Alignment(playerX, 0.9 + 0.003),
                    //     child:
                    //         Container(width: 2, height: 20, color: Colors.red)),
                    Container(
                        alignment: Alignment(1, 1),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          // color: Color.fromARGB(50, 66, 142, 78),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (event) {
                              isMovingRight = true;
                            },
                            onTapUp: (event) {
                              isMovingRight = false;
                            },
                          ),
                        )),
                    Container(
                        alignment: Alignment(-1, 1),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          // color: Color.fromARGB(49, 255, 0, 0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (event) {
                              isMovingLeft = true;
                            },
                            onTapUp: (event) {
                              isMovingLeft = false;
                            },
                          ),
                        )),
                  ],
                )))));
  }
}
