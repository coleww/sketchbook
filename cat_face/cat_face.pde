import gab.opencv.*;
import processing.video.*;
import java.awt.*;
PImage cat;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  cat = loadImage("kitteh.png");
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  imageMode(CORNER);
  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    imageMode(CENTER);
    image(cat, faces[i].x + faces[i].width / 2, faces[i].y + faces[i].height / 2, faces[i].width * 1.5, faces[i].height * 2.5);
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}

