PImage[] shiffmans = new PImage[8];
float degrease;

void setup() {
  for (int i = 0; i<shiffmans.length; i++) {
    shiffmans[i] = loadImage("/shiffmen/shiffman" + (i+1) + ".png");
  }
  background(255);
  size (640, 480);
  imageMode(CENTER);
  fill(0);
  ellipse(width/2, height/2, 150, 150);
}

void draw() {
  translate(width/2, height/2);
  rotate(radians(degrease));
  int i = frameCount % 8;
  image(shiffmans[i], 0, -150, width/3, height/3);
  degrease+= 65.0;
}
