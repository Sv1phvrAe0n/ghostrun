import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ghost_run/visuals/ghost.dart';
import 'package:ghost_run/visuals/obstacles.dart';
import 'package:ghost_run/visuals/shroom.dart';
import 'package:ghost_run/visuals/styles.dart';
import 'main.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewGame> {

  static double ghostY = 0;
  double initialPosition = ghostY;
  double height = 0;
  double time = 0;
  double gravity = -2.3;
  double velocity = 1.5;
  double ghostHeight = 0.2;
  double ghostWidth = 0.1;
  bool gameHasStarted = false;
  final ghostX = -0.5;

  static List<double> obstacleX = [1.5, 2.15, 2.75, 3.35, 3.95];

  List<List<double>> barrierHeight = [
    [0.25, 0.85],
    [0.85, 0.25],
    [0.75, 0.35],
    [0.35, 0.75],
    [0.95, 0.1],
    [0.1, 0.95],
  ];


  void startGame() {
    barrierHeight.shuffle();
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {

      height = gravity * time * time + velocity * time;
      setState(() {
        ghostY = initialPosition - height;
      });

      if(ghostHits()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      moveMap();

      time+= 0.01;
    });
  }

  void moveMap() {
    for(int i = 0; i < obstacleX.length; i++) {
        setState(() {
          obstacleX[i] -= 0.004;
        });

        if(obstacleX[i] < -1.5) {//Луп когда препятствие уходит из экрана
          obstacleX[i] += 3;
          barrierHeight[i].shuffle();
        }
    }
  }


  void jump() {
    setState(() {
      time = 0;
      initialPosition = ghostY;
    });
  }

  bool ghostHits() {
    if(ghostY < -1 || ghostY > 1) {
      print('ghost hit lines');
     return true;
    }

      for(int i = 0; i < obstacleX.length; i++) {
          if ((obstacleX[i] - 0.25 <= ghostX && ghostX <= obstacleX[i] + 0.25)
              && ghostX + ghostWidth*1.5 >= obstacleX[i]
              && (1 + ghostY <= barrierHeight[i][0] || ghostY >= 1 - barrierHeight[i][1]))
              {
            print('X axis: ${ghostX + ghostWidth*2} = ${obstacleX[i]}'
                '\nY axis UP: ${1 + ghostY} = barrier height ${barrierHeight[i][0]}'
                '\nY axis DOWN: ${ghostY} = barrier height ${1 - barrierHeight[i][1]}'
            );
            return true;
          }
      }
    return false;
  }

  void resetGame() {
    setState(() {
      ghostY = 0;
      gameHasStarted = false;
      time = 0;
      initialPosition = ghostY;
      obstacleX = [1.5, 2.15, 2.75, 3.25, 3.95];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text("GAME OVER", style: mediumAlert,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    backgroundColor: Colors.brown.shade300,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                    resetGame();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text('EXIT', style: smallAlert),
                  )
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    backgroundColor: Colors.brown.shade300,
                  ),
                  onPressed:  () {
                    Navigator.pop(context);
                    resetGame();
                    },
                  child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text('PLAY AGAIN', style: smallAlert),
                        )
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                  color: Colors.brown.shade300,
                  child: Stack(
                    children: [
                      TheGhost(
                        ghostX: ghostX,
                        ghostY: ghostY,
                        ghostHeight: ghostHeight,
                        ghostWidth: ghostWidth,
                      ),
                      Obstacle(
                        obstacleX: obstacleX[0],
                        height: barrierHeight[0],
                      ),
                      Obstacle(
                        obstacleX: obstacleX[1],
                        height: barrierHeight[1],
                      ),
                      Obstacle(
                        obstacleX: obstacleX[2],
                        height: barrierHeight[2],
                      ),
                      Obstacle(
                        obstacleX: obstacleX[3],
                        height: barrierHeight[3],
                      ),
                      Obstacle(
                        obstacleX: obstacleX[4],
                        height: barrierHeight[4],
                      ),
                      Container(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'TAP TO START',
                            style: mainAlert,)
                      ),
                    ],
                  ),
              ),
            ),
            Expanded(
              child: Container(color: Colors.brown),
            )
          ],
        ),
      ),
    );
  }
}
