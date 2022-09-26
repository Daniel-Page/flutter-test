import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final width; // out of 2
  final height;
  const MyBrick({super.key, this.x, this.y, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(x * (1.0 + width / 2), y * (1.0 + height / 2)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / (2 / height),
                width: MediaQuery.of(context).size.width / (2 / width))));
  }
}
