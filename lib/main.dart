import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghost_run/providers/score.dart';
import 'package:ghost_run/providers/level_params.dart';
import 'homepage.dart';
import 'newgame.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
    // ChangeNotifierProvider(create: (_) => LevelParams()),
    ChangeNotifierProvider(create: (_) => Score()),
  ],
    child: MyApp(),)
      );
  // runApp(MyApp());
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
      '/newgame': (context) => NewLevel(),
      '/homepage': (context) => HomePage(),
    },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

