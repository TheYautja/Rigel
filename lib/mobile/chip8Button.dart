import "package:flutter/material.dart";


class chip8Button extends StatelessWidget {

    late String title; 
    late double width;
    late double height;

    chip8Button(this.title, this.width, this.height);

    Widget build(BuildContext context){
       return SizedBox(
            width: width,
            height: height,
            child: Card(
                color: Colors.white,
                child: Center(child: Text(title)),
            ),
        ); 
    }
}
