int s = 15;
PImage[] strokes = new PImage[s];

void setup() {
  for (int i = 0; i<strokes.length; i++) {
    strokes[i] = loadImage("/strokes/stroke_" + (i+1) + ".png");
  }
  size(1280, 960);
  background(0);
  imageMode(CENTER);
}

void draw() {
  image(strokes[int(random(0, s))], random(0, width), random(0, height));
}

void mousePressed() {
  saveFrame();
}

