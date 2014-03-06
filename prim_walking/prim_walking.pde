int numPoints = 250;
int numEdges = 750;
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

  //guarantee that every point is in an edge somehow?
  //is that the null pointer exception?
  for (int j = 0; j < edges.length; j++) {
    edges[j] = new Edge(randomWalker(), randomWalker());
  }
}

void draw() {
  fill(0, 1);
  rect(0, 0, width, height);

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

  while (connectedVertices.size () < numPoints) {
    Edge minEdge = null;
    for (int i = 0; i < connectedVertices.size(); i++) {
      for (int j = 0; j < connectedVertices.get(i).edges.size(); j++) {
        Edge currentEdge = connectedVertices.get(i).edges.get(j);
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
  if (keyCode == 90) {//z
    println("closer x is cheaper");
    mode = 1;
  }
  if (keyCode == 88) {//x
    println("closer y is cheaper");
    mode = 2;
  }
  if (keyCode == 67) {//c
    println("center is cheaper");
    mode = 3;
  }
  if (keyCode == 86){//v
    println("distance == cost");
    mode = 0;
  }
  if (keyCode == 66){//b
    if (STROKE_WEIGHT > 1){
      println("THINNER");
      STROKE_WEIGHT --;
      strokeWeight(STROKE_WEIGHT);
    }
  }
  
   if (keyCode == 78){//n    
   if (STROKE_WEIGHT < 15){
     println("BOLDER");
      STROKE_WEIGHT ++;
      strokeWeight(STROKE_WEIGHT);
    }
   }
   
   if (keyCode == 83){
    saveFrame("prims###.jpg"); 
   }
}

