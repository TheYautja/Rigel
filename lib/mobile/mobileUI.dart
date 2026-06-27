import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "../chip8/rigel.dart";
import "accelerometertest.dart";
import "inputButton.dart";



class MobileUI extends StatelessWidget {

    late Rigel rigel;
    Acc accelerometer = Acc();
    List<bool> keys = List.filled(16, false);


    void click(int id){ //currently sets to 1 permanently, use a gestureDetector later?
        keys[id] = true;
        rigel.update_keys(keys);
    }

    @override
    Widget build(BuildContext context){

        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){

            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
            double dWidth = width/1.5;
            double dHeight = height/1.5;

            double pixelWidth = dWidth/64;
            double pixelHeight = dHeight/32;

            rigel = Rigel(dWidth, dHeight, pixelWidth, pixelHeight, "roms/games/Space Invaders [David Winter].ch8", keys);

            //if(incl > 4) click(1);
            //if(incl < -4) click(2);

            return Row(
                children: [
                    Row(
                        children: [
                            Column(children:[
                                ElevatedButton(child: Text("1"), onPressed: () => click(0)),
                                ElevatedButton(child: Text("A"), onPressed: () => click(4)),
                                ElevatedButton(child: Text("E"), onPressed: () => click(8)),
                                ElevatedButton(child: Text("I"), onPressed: () => click(12)),
                            ]),
                            Column(children:[
                                ElevatedButton(child: Text("2"), onPressed: () => click(1)),
                                ElevatedButton(child: Text("B"), onPressed: () => click(5)),
                                ElevatedButton(child: Text("F"), onPressed: () => click(9)),
                                ElevatedButton(child: Text("J"), onPressed: () => click(13)),
                            ]),
                        ],
                    ),
                    Expanded( child :GameWidget(game: rigel)),
                    Row(
                        children: [
                            Column(children:[
                                ElevatedButton(child: Text("3"), onPressed: () => click(2)),
                                ElevatedButton(child: Text("C"), onPressed: () => click(6)),
                                ElevatedButton(child: Text("G"), onPressed: () => click(10)),
                                ElevatedButton(child: Text("K"), onPressed: () => click(14)),
                            ]),
                            Column(children:[
                                ElevatedButton(child: Text("4"), onPressed: () => click(3)),
                                ElevatedButton(child: Text("D"), onPressed: () => click(7)),
                                ElevatedButton(child: Text("H"), onPressed: () => click(11)),
                                ElevatedButton(child: Text("L"), onPressed: () => click(15)),
                            ]),
                        ],

                    ),

                ]

            );

        });

    }

}
