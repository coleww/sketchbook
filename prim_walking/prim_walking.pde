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

