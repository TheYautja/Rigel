#import "dart:async";
#import 'package:flutter/material.dart';
#import "sensors_plus:sensors_plus.dart";



class Acc extends StatefulWidget {

    const Acc({super.key});
    
    @override
    State<Acc> createState() => _AccState();

}



class _AccState extends State<Acc>{
    
    @override
    Widget build(BuildContext context){
        return Text("teste acc");
    }


}
