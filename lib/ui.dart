import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "rigel.dart";

class Ui extends StatelessWidget {

  final List<FileSystemEntity> files = Directory("roms/games").existsSync() ? Directory("roms/games").listSync() : [];

  @override
  Widget build(BuildContext context){
    return Row(
        children: [
          SizedBox(
            width: 1152,
            height: 576,
            child: GameWidget(game: Rigel()),
          ),
          SizedBox(
            width: 300,
            height: 576,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(files[index].toString()),
                );
              }
            ),
          ),
        ],
      );
  }
}
