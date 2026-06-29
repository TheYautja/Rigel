import "package:flutter/material.dart";


class chip8Button extends StatelessWidget {

    late String title; 

    chip8Button(this.title);

    Widget build(BuildContext context){
       return ElevatedButton(
            onPressed: (){},
            child: Text(title),
        ); 
    }
}
