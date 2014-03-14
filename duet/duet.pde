import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//AudioInput in;
AudioPlayer player;
void setup(){
  minim = new Minim(this);
  
//  in = minim.getLineIn();
//  in.left;
//  in.right;

  player = minim.loadFile("marcus_kellis_theme.mp3");
  
  player.loop();
}

void draw(){
}
