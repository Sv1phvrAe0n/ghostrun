import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghost_run/bottom_screen.dart';
import 'package:ghost_run/providers/level_params.dart';
import 'package:ghost_run/providers/score.dart';
import 'package:ghost_run/visuals/ghost.dart';
import 'package:ghost_run/visuals/obstacles.dart';
import 'package:ghost_run/visuals/styles.dart';
import 'main.dart';
import 'notifications.dart';
import 'package:provider/provider.dart';

class NewLevel extends StatefulWidget {
  const NewLevel({Key? key}) : super(key: key);

  @override
  _NewLevelState createState() => _NewLevelState();
}

class _NewLevelState extends State<NewLevel> {

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
  bool passedObstacle = false;

  List<double> obstacleX = LevelParams().level1Gap;
  List<List<double>> barrierHeight = LevelParams().level1Size;


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
      gotReward();

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
          passedObstacle = false;
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
                '\nY axis UP: ${ghostY} = barrier height ${barrierHeight[i][0]}'
                '\nY axis DOWN: ${ghostY} = barrier height ${barrierHeight[i][1]}'
            );
            return true;
          }
      }
    return false;
  }

  gotReward() {
    for(int i = 0; i < obstacleX.length; i++) {
      if(obstacleX[i] < ghostX && passedObstacle == false) {
        passedObstacle = true;
        context.read<Score>().increment();
      } else {
        context.read<Score>().leave();
      }
    }

  }

  void resetGame() {
    setState(() {
      ghostY = 0;
      gameHasStarted = false;
      time = 0;
      initialPosition = ghostY;
      obstacleX = LevelParams().level1Gap;
    });
    context.read<Score>().reset();
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
            BottomScreen(),
          ],
        ),
      ),
    );
  }


  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: Colors.brown,
            title: Center(
              child: Text("GAME OVER", style: mediumAlert,
              ),
            ),
            actions: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            backgroundColor: Colors.brown.shade300,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/newgame');
                            resetGame();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text('WATCH AD TO RESTART', style: smallAlert),
                          )
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
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
                  ),
                ],
              ),
            ],
          );
        });
  }
}
