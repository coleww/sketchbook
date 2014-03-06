int j = 6;
int k = 0;

int l = 199;


void setup(){
  size(880, 440);
  rectMode(CENTER);
  frameRate(24);
}

void draw(){
for(int i = 1; i < 440; i+=j){
fill(random(i));
rect(220, 220, 440-i, height-i);
}

for(int i = 1; i < 440; i+=j){
fill(random(i));
rect(660, 220, 440-i, height-i);
}


if (j==200){k = 1;}
else if (j==5){k = 0;}

if (k==0){j++; l--;}
else {j--; l++;}

}
