import 'package:flutter/material.dart';

class TheGhost extends StatelessWidget {
  final double ghostX;
  final double ghostY;
  final double ghostHeight;
  final double ghostWidth;

  TheGhost({required this.ghostX,
            required this.ghostY,
            required this.ghostHeight,
            required this.ghostWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ghostX, ghostY),
      child: Image.asset(
          'lib/images/ghost.png',
          height: MediaQuery.of(context).size.height * 3 / 3.5 * ghostHeight / 2,
          width: MediaQuery.of(context).size.width * ghostWidth / 2,
          fit: BoxFit.fill,
      ));
  }
}
