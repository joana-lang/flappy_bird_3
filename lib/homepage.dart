import 'dart:async';

import 'package:flappy_bird_3/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  double time = 0;
  double heigh = 0;
  double initialHeight = 0;

  void jump() {
    initialHeight = birdYaxis;
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      time += 0.3;
      heigh = -4.9 * time * time + 5 * time;
      setState(() {
        birdYaxis = initialHeight - heigh;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: jump,
              child: AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                duration: Duration(milliseconds: 0),
                color: Colors.blue,
                child: MyBird(),
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
