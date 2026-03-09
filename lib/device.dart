import 'dart:typed_data';
import 'dart:io';


class Device {
	
	String rom_path = "lib/chiplogo.ch8";
	Uint8List memory = Uint8List(4096);
	Uint16List PC = Uint16List(1);
	Uint16List I = Uint16List(1);
	Uint16List stack = Uint16List(16);
	//sound/display timers (60hz/s)
	Uint8List registers = Uint8List(16);
	List<List<bool>> display = List.generate(32, (_) => List.filled(64, false));
	
	
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
			memory[512 + i] = temp[i];
		}
		
		return true;
	}
	
	
	bool print_memory(){
		
		String line = "";
		int count = 0;
		
		for(int i = 0; i < memory.length; i++){
			line += " " + memory[i].toString();
			count++;
			
			if(count == 64){
				print(line);
				line = "";
				count = 0;
			}
		}
		
		return true;
	}
	
	
}
