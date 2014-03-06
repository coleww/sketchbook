import themidibus.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
MidiBus myBus; 

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
  int velocity = 127;
  video.start();
}

void draw() {
  opencv.loadImage(video);
  image(video, 0, 0 );
  strokeWeight(5);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  Rectangle[] faces = opencv.detect();
  for (int i = 0; i < faces.length; i++) {
   ellipse(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2, 100, 100);
    //lil hack to turn x/y into center of face rather than top left
    //cuz i dont understand the java open cv docs :(
    playNote(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2);
  }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void captureEvent(Capture c) {
  c.read();
}

void playNote(int x, int y) {
  println(x, y);
  if (x < width/2 && y < height/2) {
    println("UPPAH LEFT");
    myBus.sendNoteOn(0, 48, 127);

    myBus.sendNoteOff(0, 51, 127);
        myBus.sendNoteOff(0, 49, 127);
            myBus.sendNoteOff(0, 50, 127);
  } 
  else if (x > width/2 && y < height/2) {
    println("UPPAH RIGHT!");
        myBus.sendNoteOn(0, 49, 127);
            myBus.sendNoteOff(0, 48, 127);
        myBus.sendNoteOff(0, 51, 127);
            myBus.sendNoteOff(0, 50, 127);
  } 
  else if (x < width/2 && y > height/2) {
    println("LOWER LEFT!");
        myBus.sendNoteOn(0, 50, 127);
            myBus.sendNoteOff(0, 48, 127);
        myBus.sendNoteOff(0, 49, 127);
            myBus.sendNoteOff(0, 51, 127);
  } 
  else if (x > width/2 && y > height/2) {
    println("LOWER RIGHT!");
        myBus.sendNoteOff(0, 48, 127);
        myBus.sendNoteOff(0, 49, 127);
            myBus.sendNoteOff(0, 50, 127);
        myBus.sendNoteOn(0, 51, 127);
  }
}

