
void controllerChange(int channel, int number, int value){
kc[number] = map(value, 0, 127, 0, 1);
}

void noteOn(int channel, int number, int value){
  println(channel);
  println(number);
  println(value);
}

void noteOff(int channel, int number, int value){
}
