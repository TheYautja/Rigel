import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:io';

import "../chip8/rigel.dart";
import "accelerometertest.dart";
import "chip8Button.dart";



class MobileUI extends StatelessWidget {
    
    String rom = "roms/games/Space Invaders [David Winter].ch8";
    late Rigel rigel;
    late final Acc acc = Acc(
        click: click,
        clear: clear,
    );
    List<bool> keys = List.filled(16, false);


    void click(int id){
        keys[id] = true;
        rigel.update_keys(keys);
    }

    void clear(int id){
        keys[id] = false;
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

            rigel = Rigel(dWidth, dHeight, pixelWidth, pixelHeight, rom, keys);

            if(rom == "roms/games/Space Invaders [David Winter].ch8"){
                acc.start();
            }

            return Row(
                children: [
                    Row(
                        children: [
                            Column(children:[
                                Expanded( child: GestureDetector(onTapDown: (_) => click(0),  onTapUp: (_) => clear(0),  child: chip8Button("1"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(4),  onTapUp: (_) => clear(4),  child: chip8Button("A"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(8),  onTapUp: (_) => clear(8),  child: chip8Button("E"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(12), onTapUp: (_) => clear(12), child: chip8Button("I"))),
                            ]),
                            Column(children:[
                                Expanded( child: GestureDetector(onTapDown: (_) => click(1),  onTapUp: (_) => clear(1),  child: chip8Button("2"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(5),  onTapUp: (_) => clear(5),  child: chip8Button("B"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(9),  onTapUp: (_) => clear(9),  child: chip8Button("F"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(13), onTapUp: (_) => clear(13), child: chip8Button("J"))),
                            ]),
                        ],
                    ),
                    Expanded( child :GameWidget(game: rigel)),
                    Row(
                        children: [
                            Column(children:[
                                Expanded( child: GestureDetector(onTapDown: (_) => click(2),  onTapUp: (_) => clear(2),  child: chip8Button("3"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(6),  onTapUp: (_) => clear(6),  child: chip8Button("C"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(10), onTapUp: (_) => clear(10), child: chip8Button("G"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(14), onTapUp: (_) => clear(14), child: chip8Button("K"))), 
                            ]),
                            Column(children:[
                                Expanded( child: GestureDetector(onTapDown: (_) => click(3),  onTapUp: (_) => clear(3),  child: chip8Button("4"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(7),  onTapUp: (_) => clear(7),  child: chip8Button("D"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(11), onTapUp: (_) => clear(11), child: chip8Button("H"))),
                                Expanded( child: GestureDetector(onTapDown: (_) => click(15), onTapUp: (_) => clear(15), child: chip8Button("L"))),
                            ]),
                        ],
                    ),
                ]
            );
        });
    }
}
