import 'package:flutter/material.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

import "desktop/desktopUI.dart";

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    setWindowTitle('Rigel');

    //const size = Size(1152, 576);

    //setWindowMinSize(size);
    //setWindowMaxSize(size);
  }

	runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints){
                
                if(constraints.maxWidth < 600){
                    return MobileUI();
                } else if (constraints.maxWidth > 1200){
                    return DesktopUI();
                } else {
                    return Text("Soon :D");
                }

            }
        ),
      ),
    ),
  );
}
