import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import "dart:io";

import "desktop/desktopUI.dart";
import "mobile/mobileUI.dart";

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

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
