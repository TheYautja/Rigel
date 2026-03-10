import 'dart:typed_data';
import 'dart:io';


class Device {
	
	String rom_path = "lib/chiplogo.ch8";
	Uint8List memory = Uint8List(4096);
	static const int ROM_START = 0x200;
	int PC = ROM_START;
	int I = 0;
	Uint16List stack = Uint16List(16);
	//sound/display timers (60hz/s)
	Uint8List registers = Uint8List(16);
	List<List<bool>> display = List.generate(32, (_) => List.filled(64, false));
	
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
		var rom = File(rom_path);
		
		var temp = await rom.readAsBytes();
		for(int i = 0; i < temp.length; i++){
			memory[ROM_START + i] = temp[i];
		}
		
		return true;
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
	
	
	int fetch_opcode(){
		
		int opcode = memory[PC] << 8 | memory[PC + 1];
		PC += 2;
		return opcode;
	}
	
	
	bool decode_opcode(){
		int opcode = fetch_opcode();
		switch(opcode){

			

		}
		return true;
	}
	
	
}
























