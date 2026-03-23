import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/camera.dart';
import 'package:flame/events.dart';

import 'device.dart';

class Rigel extends FlameGame with TapCallbacks {

  Device d = new Device();

  @override
  Future<void> onLoad() async {
    d.init();
  }


  void generate_display(){

  }


}
