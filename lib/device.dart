import 'dart:typed_data';
import 'dart:io';
import 'dart:math';


class Device {
	
	String romPath = "lib/chiplogo.ch8";
	Uint8List memory = Uint8List(4096);
	static const int ROM_START = 0x200;
	int PC = ROM_START;
	int I = 0;
  int SP = 0;
	Uint16List stack = Uint16List(16);
	//sound/display timers (60hz/s)
	Uint8List registers = Uint8List(16);
	List<List<bool>> display = List.generate(32, (_) => List.filled(64, false));
	

  Future<void> init () async {
    await load_font_into_memory();
    await load_rom_into_memory();
  }


  void cycle(){
    decode_opcode();
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
	
	
	bool print_display_state(){
		String line = "";
		for(int i = 0; i < 32; i++){
			for(int j = 0; j < 64; j++){
				line += display[i][j].toString() + " ";
			}
			print(line);
			line = "";
		}
		return true;
	}
	
	
	Future<bool> load_rom_into_memory() async {
		var rom = File(romPath);
		
		var temp = await rom.readAsBytes();
		for(int i = 0; i < temp.length; i++){
			memory[ROM_START + i] = temp[i];
		}
		
		return true;
	}
	

	void turn_on(int x, int y){
    display[y][x] = true;
  }


  void turn_off(int x, int y){
    display[y][x] = false;
  }


  void clear_screen(){
    for(int i = 0; i < 32; i++){
      for(int j = 0; j < 64; j++){
        display[i][j] = false;
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


        if (display[py][px]) {
          registers[0xF] = 1;
        }

        display[py][px] = !display[py][px];
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
	
	
	bool decode_opcode(){
		int opcode = fetch_opcode();
		switch(opcode & 0xF000 ){

      case 0x0000:
          switch(opcode & 0x00FF){
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
        int nnn = opcode & 0x0FFF;
        PC = nnn;
        break;

      case 0x2000:
        int nnn = opcode & 0x0FFF;
        stack[SP] = PC;
        SP++;
        PC = nnn;
        break;

      case 0x3000:
        int x = (opcode & 0x0F00) >> 8;
        int kk = (opcode & 0x00FF);
        if(registers[x] == kk) PC += 2;
        break;

      case 0x4000:
        int x = (opcode & 0x0F00) >> 8;
        int kk = (opcode & 0x00FF);
        if(registers[x] != kk) PC += 2;
        break;

      case 0x5000:
        int x = (opcode & 0x0F00) >> 8;
        int y = (opcode & 0x00F0) >> 4;
        if(registers[x] == registers[y]) PC += 2;
        break;

      case 0x6000:
        int kk = opcode & 0x00FF;
        int x = (opcode & 0x0F00) >> 8;
        registers[x] = kk;
        break;

      case 0x7000:
        int kk = opcode & 0x00FF;
        int x = (opcode & 0x0F00) >> 8;
        registers[x] += kk;
        break;

      case 0x8000: //0x8xyn
        switch(opcode & 0x000F){
          case 0x0:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] = registers[y];
            break;

          case 0x1:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] = registers[x] | registers[y];
            break;

          case 0x2:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] = registers[x] & registers[y];
            break;

          case 0x3:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] = registers[x] ^ registers[y];
            break;

          case 0x4:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] += registers[y];  //a number bigger than 8 bits can currently be assigned to V[x], adress this later
            if(isOver8Bits(registers[x])){
              registers[0xF] = 1;
            } else registers[0xF] = 0;
            break;

          case 0x5:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            registers[x] -= registers[y];
            if(registers[x] > registers[y]){
              registers[0xF] = 1;
            }else registers[0xF] = 0;
            break;

          case 0x6:
            int x = (opcode & 0xF000) >> 12;
            if(isOver8Bits(registers[x] * 2)){
              registers[0xF] = 1;
            } else {
              registers[0xF] = 0;
              registers[x] *= 2;
            }
            break;

          case 0x7:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            break;

          case 0xE:
            int x = (opcode & 0xF000) >> 12;
            int y = (opcode & 0x0F00) >> 8;
            break;

          default:
            error_message(opcode);
            break;
        }
        break;

			case 0x9000:
        int x = (opcode & 0x0F00) >> 8;
        int y = (opcode & 0x00F0) >> 4;
        if(registers[x] != registers[y]) PC += 2;
        break;

      case 0xA000:
        int nnn = opcode & 0x0FFF;
        I = nnn;
        break;

      case 0xB000:
        int nnn = opcode & 0x0FFF;
        PC = nnn + registers[0];
        break;

      case 0xC000:
        int v = Random().nextInt(256);
        int kk = (opcode & 0x00FF) >> 8;
        int x = (opcode & 0xF000) >> 12;
        registers[x] = v & kk;
        break;

      case 0xD000:
        int x = (opcode & 0x0F00) >> 8;
        int y = (opcode & 0x00F0) >> 4;
        int n = opcode & 0x000F;
        draw(registers[x], registers[y], n);
        break;

      case 0xE000:

        break;

      case 0xF000:

        break;
		}
		return true;
	}


}


