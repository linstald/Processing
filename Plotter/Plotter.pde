double xmin;
double xmax;
double ymin;
double ymax;

final double zoomConst = 0.05;

boolean camera = false;

/* this array contains Function objects. 
 * They all have a generate() function which can be called
 * to draw the corresponding image
 */
ArrayList<Function> myFuncs;

int toPlot;

void setup() {
  size(1000, 720);
  //fullScreen(2);
  resetWindow();

  myFuncs = new ArrayList<Function>();
  myFuncs.add(new Mandelbrot(1000, false)); 
  myFuncs.add(new Julia(200, -0.39, 0.59, true));
  myFuncs.add(new Iterator(0.7297297332129355, 3.7));

  toPlot = 0; //the Function to be drawn
  myFuncs.get(toPlot).reset();

}

void draw() {
  background(255);
  myFuncs.get(toPlot).generate();
  drawScale();
  drawCoords();
  if (camera) {
    zoomIn(-0.732141, 0.20809941, false);
  }
}

void mouseWheel(MouseEvent e) {
  int dir = e.getCount();
  if (dir>0) {
    zoomOut(mouseX, mouseY, true);
  } else {
    zoomIn(mouseX, mouseY, true);
  }
}
void mousePressed() {
  if (mouseButton==RIGHT) {
    resetWindow();
  }
}
void keyPressed() {
  if (key=='i') {
    String name = "image"+hour()+minute()+second()+".png";
    save(name);
    println("saved "+name);
  } else if (key=='+') {
    toPlot = (toPlot+1)%myFuncs.size();
    myFuncs.get(toPlot).reset();
  } else if (key=='k') {
    camera = !camera;
  } else if (key=='r') {
    myFuncs.get(toPlot).reset();
  } else if (key=='w') {
    ymin+=zoomConst*(ymax-ymin);
    ymax+=zoomConst*(ymax-ymin);
  } else if (key=='s') {
    ymin-=zoomConst*(ymax-ymin);
    ymax-=zoomConst*(ymax-ymin);
  } else if (key=='d') {
    xmin+=zoomConst*(xmax-xmin);
    xmax+=zoomConst*(xmax-xmin);
  } else if (key=='a') {
    xmin-=zoomConst*(xmax-xmin);
    xmax-=zoomConst*(xmax-xmin);
  }
}

void drawCoords() {
  if (mousePressed && mouseButton==LEFT) {
    double xcor = Map(mouseX, 0, width, xmin, xmax);
    double ycor = Map(mouseY, 0, height, ymax, ymin);
    String toText = "("+xcor+" | "+ycor+")";
    text(toText, mouseX, mouseY);
  }
}


void drawScale() {
  float scaleAbs = width/20;
  float linlen = width/100;
  for (float x =0; x<width; x = x+scaleAbs) {
    double xcord = Map(x, 0, width, xmin, xmax);
    stroke(0);
    line(x, height, x, height-linlen);
    fill(0);
    text((float)xcord, x, height-linlen);
  }

  scaleAbs = height/20;
  linlen = height/100;
  for (float y =0; y<height; y = y+scaleAbs) {
    double ycord = Map(y, 0, height, ymin, ymax);
    stroke(0);
    line(0, height-y, linlen, height-y);
    fill(0);
    text((float)ycord, linlen, height-y);
  }
}

void setWindow(double xi, double xa, double yi, double ya) {
  xmin = xi;
  xmax = xa;
  ymin = yi;
  ymax = ya;
}

void resetWindow() {
  //scale: 1 ^= width/4
  xmin = -2;
  xmax = 2;
  ymin = -(height/2.0)/(width/4.0);
  ymax = (height/2.0)/(width/4.0);
}

void zoomIn(double x, double y, boolean mouse) {
  //detect in which proportion the point lies on the window
  double w;
  double h;
  if (mouse) {
    w = width;
    h = height;
    y= height-y;
  } else {
    w=xmax-xmin;
    h=ymax-ymin;
    x=x-xmin;
    y=y-ymin;
  }
  double xfac = x/w;
  double yfac = y/h;
  //increase factor = zoomConst*plotterheight/width
  double xIncr = (xmax-xmin)*zoomConst;
  double yIncr = (ymax-ymin)*zoomConst;
  //zoom in: xmin++, xmax--, ymin++, ymax--
  xmin = xmin + xfac*xIncr;
  xmax = xmax - (1-xfac)*xIncr;
  ymin = ymin + yfac*yIncr;
  ymax = ymax - (1-yfac)*yIncr;
}
void zoomOut(double x, double y, boolean mouse) {
  //detect in which proportion the point lies on the window
  double w;
  double h;
  if (mouse) {
    w = width;
    h = height;
  } else {
    w=xmax-xmin;
    h=ymax-ymin;
    x = x-xmin;
    y = y-ymin;
  }
  double xfac = x/w;
  double yfac = y/h;
  //increase factor = zoomConst*windowlength/width
  double xIncr = (xmax-xmin)*zoomConst;
  double yIncr = (ymax-ymin)*zoomConst;
  //zoom out: xmin--, xmax++, ymin--, ymax++
  //inverse from zoom in, therefore 1-fac->fac, fac->1-fac
  xmin = xmin - xfac*xIncr;
  xmax = xmax + (1-xfac)*xIncr;
  ymin = ymin - (1-yfac)*yIncr;
  ymax = ymax + yfac*yIncr;
}

double Map(double value, double istart, double istop, double ostart, double ostop) {
  return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}
