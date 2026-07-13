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
                elevation: 8,
                shadowColor: Colors.black54,
                color: const Color(0xFF3A3A3A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(
                        color: Color(0xFF5A5A5A),
                        width: 1.5,
                    ),
                ),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                                Color(0xFF555555),
                                Color(0xFF2F2F2F),
                            ],
                        ),
                    ),
                    child: Center(
                        child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                            ),
                        ),
                    ),
                ),
            ),
        ); 
    }
}
