import "dart:async";
import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";



class Acc extends StatefulWidget {

    @override 
    State<Acc> createState() => _AccState();

}


class _AccState extends State<Acc> {

    double x = 0;

    @override 
    void initState() {
        super.initState();

        accelerometerEventStream().listen((event) {
            setState((){
                x = event.x;
            });
        });

    }


    @override 
    Widget build(BuildContext context){
        return Text(x.toString());
    }

}
