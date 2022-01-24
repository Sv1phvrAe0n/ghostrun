import 'package:flutter/material.dart';
import 'package:ghost_run/providers/score.dart';
import 'package:ghost_run/visuals/reward.dart';
import 'package:provider/src/provider.dart';

class Obstacle extends StatefulWidget {
  final obstacleX;
  final List<double> height;

  Obstacle({this.obstacleX, required this.height});

  @override
  State<Obstacle> createState() => _ObstacleState();
}

class _ObstacleState extends State<Obstacle> {

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment(widget.obstacleX, 0),
        // alignment: Alignment((2 * obstacleX + obstacleWidth) / (2 - obstacleWidth), 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100.0,
            height:  MediaQuery.of(context).size.height * 3 / 4 * widget.height[0] / 2,
            decoration: BoxDecoration(
                color: Color(0xff5C4749),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
            ),
          ),
          Container(
            width: 100.0,
            height: MediaQuery.of(context).size.height * 3 / 4 * widget.height[1] / 2,
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
