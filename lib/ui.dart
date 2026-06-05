import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import "rigel.dart";

class Ui extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Row(
        children: [
          Expanded(
            child: GameWidget(game: Rigel()),
          ),
          Text("teeeste"),
        ],
      );
  }
}
