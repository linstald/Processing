double x;
float xx;
double y;
float yy;
float a;
float b;
double t;
int k;
float mausX;
float mausY;
boolean running = false;
boolean start = false;
boolean finished = false;

void setup() {
  size(1200, 900);
  background(#D9DBD9);
  textSize(16);
}
void draw() {
  if (!start && !running) {
    background(#D9DBD9);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);
    mausX = map(mouseX, 0, width, -2, 2);
    mausY = map(mouseY, 0, height, -1, 1)*-1;

    fill(0, 0, 0);
    text("Re: "+mausX, width/6, height/6);
    text("Im: "+mausY, width/6, height/6+16);
    text("Linksklick: Menge generieren", width/6, height/6+34);
  }
  if (start && !running) {
    running = true;
    make();
  }
}
void mousePressed() {
  if (!running && mouseButton==LEFT) {
    start = true;
    background(#D9DBD9);
    a = mausX;
    b = mausY;
  }
  if (finished && mouseButton==RIGHT) {
    start = false;
    running = false;
  }
}
void make() {
  for (int i = 0; i < height; i = i+1) {
    x = -2;
    xx = -2;
    y = map(i, 0, height, -1.5, 1.5);
    yy = map(i, 0, height, -1.5, 1.5);
    for (int j = 0; j < width; j = j+1) {
      x = map(j, 0, width, -2, 2);
      xx = map(j, 0, width, -2, 2);
      y = map(i, 0, height, -1.5, 1.5);
      k = 0;
      while (k<200) {
        t = (x*x) - (y*y) + a;
        y = 2*x*y+b;
        x = t;
        if ((x*x+y*y)>4) {
          k = 100;
        }
        k++;
      }

      if ((x*x+y*y)<4) {
        point(map(xx, -2, 2, 0, width), height-map(yy, -1.5, 1.5, 0, height));
        point(map(-xx, -2, 2, 0, width), height-map(-yy, -1.5, 1.5, 0, height));
      }
    }
  }
  text("Juliamenge: Re="+a+" und Im="+b, 0, 16);
  text("Rechtsklick: Neue Menge", 0, 34);

  finished = true;
}