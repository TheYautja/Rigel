import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "rigel.dart";

class Ui extends StatelessWidget {

//final List<FileSystemEntity> files = Directory("roms/games").existsSync() ? Directory("roms/games").listSync() : [];

  @override
  Widget build(BuildContext context){ //list lagging a little, see later
    return Row(
        children: [
            Expanded(
                child: GameWidget(game: Rigel()),
            ),
        ]
    );
  }
}
