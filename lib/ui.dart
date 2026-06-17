import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "rigel.dart";

class Ui extends StatelessWidget {

  @override
  Widget build(BuildContext context){ //list lagging a little, see later

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double dWidth = width / 2;
    double dHeight = height / 2;
    
    double pixelWidth = dWidth/64;
    double pixelHeight = dHeight/32;

    return Row(
        children: [
            Expanded(
                child: GameWidget(game: Rigel(dWidth, dHeight, pixelWidth, pixelHeight)),
            ),
        ]
    );
  }
}
