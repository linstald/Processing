
Train t1;
Train t2;
final float C = 5;
boolean start = false;

void setup() {
  size(800, 800);
  t1 = new Train(0, 2*height/3, 3);
  t2 = new Train(width/2, height/3, 0); 
  rectMode(CENTER);
  frameRate(60);
}

void draw() {
  background(120,30,234);
  fill(0);
  textSize(30);
  text("Perspektive des Zuges", width/3, height/4);
  text("Perspektive des Bahnwerters", width/3, height/2);
  if (start) {
    t1.show();
    t1.update();
    t2.show();
    t2.update();
  }
  //noStroke();
  //fill(129, 129, 495);
  //rect(width/2,3*height/4+40, width, height/2-20);
  //stroke(0);
  //line(0, height/2+30, width, height/2+30);
}


void keyPressed() {
  if (key == ' ') {
    t1.sendRays();
    t2.sendRays();
  }
  if (key == 'g') {
   if (start) {
     setup();
   }else {
     start = true;
   }
  }
}
