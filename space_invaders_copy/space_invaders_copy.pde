int gridX ;
int gridY ;
int grid = 6;

void setup(){
  size(480, 480);
  gridX = width / grid;
  gridY = height / grid;
  frameRate(1);
  noStroke();
}

void draw(){
  for(int x = 0; x < grid/2; x++){
    for(int y = 0; y < grid; y++){
      if(int(random(2))==1){
         fill(0);
      } else {
        fill(255);
      }
      rect(x*gridX, y*gridY, gridX, gridY);
      rect((grid-x-1) * gridX, y*gridY, gridX, gridY);
    }
  }
}
