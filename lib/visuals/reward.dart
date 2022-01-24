import 'package:flutter/material.dart';
import 'package:ghost_run/providers/score.dart';
import 'package:provider/src/provider.dart';

import 'obstacles.dart';

class Reward extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        child: Image.asset(
          'lib/images/shroom.png',
          fit: BoxFit.fill,
        )
    );
  }
}
