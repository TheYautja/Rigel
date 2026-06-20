import 'dart:typed_data';
import 'dart:io';
import 'dart:math';
import "package:flutter/services.dart";


class Device {
	
    String rom = "roms/games/Merlin [David Winter].ch8";
	Uint8List memory = Uint8List(4096);
	static const int ROM_START = 0x200;
	int PC = ROM_START;
	int I = 0;
    int SP = 0;
	Uint16List stack = Uint16List(16);
	int delayTimer = 0;
    int soundTimer = 0;
	Uint8List registers = Uint8List(16);
	Uint8List display = Uint8List(64 * 32);
    List<bool> keys = List.filled(16, false);
	

  Future<void> init () async {
    await get_rom();
    await load_font_into_memory();
    await load_rom_into_memory();
  }


  Future<Uint8List> get_rom() async {
    
    if(Platform.isAndroid){
        ByteData romData = await rootBundle.load(rom);
        return romData.buffer.asUint8List(romData.offsetInBytes, romData.lengthInBytes);
    }else {
    	return await File(rom).readAsBytes();
    }

  }


  void update_timers(){
    if (delayTimer > 0 ) delayTimer--;
    if (soundTimer > 0) {
      soundTimer--;
      //play smthng;
    };
  }


  void cycle(){
    decode_opcode();
  }


  void keyDown(LogicalKeyboardKey key) {
    switch (key.keyLabel.toUpperCase()) {

      case '1': keys[0x1] = true; break;
      case '2': keys[0x2] = true; break;
      case '3': keys[0x3] = true; break;
      case '4': keys[0xC] = true; break;
      case 'Q': keys[0x4] = true; break;
      case 'W': keys[0x5] = true; break;
      case 'E': keys[0x6] = true; break;
      case 'R': keys[0xD] = true; break;
      case 'A': keys[0x7] = true; break;
      case 'S': keys[0x8] = true; break;
      case 'D': keys[0x9] = true; break;
      case 'F': keys[0xE] = true; break;
      case 'Z': keys[0xA] = true; break;
      case 'X': keys[0x0] = true; break;
      case 'C': keys[0xB] = true; break;
      case 'V': keys[0xF] = true; break;

    }
  }


  void keyUp(LogicalKeyboardKey key) {
    switch (key.keyLabel.toUpperCase()) {

      case '1': keys[0x1] = false; break;
      case '2': keys[0x2] = false; break;
      case '3': keys[0x3] = false; break;
      case '4': keys[0xC] = false; break;
      case 'Q': keys[0x4] = false; break;
      case 'W': keys[0x5] = false; break;
      case 'E': keys[0x6] = false; break;
      case 'R': keys[0xD] = false; break;
      case 'A': keys[0x7] = false; break;
      case 'S': keys[0x8] = false; break;
      case 'D': keys[0x9] = false; break;
      case 'F': keys[0xE] = false; break;
      case 'Z': keys[0xA] = false; break;
      case 'X': keys[0x0] = false; break;
      case 'C': keys[0xB] = false; break;
      case 'V': keys[0xF] = false; break;

    }
  }


	static const List<int> font_temp = [
		0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
		0x20, 0x60, 0x20, 0x20, 0x70, // 1
		0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
		0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
		0x90, 0x90, 0xF0, 0x10, 0x10, // 4
		0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
		0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
		0xF0, 0x10, 0x20, 0x40, 0x40, // 7
		0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
		0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
		0xF0, 0x90, 0xF0, 0x90, 0x90, // A
		0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
		0xF0, 0x80, 0x80, 0x80, 0xF0, // C
		0xE0, 0x90, 0x90, 0x90, 0xE0, // D
		0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
		0xF0, 0x80, 0xF0, 0x80, 0x80  // F
	];
	
	Uint8List font = Uint8List.fromList(font_temp);
	
	
	Future<void> load_font_into_memory() async {
		for(int i = 0; i < font.length; i++){
			memory[i] = font[i];
		}
	}	
	
	
	Future<void> load_rom_into_memory() async {
		
        var data = await get_rom();
        for(int i = 0; i < data.length; i++){
            memory[ROM_START + i] = data[i];
        }

    }
	

  void clear_screen(){
    for(int i = 0; i < 32; i++){
      for(int j = 0; j < 64; j++){
        display[i * 64 + j] = 0;
      }
    }
  }


  void draw(int x, int y, int size) {
  registers[0xF] = 0;
  for (int row = 0; row < size; row++) {
    int spriteByte = memory[I + row];

    for (int col = 0; col < 8; col++) {

      if ((spriteByte & (0x80 >> col)) != 0) {

        int px = (x + col) % 64;
        int py = (y + row) % 32;

        final index = py * 64 + px;

        if (display[index] == 1) {
          registers[0xF] = 1;
        }

        display[index] ^= 1;
      }
    }
  }
}

	
	bool print_memory(){
		
		String line = "";
		int count = 0;
		
		for(int i = 0; i < memory.length; i++){
			line += " " + memory[i].toRadixString(16);
			count++;
			
			if(count == 64){
				print(line);
				line = "";
				count = 0;
			}
		}
		
		return true;
	}
	

