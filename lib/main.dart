import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'newgame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp( routes: {
      '/newgame': (context) => NewGame(),
      '/homepage': (context) => HomePage(),
    },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

