import 'dart:async';

import 'package:flappy_bird_3/barriers.dart';
import 'package:flappy_bird_3/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double heigh = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.5;
      heigh = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - heigh;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (gameHasStarted) {
                        jump();
                      } else {
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text(" ")
                        : Text(
                            " T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(0, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  )
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SCORE",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "BEST",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
