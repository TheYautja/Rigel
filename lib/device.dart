import 'dart:typed_data';
import 'dart:io';


class Device {
	
	String romPath = "chiplogo.ch8";
	Uint8List memory = Uint8List(4096);
	static const int ROM_START = 0x200;
	int PC = ROM_START;
	int I = 0;
	Uint16List stack = Uint16List(16);
	//sound/display timers (60hz/s)
	Uint8List registers = Uint8List(16);
	List<List<bool>> display = List.generate(32, (_) => List.filled(64, false));
	

  Future<void> init () async {
    load_font_into_memory();
    turn_on(10, 15);
    turn_on(13, 15);
    turn_on(10, 17);
    turn_on(11, 17);
    turn_on(12, 17);
    turn_on(13, 17);
    load_rom_into_memory();
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
	
	
	void load_font_into_memory(){
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
              //clear screen
              break;
            case 0x00EE:
              //pc = adress at the top of the stack, then sub 1 from SP first sub the set
              break;
            default:
              error_message(opcode);
              break;
          }
        break;

      case 0x1000:
        //set pc to nnn, 0x1nnn with a bitmask
        break;

      case 0x2000:
        //The interpreter increments the stack pointer, then puts the current PC on the top of the stack. The PC is then set to nnn.
        break;

      case 0x3000:
        //3xkk, if registers[x] == kk increment pc by 2
        break;

      case 0x4000:
        //same as previous, but increments pc if different
        break;

      case 0x5000:
        //5xyo, if vx == vy increment pc
        break;

      case 0x6000:
        //6xkk, puts kk into vx
        break;

      case 0x7000:
        //7xkk, increments vx value by kk and store it in vx
        break;

      case 0x8000: //0x8xyn
        switch(opcode & 0x000F){
          case 0x0:
            //vx = vy
            break;

          case 0x1:
            //vx OR vy
            break;

          case 0x2:
            //vx AND vy
            break;

          case 0x3:
            //vx XOR vy
            break;

          case 0x4:
            //vx = vx + vy, set carry = true if the results exceed 8 bits
            break;

          case 0x5:
            //vx = vx - vy, if vx > vy, carry flag is set to 1
            break;

          case 0x6:
            //bitshifts, see later
            break;

          case 0x7:
            //bitshifts, see later
            break;

          case 0xE:
            //bitshifts, see later
            break;

          default:
            error_message(opcode);
            break;
        }
        break;

			case 0x9000:
        //9xy0, if vx != vy skip next instruction
        break;

      case 0xA000:
        //Annn, I register is set to nnn
        break;

      case 0xB000:
        //bnnn, pc is set to nnn plus V[0]
        break;

      case 0xC000:
        //The interpreter generates a random number from 0 to 255, which is then ANDed with the value kk. The results are stored in Vx
        break;

      case 0xD000:

        break;

      case 0xE000:

        break;

      case 0xF000:

        break;
		}
		return true;
	}


}
























