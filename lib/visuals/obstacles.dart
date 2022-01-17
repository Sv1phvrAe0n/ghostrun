import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghost_run/visuals/shroom.dart';

class Obstacle extends StatelessWidget {
  final obstacleX;
  final List<double> height;

  Obstacle({this.obstacleX, required this.height});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment(obstacleX, 0),
        // alignment: Alignment((2 * obstacleX + obstacleWidth) / (2 - obstacleWidth), 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100.0,
            height:  MediaQuery.of(context).size.height * 3 / 4 * height[0] / 2,
            decoration: BoxDecoration(
                color: Color(0xff5C4749),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
            ),
          ),
          Container(
            height: 30,
              child: height[0] > 0.5 ? Image.asset(
                'lib/images/shroom.png',
                // height: MediaQuery.of(context).size.height * 3 / 3.5 * 0.2 / 2,
                // width: MediaQuery.of(context).size.width * 0.2 / 2,
                fit: BoxFit.fill,
              ) : SizedBox(height: 0, width: 0,)),
          Container(
            width: 100.0,
            height: MediaQuery.of(context).size.height * 3 / 4 * height[1] / 2,
            decoration: BoxDecoration(
                color: Color(0xff5C4749),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
        ],
      ),
    );
  }
}
