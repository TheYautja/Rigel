import 'package:flutter/material.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

import "ui.dart";

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
      home: Scaffold(
        body: Ui(),
      ),
    ),
  );
}
