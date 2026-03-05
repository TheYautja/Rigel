import "device.dart";	

void main(){
	var d = Device();
	for(int i = 0; i < d.memory.length; i++){
		print(d.memory[i].toString());
	}
}
