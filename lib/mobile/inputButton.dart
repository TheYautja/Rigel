import "package:flutter/material.dart";


class InputButton extends StatelessWidget {

    String title = " ";
    int id = 0;

    InputButton(this.title, this.id);

    Widget build(BuildContext context){

        return Expanded(
            child: 
                ElevatedButton(
                    onPressed: () {},
                    child: Text(title),
                ),
        );
    }
}
