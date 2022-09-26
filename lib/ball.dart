import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final x;
  final y;

  const Ball({super.key, this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x * (1 + 0.05 / 2), y * (1 + 0.05 / 2)),
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: MediaQuery.of(context).size.height / 40,
        height: MediaQuery.of(context).size.height / 40,
      ),
    );
  }
}