	bool isOver8Bits(int n) {
    return n < 0 || n > 255;
  }

	
	void error_message(int opcode){
    print("error: unrecognized opcode at:" + opcode.toString());
  }


	int fetch_opcode(){
		
		int opcode = memory[PC] << 8 | memory[PC + 1];
		PC += 2;
		return opcode;
	}
	
	
bool decode_opcode() {
  int opcode = fetch_opcode();

  int x = (opcode & 0x0F00) >> 8;
  int y = (opcode & 0x00F0) >> 4;
  int nnn = opcode & 0x0FFF;
  int kk = opcode & 0x00FF;
  int n = opcode & 0x000F;

  switch (opcode & 0xF000) {

    case 0x0000:
      switch (opcode & 0x00FF) {
        case 0x00E0:
          clear_screen();
          break;

        case 0x00EE:
          SP--;
          PC = stack[SP];
          break;

        default:
          error_message(opcode);
          break;
      }
      break;

    case 0x1000:
      PC = nnn;
      break;

    case 0x2000:
      stack[SP++] = PC;
      PC = nnn;
      break;

    case 0x3000:
      if (registers[x] == kk) PC += 2;
      break;

    case 0x4000:
      if (registers[x] != kk) PC += 2;
      break;

    case 0x5000:
      if (n == 0 && registers[x] == registers[y]) PC += 2;
      break;

    case 0x6000:
      registers[x] = kk;
      break;

    case 0x7000:
      registers[x] = (registers[x] + kk) & 0xFF;
      break;

    case 0x8000:
      switch (n) {

        case 0x0:
          registers[x] = registers[y];
          break;

        case 0x1:
          registers[x] |= registers[y];
          break;

        case 0x2:
          registers[x] &= registers[y];
          break;

        case 0x3:
          registers[x] ^= registers[y];
          break;

        case 0x4: {
          int sum = registers[x] + registers[y];
          registers[0xF] = sum > 255 ? 1 : 0;
          registers[x] = sum & 0xFF;
          break;
        }

        case 0x5:
          registers[0xF] = registers[x] > registers[y] ? 1 : 0;
          registers[x] = (registers[x] - registers[y]) & 0xFF;
          break;

        case 0x6:
          registers[0xF] = registers[x] & 0x1;
          registers[x] >>= 1;
          break;

        case 0x7:
          registers[0xF] = registers[y] > registers[x] ? 1 : 0;
          registers[x] = (registers[y] - registers[x]) & 0xFF;
          break;

        case 0xE:
          registers[0xF] = (registers[x] & 0x80) >> 7;
          registers[x] = (registers[x] << 1) & 0xFF;
          break;

        default:
          error_message(opcode);
          break;
      }
      break;

    case 0x9000:
      if (n == 0 && registers[x] != registers[y]) PC += 2;
      break;

    case 0xA000:
      I = nnn;
      break;

    case 0xB000:
      PC = nnn + registers[0];
      break;

    case 0xC000:
      registers[x] = Random().nextInt(256) & kk;
      break;

    case 0xD000:
      draw(registers[x], registers[y], n);
      break;

    case 0xE000:
    switch (opcode & 0x00FF) {

      case 0x9E:
        if (keys[registers[x]]) {
          PC += 2;
        }
        break;

      case 0xA1:
        if (!keys[registers[x]]) {
          PC += 2;
        }
        break;

      default:
        error_message(opcode);
        break;
    }
    break;

    case 0xF000:

    switch (opcode & 0x00FF) {

      case 0x07:
        registers[x] = delayTimer;
        break;

      case 0x0A:
        bool keyPressed = false;

        for (int i = 0; i < 16; i++) {
          if (keys[i]) {
            registers[x] = i;
            keyPressed = true;
            break;
          }
        }

        if (!keyPressed) {
          PC -= 2;
        }
        break;

      case 0x15:
        delayTimer = registers[x];
        break;

      case 0x18:
        soundTimer = registers[x];
        break;


      case 0x1E:
        I += registers[x];
        break;


      case 0x29:
        I = registers[x] * 5;
        break;

      case 0x33:
        memory[I]     = registers[x] ~/ 100;
        memory[I + 1] = (registers[x] ~/ 10) % 10;
        memory[I + 2] = registers[x] % 10;
        break;

      case 0x55:
        for (int i = 0; i <= x; i++) {
          memory[I + i] = registers[i];
        }
        break;

      case 0x65:
        for (int i = 0; i <= x; i++) {
          registers[i] = memory[I + i];
        }
        break;

      default:
        error_message(opcode);
        break;
    }

  break;
  }

  return true;

  }

}


