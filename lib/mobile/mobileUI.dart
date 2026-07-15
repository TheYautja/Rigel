import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';

import "../chip8/rigel.dart";
import "accelerometertest.dart";
import "chip8Button.dart";

class MobileUI extends StatelessWidget {

    static String rom = "roms/games/Space Invaders [David Winter].ch8";

    static Future<List<String>> getRoms() async{

        final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);

        return manifest.listAssets().where((path){
            return path.startsWith("roms/games/") &&
                   path.endsWith(".ch8");
        }).toList()..sort();
    }

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

    void selectRom(BuildContext context, String newRom){
        rom = newRom;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => MobileUI(),
            ),
        );
    }

    @override
    Widget build(BuildContext context){

            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            double dWidth = width/1.8;
            double dHeight = height/1.8;

            double pixelWidth = dWidth/64;
            double pixelHeight = dHeight/32;

            double bW = width * 0.4 / 4;
            double bH = height * 0.4 / 4;

            rigel = Rigel(dWidth, dHeight, pixelWidth, pixelHeight, rom, keys);

            if(rom == "roms/games/Space Invaders [David Winter].ch8"){
                acc.start();
            }

            return Scaffold(
                backgroundColor: Color(0xFF202124),
                appBar: AppBar(
                    toolbarHeight: 7,
                    backgroundColor: const Color(0xFFa3a3a3) ,
                    title: Text(" "),
                    actions: [
                        FutureBuilder<List<String>>(
                            future: getRoms(),
                            builder: (context, snapshot){

                                if(!snapshot.hasData){
                                    return SizedBox();
                                }

                                return PopupMenuButton<String>(
                                    icon: Icon(Icons.folder_open),
                                    onSelected: (value) => selectRom(context, value),
                                    itemBuilder: (context) => snapshot.data!.map((path){

                                        String name = path
                                            .split("/")
                                            .last
                                            .replaceAll(".ch8", "");

                                        return PopupMenuItem<String>(
                                            value: path,
                                            child: Text(name),
                                        );
                                    }).toList(),
                                );
                            },
                        ),
                        IconButton(
                            onPressed: null,
                            icon: Icon(Icons.settings),
                        ),
                    ],
                ),
                body: Row(
                    children: [
                        Row(
                            children: [
                                Column(children:[
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(0),  onTapUp: (_) => clear(0),  child: chip8Button("1", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(4),  onTapUp: (_) => clear(4),  child: chip8Button("A", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(8),  onTapUp: (_) => clear(8),  child: chip8Button("E", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(12), onTapUp: (_) => clear(12), child: chip8Button("I", bW, bH))),
                                ]),
                                Column(children:[
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(1),  onTapUp: (_) => clear(1),  child: chip8Button("2", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(5),  onTapUp: (_) => clear(5),  child: chip8Button("B", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(9),  onTapUp: (_) => clear(9),  child: chip8Button("F", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(13), onTapUp: (_) => clear(13), child: chip8Button("J", bW, bH))),
                                ]),
                            ],
                        ),
                        Expanded(
                            child: SizedBox(
                                width: dWidth,
                                height: dHeight,
                                child: GameWidget(game: rigel),
                            ),
                        ),
                        Row(
                            children: [
                                Column(children:[
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(2),  onTapUp: (_) => clear(2),  child: chip8Button("3", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(6),  onTapUp: (_) => clear(6),  child: chip8Button("C", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(10), onTapUp: (_) => clear(10), child: chip8Button("G", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(14), onTapUp: (_) => clear(14), child: chip8Button("K", bW, bH))),
                                ]),
                                Column(children:[
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(3),  onTapUp: (_) => clear(3),  child: chip8Button("4", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(7),  onTapUp: (_) => clear(7),  child: chip8Button("D", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(11), onTapUp: (_) => clear(11), child: chip8Button("H", bW, bH))),
                                    Expanded(child: GestureDetector(onTapDown: (_) => click(15), onTapUp: (_) => clear(15), child: chip8Button("L", bW, bH))),
                                ]),
                            ],
                        ),
                    ]
                )
            );
    }
}
