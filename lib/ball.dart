import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final x;
  final y;
  final width;
  final height;
  const Ball({super.key, this.x, this.y, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x * (1 + width / 2), y * (1 + height / 2)),
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: MediaQuery.of(context).size.height / (2 / width),
        height: MediaQuery.of(context).size.height / (2 / height),
      ),
    );
  }
}
