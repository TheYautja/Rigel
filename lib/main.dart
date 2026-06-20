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
                
                if(Platform.isAndroid){
                    return MobileUI();
               } else if (Platform.isLinux | Platform.isMacOS | Platform.isMacOS){
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
