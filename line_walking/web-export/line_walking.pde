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

void keyPressed() {
  printValues();
  switch(keyCode) {
  case 32: //space
    createWalkers();
    break;
  case 38: //up
    if (quads < 4) {
      quads ++;
    }
    break;
  case 40: //down
    if (quads > 1) {
      quads --;
    }
    break;
  case 82: //r
    clearOnReset = !clearOnReset;
    break;
  case 83: //s
    screenGrab();
    break;  
  case 87: //w
    if (quadOpacity < 255) {
      quadOpacity++;
    }
    break;
  case 81: //q
    if (quadOpacity > 0) {
      quadOpacity--;
    }
    break;
  case 90: //z
    if (eraseOpacity > 0) {
      eraseOpacity--;
    }
    break;
  case 88: //x
    if (eraseOpacity < 255) {
      eraseOpacity++;
    }
    break;
  }
}

void printValues(){
 println("eraseOpacity:" + eraseOpacity);
 println("quadOpacity:" + quadOpacity);
 println("quads:" + quads);
 println("clearOnReset:" + clearOnReset);
}
void createWalkers() {
  if (clearOnReset) {
    background(0);
  }
  for (int i = 0; i < walkers.length; i ++) {
    walkers[i] = new Walker();
  }
}

void checkForIntersections(int i) {
  for (int j = 0; j < walkers.length; j ++) {
    if (i != j) {
      drawIfIntersected(walkers[i], walkers[j]);
    }
  }
}

void drawIfIntersected(Walker w1, Walker w2) {
  if (w1.intersectsWith(w2)) {
    drawQuads(w1, w2);
    w1.adjustDir(w2);
  }
}

void drawQuads(Walker w1, Walker w2) {
  fill(w1.c);
  quad(w1.x, w1.y, w1.x2, w1.y2, w2.x, w2.y, w2.x2, w2.y2); 

  if (quads > 1) {
    fill(w2.c);
    quad(w1.x, w1.y, w2.x, w2.y, w2.x2, w2.y2, w1.x2, w1.y2);
  }
  if (quads > 2) {
    fill(0, 0, 0, eraseOpacity);
    quad(w2.x2, w2.y2, w1.x, w1.y, w2.x, w2.y, w1.x2, w1.y2);
  }
  if (quads > 3) {
  }
}

void maybeRestart() {
  //this will ideally be something like
  //if all lines moving in same direction.
  if (frameCount % 5000==0) {
    screenGrab();
    createWalkers();
  }
}

void screenGrab() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame("lines" + timestamp + ".png");
}

//i should learn what all this down here means...
boolean intersects(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) { 
  int bx = x2 - x1; 
  int by = y2 - y1; 
  int dx = x4 - x3; 
  int dy = y4 - y3;
  int b_dot_d_perp = bx * dy - by * dx;
  if (b_dot_d_perp == 0) {
    return false;
  }
  int cx = x3 - x1;
  int cy = y3 - y1;
  float t = (cx * dy - cy * dx) / b_dot_d_perp;
  if (t < 0 || t > 1) {
    return false;
  }
  float u = (cx * by - cy * bx) / b_dot_d_perp;
  if (u < 0 || u > 1) { 
    return false;
  }
  return true;
}

class Walker {
  int size = walkerSize;
  int[] dirs = {
    -1, 0, 1
  };
  int xdir = dirs[int(random(dirs.length))];
int ydir = dirs[int(random(dirs.length))];
  int x = int(random(0, width));
  int y = int(random(0, height));
  int x2 = x + xdir * size;
  int y2 = y + ydir * size;
  color c = color(int(random(1) * 255), int(random(1) * 255), int(random(1) * 255), quadOpacity);



  void move() {
    x += xdir;
    y += ydir;

    //bounce back from edges
//    if (x < 0 + size || x > width - size) {
//      xdir *= -1;
//    } 
//    if (y < 0 + size || y > height - size) {
//      ydir *= -1;
//    }
    
    //re-appear on opposite side
    if (x < 0){
      x = width + size;
    } else if (x > width){
      x = 0 - size;
    }
    if (y < 0){
     y = height + size; 
    } else if (y > height){
      y = 0 - size;
    }

    x2 = x + xdir * size;
    y2 = y + ydir * size;
  }

  void adjustDir(Walker w2) {
    xdir = w2.xdir;
    ydir = w2.ydir;
  }

  boolean intersectsWith(Walker w2) {
    return intersects(x, y, x2, y2, w2.x, w2.y, w2.x2, w2.y2);
  }
}


