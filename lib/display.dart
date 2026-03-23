import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Display extends Component {

  double width = 0;
  double height = 0;
  double pixelSize = 10;

  late List<List<bool>> display;

  Display(this.width, this.height, this.display);


  @override
  void render(Canvas canvas){

    final paint = Paint();

    for(int i = 0; i < 32; i++){
      for(int j = 0; j < 64; j++){

        paint.color = display[i][j] == true ? const Color(0x00000000) : const Color(0xFFFFFFFF);

        canvas.drawRect(Rect.fromLTWH(j * pixelSize, i * pixelSize, pixelSize, pixelSize), paint);

      }
    }
  }
}
