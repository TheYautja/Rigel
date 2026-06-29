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
        keys[id] = !keys[id];
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
                                GestureDetector(onTapDown: (_) => click(0), child: Expanded(child: Text("1"))),
                                GestureDetector(onTapDown: (_) => click(4), child: Expanded(child: Text("A"))),
                                GestureDetector(onTapDown: (_) => click(8), child: Expanded(child: Text("E"))),
                                GestureDetector(onTapDown: (_) => click(12), child: Expanded(child: Text("I"))),
                            ]),
                            Column(children:[
                                GestureDetector(onTapDown: (_) => click(1), child: Expanded(child: Text("2"))),
                                GestureDetector(onTapDown: (_) => click(5), child: Expanded(child: Text("B"))),
                                GestureDetector(onTapDown: (_) => click(9), child: Expanded(child: Text("F"))),
                                GestureDetector(onTapDown: (_) => click(13), child: Expanded(child: Text("J"))),
                            ]),
                        ],
                    ),
                    Expanded( child :GameWidget(game: rigel)),
                    Row(
                        children: [
                            Column(children:[
                                GestureDetector(onTapDown: (_) => click(2), child: Expanded(child: Text("3"))),
                                GestureDetector(onTapDown: (_) => click(6), child: Expanded(child: Text("C"))),
                                GestureDetector(onTapDown: (_) => click(10), child: Expanded(child: Text("G"))),
                                GestureDetector(onTapDown: (_) => click(14), child: Expanded(child: Text("K"))), 
                            ]),
                            Column(children:[
                                GestureDetector(onTapDown: (_) => click(3), child: Expanded(child: Text("4"))),
                                GestureDetector(onTapDown: (_) => click(7), child: Expanded(child: Text("D"))),
                                GestureDetector(onTapDown: (_) => click(11), child: Expanded(child: Text("H"))),
                                GestureDetector(onTapDown: (_) => click(15), child: Expanded(child: Text("L"))),
                            ]),
                        ],

                    ),

                ]

            );

        });

    }

}
