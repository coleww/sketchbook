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

