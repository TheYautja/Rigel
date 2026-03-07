import 'dart:typed_data';
import 'dart:io';


class Device {
	
	
	var memory = Uint8List(4096);
	int PC = 0;
	var I = 0; //set to 16 bits with a bitmask
	//add sound/display timers (60hz/s)
	var registers = Uint8List(16);
	
	
	Future<bool> load_rom_into_memory() async {
		var rom = File("chiplogo.ch8");
		
		var temp = await rom.readAsBytes();
		for(int i = 0; i < temp.length; i++){
			memory[i] = temp[i];
		}
		
		return true;
	}
	
	
	bool print_memory(){
		for(int i = 0; i < memory.length; i++){
			print(memory[i].toString());
		}
		return true;
	}
	
	
}
