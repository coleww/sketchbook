//controls the jaw movement
int i = 44;
int j = 316;
int d = 0;

//controls position
int x = 241;
int y = 241;
int target_x = int(random(15, 465));
int target_y = int(random(15, 465));

void setup() {
  size(480, 480);
  noStroke();
}

void draw() {
  background(0);
  fill(255);
  ellipse(target_x, target_y, 15, 15);

  //TRIPPIN BALLS
  //fill(int(random(255)), int(random(255)), int(random(255)));
  //STANDARD
  fill(255, 215, 10);

  //makes the jaw move
  if (d == 0) {
    i --;
    j++;
  }
  else {
    i ++;
    j --;
  }
  if (i == 0) {
    d = 1;
  }
  else if (i == 45) {
    d = 0;
  }

  if (x < target_x) {
    arc(x, y, 50, 50, radians(i), radians(j), PIE);
    fill(0);
    ellipse(x, y-15, 5, 5);
    x++;
  }

  else if (x > target_x) {
    arc(x, y, 50, 50, radians(i+180), radians(j+180), PIE);
    fill(0);
    ellipse(x, y-15, 5, 5);
    x--;
  }
  else if (y > target_y) {
    arc(x, y, 50, 50, radians(i+270), radians(j+270), PIE);
    fill(0);
    ellipse(x+15, y, 5, 5);
    y--;
  }
  else if (y < target_y) {
    arc(x, y, 50, 50, radians(i+90), radians(j+90), PIE);
    fill(0);
    ellipse(x+15, y, 5, 5);
    y++;
  }

  if (x == target_x && y == target_y) {
    target_x = int(random(15, 465));
    target_y = int(random(15, 465));
  }
}

