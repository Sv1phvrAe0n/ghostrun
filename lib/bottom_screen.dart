import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghost_run/newgame.dart';
import 'package:ghost_run/providers/score.dart';
import 'package:ghost_run/visuals/styles.dart';
import 'package:provider/src/provider.dart';

class BottomScreen extends StatefulWidget {


  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: Colors.brown,
        child: Row(
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text('SCORE:${context.watch<Score>().count}',
                  style: smallAlert),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text('BEST:60',
                  style: smallAlert),
            ),
          ],
        ),
      ),
    );
  }
}
