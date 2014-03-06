PImage[] shiffmans = new PImage[8];
float deg;
  float threshold = 200;


void setup() {

  for (int i = 0; i<shiffmans.length; i++) {
    shiffmans[i] = loadImage("shiffman" + (i+1) + ".png");
  }
  background(255);
  size (640, 480);
  imageMode(CENTER);
//  frameRate(2);
  fill(0);
  ellipse(width/2, height/2, 150, 150);
}

void draw() {
  translate(width/2, height/2);
  rotate(radians(deg));
  int i = frameCount % 8;
  

  image(shiffmans[i], 0, -150, width/3, height/3);
  deg+= 65.0;
}

