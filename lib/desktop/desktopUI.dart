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
    double dWidth = width / 1.2;
    double dHeight = height / 1.2;
    
    double pixelWidth = dWidth/64;
    double pixelHeight = dHeight/32;

    return Row(
        children: [
            Expanded(
                child: GameWidget(game: Rigel(dWidth, dHeight, pixelWidth, pixelHeight, "roms/games/Space Invaders [David Winter].ch8", keys)),
            ),
        ]
    );
  }
}
