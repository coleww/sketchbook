class Walker {
  ArrayList<Edge> edges = new ArrayList<Edge>();
  int size = 10;
  int[] dirs = {
    -1, 0, 1
  };
  int xdir = dirs[int(random(dirs.length))];
  int ydir = dirs[int(random(dirs.length))];
  int x = int(random(0, width));
  int y = int(random(0, height));
  
  color c = color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));

  void move() {
    x += xdir;
    y += ydir;
    if (x < 0 + size || x > width - size) {
      xdir *= -1;
    } 
    if (y < 0 + size || y > height - size) {
      ydir *= -1;
    }
  }

  void draw(){
    fill(c);
    ellipse(x, y, size, size);
  }
}
