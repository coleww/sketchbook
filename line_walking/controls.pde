void keyPressed() {
  printValues();
  switch(keyCode) {
  case 32: //space
    createWalkers();
    break;
  case 38: //up
    if (quads < 4) {
      quads ++;
    }
    break;
  case 40: //down
    if (quads > 1) {
      quads --;
    }
    break;
  case 82: //r
    clearOnReset = !clearOnReset;
    break;
  case 83: //s
    screenGrab();
    break;  
  case 87: //w
    if (quadOpacity < 255) {
      quadOpacity++;
    }
    break;
  case 81: //q
    if (quadOpacity > 0) {
      quadOpacity--;
    }
    break;
  case 90: //z
    if (eraseOpacity > 0) {
      eraseOpacity--;
    }
    break;
  case 88: //x
    if (eraseOpacity < 255) {
      eraseOpacity++;
    }
    break;
  }
}

void printValues(){
 println("eraseOpacity:" + eraseOpacity);
 println("quadOpacity:" + quadOpacity);
 println("quads:" + quads);
 println("clearOnReset:" + clearOnReset);
}
