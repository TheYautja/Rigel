import 'package:flame/game.dart';
import 'package:flutter/services.dart';

import 'device.dart';
import 'display.dart';

class Rigel extends FlameGame {


  List<bool> keys = List.filled(16, false);
  String rom = " ";
  late final Device device = Device(rom, keys);
  late Display screen;
  double timerAcc = 0.0;
  static const double timerStep = 1 / 60;

  double width = 0;
  double height = 0;
  double pixelWidth = 0;
  double pixelHeight = 0;

  Rigel(this.width, this.height, this.pixelWidth, this.pixelHeight, this.rom, this.keys);


  static final Map<LogicalKeyboardKey, int> keyMap = {
    LogicalKeyboardKey.digit1: 0x1,
    LogicalKeyboardKey.digit2: 0x2,
    LogicalKeyboardKey.digit3: 0x3,
    LogicalKeyboardKey.digit4: 0xC,

    LogicalKeyboardKey.keyQ: 0x4,
    LogicalKeyboardKey.keyW: 0x5,
    LogicalKeyboardKey.keyE: 0x6,
    LogicalKeyboardKey.keyR: 0xD,

    LogicalKeyboardKey.keyA: 0x7,
    LogicalKeyboardKey.keyS: 0x8,
    LogicalKeyboardKey.keyD: 0x9,
    LogicalKeyboardKey.keyF: 0xE,

    LogicalKeyboardKey.keyZ: 0xA,
    LogicalKeyboardKey.keyX: 0x0,
    LogicalKeyboardKey.keyC: 0xB,
    LogicalKeyboardKey.keyV: 0xF,
  };



  @override
  Future<void> onLoad() async {
    await device.init();

    screen = Display(
      width,
      height,
      device.display,
      pixelWidth,
      pixelHeight,
    );

    add(screen);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final keyboard = HardwareKeyboard.instance;

    for (final entry in keyMap.entries) {
      keys[entry.value] =
          keyboard.isLogicalKeyPressed(entry.key);
    }



    for (int i = 0; i < 10; i++) {
      device.cycle();
    }

    timerAcc += dt;

    while (timerAcc >= timerStep) {
      device.update_timers();
      timerAcc -= timerStep;
    }
  }
}

