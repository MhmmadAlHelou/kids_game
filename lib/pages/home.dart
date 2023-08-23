import 'dart:math';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  var player = AudioCache();
  Map<String, bool> score = {};
  Map<String, Color> choices = {
    '🍎': Colors.red,
    '📗': Colors.green,
    '☄️': Colors.blue,
    '🌻': Colors.yellow,
    '🍊': Colors.orange,
    '🍆': Colors.purple,
    //'🤎': Colors.brown,
  };
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your scors')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((e) {
                return Expanded(
                    child: Draggable<String>(
                  data: e,
                  child: Movable(score[e] == true ? '✔️' : e),
                  feedback: Movable(e),
                  childWhenDragging: Movable('🐰'),
                ));
              }).toList(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: choices.keys.map((e) {
                return buildTarget(e);
              }).toList()
                ..shuffle(Random(index)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            index++;
          });
        },
      ),
    );
  }

  Widget buildTarget(element) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        if (score[element] == true) {
          return Container(
            color: Colors.white,
            child: const Text('Congratulations!'),
            alignment: Alignment.center,
            height: 60,
            width: 200,
          );
        } else {
          return Container(
            color: choices[element],
            height: 60,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          score[element] = true;
          // player.play('clap.wav');
        });
      },
      onLeave: (data) {},
    );
  }
}

class Movable extends StatelessWidget {
  final String emoji;
  const Movable(this.emoji, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: const EdgeInsets.all(15),
        child: Text(emoji,
            style: const TextStyle(fontSize: 30, color: Colors.black)),
      ),
    );
  }
}
