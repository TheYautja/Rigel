import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Display extends Component {

  double width;
  double height;
  double pixelWidth;
  double pixelHeight;

  late List<List<bool>> display;

  Display(this.width, this.height, this.display, this.pixelWidth, this.pixelHeight);

  @override
  void render(Canvas canvas){

    final paint = Paint();

    for(int i = 0; i < 32; i++){
      for(int j = 0; j < 64; j++){

        paint.color = display[i][j] == true ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

        canvas.drawRect(Rect.fromLTWH(j * pixelWidth, i * pixelHeight, pixelWidth, pixelHeight), paint);

      }
    }
  }
}
