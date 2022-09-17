import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool gameStarted;

  const CoverScreen({super.key, required this.gameStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: const Alignment(0, -0.2),
        child: Text(
          gameStarted ? '' : 'TAP TO PLAY',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ));
  }
}
