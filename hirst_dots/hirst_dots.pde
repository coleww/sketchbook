void setup() {
  size(480, 480);
  background(200);
  frameRate(1);
  noStroke();
}

void draw() {
  for (int x = 30; x < width; x+=60) {
    for (int y = 30; y < height; y+=60) {
      fill(int(random(255)), int(random(255)), int(random(255)), 150);
      ellipse(x, y, 30, 30);
    }
  }
}
