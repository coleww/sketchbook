int numPoints = 70;
int numEdges = 250;
int mode = 0;
int STROKE_WEIGHT = 1;
Edge[] edges = new Edge[numEdges];
Walker[] points = new Walker[numPoints];

void setup() {
  size(750, 500);
  background(0);


  for (int i = 0; i < points.length; i++) {
    points[i] = new Walker();
  }
  boolean[] pointsAdded = new boolean[numPoints];
  boolean allPointsAdded = false;

  while (!allPointsAdded) {
    for (int j = 0; j < edges.length; j++) {
      int a = int(random(points.length));
      int b = int(random(points.length));
      pointsAdded[a] = true;
      pointsAdded[b] = true;
      edges[j] = new Edge(points[a], points[b]);
    }
    allPointsAdded = true;
    //gotta be a faster way wtf java
    for (int k = 0; k < pointsAdded.length; k++) {
      if (!pointsAdded[k]) {
        allPointsAdded = false;
      }
    }
  }
}

void draw() {
  fill(0, 1);
  rect(0, 0, width, height);
  // or total wipe
  //background(0);

  moveAllWalkers();
  drawNetwork();
}

Walker randomWalker() {
  return points[int(random(points.length))];
}

void moveAllWalkers() {
  for (int i = 0; i < points.length; i++) {
    points[i].move();
  }
}

void drawNetwork() {
  ArrayList<Walker> connectedVertices = new ArrayList<Walker>();
  ArrayList<Edge> chosenEdges = new ArrayList<Edge>();
  connectedVertices.add(randomWalker());
  //                                    THIS IS WHY. RIGHT HERE. 
  while (connectedVertices.size () < numPoints) {
    Edge minEdge = null;
    for (int i = 0; i < connectedVertices.size(); i++) {
      Walker vertice = connectedVertices.get(i);
      for (int j = 0; j < vertice.edges.size(); j++) {
        Edge currentEdge = vertice.edges.get(j);
        if (connectedVertices.contains(currentEdge.a) && connectedVertices.contains(currentEdge.b)) {
        } 
        else if (minEdge == null || currentEdge.cost() < minEdge.cost()) {
          minEdge = currentEdge;
        }
      }
    }

    chosenEdges.add(minEdge);
    if (connectedVertices.contains(minEdge.a)) {
      connectedVertices.add(minEdge.b);
    } 
    else {
      connectedVertices.add(minEdge.a);
    }
  }

  for (int k = 0; k < chosenEdges.size(); k++) {
    chosenEdges.get(k).drawLine();
  }
}

void mousePressed() {
  saveFrame("/saves/prims#####.jpg");
}

void keyPressed() {
  println(keyCode);

  switch(keyCode) {
  case 90://z
    println("closer x is cheaper");
    mode = 1;
    break;

  case 88://x
    println("closer y is cheaper");
    mode = 2;
    break;

  case 67://c
    println("center is cheaper");
    mode = 3;
    break;

  case 86://v
    println("distance == cost");
    mode = 0;
    break;

  case 66://b
    if (STROKE_WEIGHT > 1) {
      println("THINNER");
      STROKE_WEIGHT --;
      strokeWeight(STROKE_WEIGHT);
    }
    break;

  case 78://n    
    if (STROKE_WEIGHT < 15) {
      println("BOLDER");
      STROKE_WEIGHT ++;
      strokeWeight(STROKE_WEIGHT);
    }
    break;

  case 83:
    saveFrame("prims###.jpg"); 
    break;
  }
}

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
    stroke(a.c);
    line(a.x, a.y, b.x, b.y);
  }
}
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

