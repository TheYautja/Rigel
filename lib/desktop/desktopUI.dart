import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "../chip8/rigel.dart";

class DesktopUI extends StatelessWidget {

  List<bool> keys = List.filled(16, false);

  @override
  Widget build(BuildContext context){

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;   
    double pixelWidth = width/64;
    double pixelHeight = height/32;

    return Scaffold(
        appBar: AppBar(),
        body: GameWidget(game: Rigel(width, height, pixelWidth, pixelHeight, "roms/games/Space Invaders [David Winter].ch8", keys)),
    );
  }
}
