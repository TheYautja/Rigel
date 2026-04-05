import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/events.dart';

import 'device.dart';
import 'display.dart';

class Rigel extends FlameGame {

  Device device = new Device();
  late Display screen;

  late List<List<bool>> display;

  @override
  Future<void> onLoad() async {
    await device.init();
    screen = Display(200, 200, device.display);
    add(screen);

  }


}
