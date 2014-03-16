class Walker {
  int size = 25;
  int[] dirs = {
    -1, 0, 1
  };
  int xdir = dirs[int(random(dirs.length))];
  int ydir = dirs[int(random(dirs.length))];
  int x = int(random(0, width));
  int y = int(random(0, height));

  void move() {
    x += xdir;
    y += ydir;

    //bounce back from edges
    if (x < 0 + size || x > width - size) {
      xdir *= -1;
    } 
    if (y < 0 + size || y > height - size) {
      ydir *= -1;
    }
  }

  void adjustDir() {
    xdir = dirs[int(random(dirs.length))];
    ydir = dirs[int(random(dirs.length))];
  }

}

