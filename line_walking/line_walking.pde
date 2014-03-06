int numWalkers = 500;
int walkerSize = 25;
int quadOpacity = 1;
int eraseOpacity = 5;
boolean clearOnReset = false;
int quads = 3;
Walker[] walkers = new Walker[numWalkers];


//AUDIO STUFF
import ddf.minim.*;
import ddf.minim.ugens.*;
Minim minim;
AudioOutput out;
Oscil[] oscs = new Oscil[8];
float[] notes = {
  146.83, 164.81, 174.61, 196.00, 220.00, 233.08, 261.63, 293.66
};
int[] count;
//AUDIO STUFF

void setup() {
  size(750, 500);
  background(0);
  noStroke();
  createWalkers();

  //AUDIO STUFF
  minim = new Minim(this);
  out = minim.getLineOut();
  for (int z = 0; z < oscs.length; z++) { 
    oscs[z] = new Oscil( notes[z], 0.5f, Waves.SINE );
    oscs[z].patch(out);
  }
  //AUDIO STUFF
}

void draw() {
  count = new int[9];
  for (int i = 0; i < walkers.length; i ++) {
    walkers[i].move();
    checkForIntersections(i);
    manageSynths(walkers[i]);
  }
  playSynths();
  maybeRestart();
}

void manageSynths(Walker w) {
  //TRACK CUMULATIVE X AND Y, GET AVERAGE?
  int synth = 8;
  if (w.xdir == -1) {
    if (w.ydir == 1) {
      synth = 0;
    }
    else if (w.ydir == -1) {
      synth = 1;
    }
    else if (w.ydir == 0) {
      synth = 2;
    }
  }
  else if (w.xdir == 1) {
    if (w.ydir == 1) {
      synth = 3;
    }
    else if (w.ydir == -1) {
      synth = 4;
    }
    else if (w.ydir == 0) {
      synth = 5;
    }
  }
  else if (w.xdir == 0) {
    if (w.ydir == 1) {
      synth = 6;
    }
    else if (w.ydir == -1) {
      synth = 7;
    }
  }


  count[synth] ++;
}

void playSynths() {
  for (int i = 0; i < oscs.length; i++) {
        oscs[i].setAmplitude(map(count[i], 0, numWalkers, 0, 1));
  }
}

