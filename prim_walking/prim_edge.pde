class Edge {
  Walker a;
  Walker b;

  Edge(Walker tempa, Walker tempb) {
    a = tempa;
    b = tempb;
    a.edges.add(this);
    b.edges.add(this);
  }

  float cost() {
    float baseCost = dist(a.x, a.y, b.x, b.y);

    if (mode == 1) {
      //change cost based on xdiff
      float xDiff = abs(a.x - b.x);
      baseCost *= xDiff / width;
    }
    if (mode == 2) {
      //change cost based on ydiff
      float yDiff = abs(a.y - b.y);
      baseCost *= yDiff / height;
    }
    if (mode == 3) {
      float xCenter = width / 2;
      float yCenter = height / 2;
      int window = 25;
      if (a.x > xCenter - window && a.x < xCenter + window && a.y > yCenter - window && a.y < yCenter + window) {
        baseCost *= 0.1;
      }

      if (b.x > xCenter - window && b.x < xCenter + window &&  b.y > yCenter - window && b.y < yCenter + window) {
        baseCost *= 0.1;
      }
    }



    return baseCost;
  }

  void drawLine() {
    //    stroke(255);
    stroke(a.c);
    line(a.x, a.y, b.x, b.y);
    
    //how to bezier good?
//    bezier(a.x, a.y, a.x - b.x, a.y - b.y, b.x - a.x, b.y - a.y, b.x, b.y);
  }
}

