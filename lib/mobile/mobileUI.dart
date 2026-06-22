import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "../chip8/rigel.dart";
import "accelerometertest.dart";
import "inputButton.dart";


class MobileUI extends StatelessWidget{

    @override
    Widget build(BuildContext context){

        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        double dWidth = width / 1.2;
        double dHeight = height / 1.2;
    
        double pixelWidth = dWidth/64;
        double pixelHeight = dHeight/32;

        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){

         return Row(
            children: [
                Row(
                    children: [
                        Column(children:[InputButton("1", 1), InputButton("2", 2), InputButton("3", 3), InputButton("4", 4),]),
                        Column(children:[InputButton("A", 5), InputButton("B", 6), InputButton("C", 7), InputButton("D", 8),]),
                    ],
                ),
                GameWidget(game: Rigel(dWidth, dHeight, pixelWidth, pixelHeight)),
                Row(
                    children: [
                        Column(children:[InputButton("E", 9), InputButton("F", 10), InputButton("G", 11), InputButton("H", 12),]),
                        Column(children:[InputButton("I", 13), InputButton("J", 14), InputButton("K", 15), InputButton("L", 16),]),
                    ],
                ),
            ]
        );



        });

    }

}
