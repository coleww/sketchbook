//import themidibus.*; //IMPLEMENT THIS LATER YO!
import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioInput in;

BeatDetect beat;
FFT fft;
int numWalkers = 100;
Walker[] walkers = new Walker[numWalkers];
float lowCutoff = 100;
float midCutoff = 1000;
int filly = 0;
//color[] palette = pickColors("na.png", numWalkers, true);

void setup() {
  minim = new Minim(this);
  size(1200, 750);
  in = minim.getLineIn();
  //  in.left;
  //  in.right;

  beat = new BeatDetect();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  createWalkers();
  noStroke();
  background(255);
}

void draw()
{
  //fill(0, 1);
  //rect(0, 0, width, height);
  beat.detect(in.mix);
  fft.forward( in.mix );

  for (int i = 0; i < walkers.length; i ++) {
    walkers[i].move();
    println();
    int r = int(random(0, 100));
    int g = int(random(0, 100));
    int b = int(random(0, 100));
    int a = int(fft.calcAvg(50, 1000)) * 2;
    if (beat.isOnset()) {
      filly = int(random(0, 3));
    } 
    int baller =    int(random(0, 155)) + 100;
    switch(filly) {
    case 0:
      r = baller;
      break;
    case 1:
      g = baller;
      break;
    case 2:
      b = baller;
      break;
    }
      fill(r, g, b, a);
      ellipse(walkers[i].x, walkers[i].y, int(fft.calcAvg(50, 2000)) / 2, int(fft.calcAvg(50, 2000)) / 2);

//    else {
//      fill(0, a);
//      ellipse(walkers[i].x, walkers[i].y, int(fft.calcAvg(250, 20000)), int(fft.calcAvg(250, 20000)));
//    }
//    
    
//     if (beat.isOnset()) {
//      fill(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)), 75);
//      ellipse(walkers[i].x, walkers[i].y, int(fft.calcAvg(50, 2000)) / 2, int(fft.calcAvg(50, 2000)) / 2);
      walkers[i].adjustDir();
//    } 
//    else {
//      fill(255, 75);
//      ellipse(walkers[i].x, walkers[i].y, int(fft.calcAvg(250, 20000)), int(fft.calcAvg(250, 20000)));
//    }
  }
}

void createWalkers() {
  for (int i = 0; i < walkers.length; i ++) {
    walkers[i] = new Walker();
  }
}

void mousePressed() {
  saveFrame("./saves/#######.png");
}

void keyPressed() {

  switch(keyCode) {
  case 32: //space
    fill(0);
    rect(0, 0, width, height);
    break;
  case 38: //up
    filly = int(random(0, 3));
    break;
  case 40: //down

    break;
  }
}
//color[] pickColors(String path, int numColors, boolean ordered) {
//  color[] colors = new color[numColors];
//  PImage img = loadImage(path);
//  img.loadPixels();
//  int numPixels = img.width * img.height;
//
//
//  int iterator = numPixels / numColors;
//  for (int i = 0; i < numColors; i ++) {
//    if (ordered) {
//      colors[i] = img.pixels[i * iterator];
//    } 
//    else {
//      colors[i] = img.pixels[int(random(0, numPixels))];
//    }
//  }
//  return colors;
//};

//void draw() {
//  background(0);
//  
//  fft.forward(player.mix);
//  float low = fft.calcAvg(20, lowCutoff);
//  float mid = fft.calcAvg(lowCutoff, midCutoff); 
//  float high = fft.calcAvg(midCutoff, 20000);
//  float avg = max(low, mid, high);
//println(low, mid, high);
////  for (int i = 0; i < walkers.length; i ++) {
////    if (avg == low) {
////      walkers[i].ydir = 1;
////      println("LOW");
////    }
////    if (avg == mid) {
////      walkers[i].xdir *= 2;
////      println("mid");
////    }
////    if (avg == high) {
////      walkers[i].ydir = -1;
////      println("hi");
////    }
////    walkers[i].move();
////    if (beat.isOnset()) {
////      ellipse(walkers[i].x, walkers[i].y, 5, 5);
////    } else {
////       walkers[i].adjustDir(); 
////    }
////  }
//
//
//
//
//
//}
//

