import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final brickWidth; // out of 2
  final brickHeight;
  const MyBrick({super.key, this.x, this.y, this.brickWidth, this.brickHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            Alignment(x * (1.0 + brickWidth / 2), y * (1.0 + brickHeight / 2)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 40,
                width: MediaQuery.of(context).size.width / 5)));
  }
}
