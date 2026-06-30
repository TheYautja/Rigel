import "package:flutter/material.dart";


class chip8Button extends StatelessWidget {

    late String title; 

    chip8Button(this.title);

    Widget build(BuildContext context){
       return SizedBox(
            width: 50,
            height: 50,
            child: Card(
                color: Colors.white,
                child: Text(title),
            ),
        ); 
    }
}
