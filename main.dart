import "device.dart";	


void main(){
	var d = Device();
	d.load_rom_into_memory();
	d.print_memory();
}
