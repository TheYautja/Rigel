import 'package:flutter/material.dart';
import 'dart:io';

import "desktop/desktopUI.dart";
import "mobile/mobileUI.dart";

void main() {

  WidgetsFlutterBinding.ensureInitialized();


	runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints){
                
                if(Platform.isAndroid | Platform.isIOS){
                    return MobileUI();
               } else {
                    return DesktopUI();
                }

            }
        ),
      ),
    ),
  );
}
