import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghost_run/visuals/ghost.dart';
import 'package:ghost_run/visuals/styles.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  backgroundColor: Colors.brown,
                ),
                  onPressed: () {Navigator.pushNamed(context, '/newgame');} ,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text('NEW GAME', style: mediumAlert),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                  onPressed: () {Navigator.pushNamed(context, '/newgame');} ,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text('RESUME GAME', style: mediumAlert),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                  onPressed: () {Navigator.pushNamed(context, '/newgame');} ,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text('SETTINGS', style: mediumAlert),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
