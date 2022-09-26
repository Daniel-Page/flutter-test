import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final brickWidth; // out of 2
  const MyBrick({super.key, this.x, this.y, this.brickWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(x * (1.0 + brickWidth / 2), y),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 40,
                width: MediaQuery.of(context).size.width / 5)));
  }
}
