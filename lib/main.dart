import "device.dart";	


Future<void> main() async {
	var d = Device();
	d.load_font_into_memory();
	await d.load_rom_into_memory();
	d.print_memory();
	//d.print_display_state();
	d.decode_opcode();
}
