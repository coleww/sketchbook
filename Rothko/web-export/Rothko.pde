void setup() {
  size(320, 480);
  noStroke();
  background(50, 10, 15);
  frameRate(6);
}
void draw() {
  fill(random(200, 255), 0, 0, 50);
  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/3);
  vertex(random(10, width-10), random(10, height/3 * 2));
  vertex(random(15, width-15), random(15, height/3 * 2 + 25));
  vertex(random(15, width-15), random(15, height/3 * 2 + 25));
  vertex(random(25, width-25), random(25, height/3 * 2));
  vertex(width/2, height/3);
  endShape();

  fill(0, 0, random(50, 75), 50);
  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/6 * 5);
  vertex(random(10, width-10), random(height/6 * 4, height-10));
  vertex(random(15, width-15), random(height/6 * 4, height-15));
  vertex(random(15, width-15), random(height/6 * 4, height-15));
  vertex(random(25, width-25), random(height/6 * 4, height-25));
  vertex(width/2, height/6 * 5);
  endShape();
}


