import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:typed_data';

class Display extends Component {

  double width;
  double height;
  double pixelWidth;
  double pixelHeight;

  final Uint8List display;


  static final black = Paint()..color = const Color(0xFF000000);
  static final white = Paint()..color = const Color(0xFFFFFFFF);


  Display(this.width, this.height, this.display, this.pixelWidth, this.pixelHeight);

  @override
  void render(Canvas canvas){

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), black);

    for(int i = 0; i < 32; i++){
      for(int j = 0; j < 64; j++){

        if(display[i * 64 + j] == 0)continue;

        canvas.drawRect(Rect.fromLTWH(j * pixelWidth, i * pixelHeight, pixelWidth, pixelHeight), white);

      }
    }
  }
}
