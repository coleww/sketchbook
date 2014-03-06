import themidibus.*;

//knob changes on kc[1-8]
float kc[] = new float[9];

MidiBus myBus;

void setup(){
  MidiBus.list();
  myBus = new MidiBus(this, 0, -1);
}

void draw(){

}

