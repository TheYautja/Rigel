import "device.dart";	


Future<void> main() async {
	var d = Device();
	await d.load_rom_into_memory();
	d.print_memory();
}
