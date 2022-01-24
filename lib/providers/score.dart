
import 'package:flutter/material.dart';
import 'package:ghost_run/newgame.dart';
import 'package:ghost_run/providers/level_params.dart';

class Score with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {

      _count += 1;
      notifyListeners();
  }

  void leave() {
      _count += 0;
      notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }

}