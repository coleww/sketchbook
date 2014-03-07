//get an array of colors for your processing sketch from an image
//takes path to image, num of colors to grab, and whether to pick an even distribution or at random

color[] pickColors(String path, int numColors, boolean ordered) {
  color[] colors = new color[numColors];
  PImage img = loadImage(path);
  img.loadPixels();
  int numPixels = img.width * img.height;


  int iterator = numPixels / numColors;
  for (int i = 0; i < numColors; i ++) {
    if (ordered) {
      colors[i] = img.pixels[i * iterator];
    } 
    else {
      colors[i] = img.pixels[int(random(0, numPixels))];
    }
  }
  return colors;
};

//simple test code
void setup() {
  size(500, 500);
  noStroke();
  int numColors = 100;
  int bar = width / numColors;
  
  color[] colors = pickColors("test.png", numColors, true);
  
  for (int i = 0; i * bar < width; i += 1) {
    fill(colors[i]);
    rect(i * bar, 0, bar, width);
  }
}

