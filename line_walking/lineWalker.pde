class Walker {
  int size = walkerSize;
  int[] dirs = {
    -1, 0, 1
  };
  int xdir = dirs[int(random(dirs.length))];
int ydir = dirs[int(random(dirs.length))];
  int x = int(random(0, width));
  int y = int(random(0, height));
  int x2 = x + xdir * size;
  int y2 = y + ydir * size;
  color c = color(int(random(1) * 255), int(random(1) * 255), int(random(1) * 255), quadOpacity);



  void move() {
    x += xdir;
    y += ydir;

    //bounce back from edges
//    if (x < 0 + size || x > width - size) {
//      xdir *= -1;
//    } 
//    if (y < 0 + size || y > height - size) {
//      ydir *= -1;
//    }
    
    //re-appear on opposite side
    if (x < 0){
      x = width + size;
    } else if (x > width){
      x = 0 - size;
    }
    if (y < 0){
     y = height + size; 
    } else if (y > height){
      y = 0 - size;
    }

    x2 = x + xdir * size;
    y2 = y + ydir * size;
  }

  void adjustDir(Walker w2) {
    xdir = w2.xdir;
    ydir = w2.ydir;
  }

  boolean intersectsWith(Walker w2) {
    return intersects(x, y, x2, y2, w2.x, w2.y, w2.x2, w2.y2);
  }
}

