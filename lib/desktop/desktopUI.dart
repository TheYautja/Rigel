import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:file_picker/file_picker.dart';

import "../chip8/rigel.dart";

class DesktopUI extends StatelessWidget {
  DesktopUI({super.key});

  static String rom = "roms/games/Space Invaders [David Winter].ch8";

  final List<bool> keys = List.filled(16, false);

  Future<void> pickRom(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ch8'],
    );

    if (result == null) return;

    rom = result.files.single.path!;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DesktopUI(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double pixelWidth = width / 64;
    final double pixelHeight = height / 32;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chip8"),
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton.icon(
            onPressed: () => pickRom(context),
            icon: const Icon(Icons.folder_open),
            label: const Text("Open ROM"),
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            tooltip: "Menu",
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: "teste",
                child: Row(
                  children: [
                    Icon(Icons.restart_alt),
                    SizedBox(width: 12),
                    Text("Reset"),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GameWidget(game: Rigel(width, height, pixelWidth, pixelHeight, rom, keys)),
    );
  }
}
