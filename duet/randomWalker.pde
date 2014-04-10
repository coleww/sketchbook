class Walker {
  int size = 25;
  float[] dirs = genDirs();
  float xdir = dirs[int(random(dirs.length))];
  float ydir = dirs[int(random(dirs.length))];
  float x = random(0, width);
  float y = random(0, height);

  void move() {
    x += xdir;
    y += ydir;

    //bounce back from edges
    if (x < 0 + size || x > width - size) {
      xdir *= -2;
    } 
    if (y < 0 + size || y > height - size) {
      ydir *= -2;
    }
  }

  void adjustDir() {
    dirs = genDirs();
    xdir = dirs[int(random(dirs.length))];
    ydir = dirs[int(random(dirs.length))];
  }
  
  float[] genDirs() {
    return new float[] {random(0,5) * -1, random(0, 5), 0};
  }

}

