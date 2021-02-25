//used to determine the window
double xmin;
double xmax;
double ymin;
double ymax;
//used to reset the window
double resxmin = -2;
double resxmax = 2;
double ym = 0;
//zoom constant is the rate of zoom by each zoomstep
final double zoomConst = 0.05;

//some switches
boolean camera = false;
boolean scale = true;
boolean coords = false;

/* this array contains Function objects. 
 * They all have a generate() function which can be called
 * to draw the corresponding image
 */
ArrayList<Function> myFuncs;

//the Function which will be shown
int toPlot = 4;

//boxZoom variables
double[] boxZoomStart = new double[4]; //x, y in [0] and [1] mouseX, mouseY in [2] and [3]
boolean boxZoom = false; //true if currently is zoomed via box

void setup() {
  size(1000, 720, P2D);
  //fullScreen(P2D, 2);
  resetWindow();

  myFuncs = new ArrayList<Function>();
  myFuncs.add(new Mandelbrot(1000, false)); 
  myFuncs.add(new Julia(1000, -0.39, 0.59, false));
  myFuncs.add(new Iterator(0.7297297332129355, 3.5));
  myFuncs.add(new Powertower(100, false));
  myFuncs.add(new Test(1000));

  myFuncs.get(toPlot).reset();
  frameRate(20);
}

void draw() {
  myFuncs.get(toPlot).generate();
  if (scale)drawScale();
  if (camera)zoomIn(-0.732141, 0.20809941, false);
  if (coords)drawCoords();
  drawboxZoom();
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
  } else if (mouseButton==LEFT) { //initialize boxZoom
    boxZoomStart[0] = Map(mouseX, 0, width, xmin, xmax);
    boxZoomStart[1] = Map(mouseY, 0, height, ymax, ymin);
    boxZoomStart[2] = mouseX;
    boxZoomStart[3] = mouseY;
    boxZoom =true;
  }
}
void mouseReleased() {
  if (boxZoom) { //if currently zooming, zoom!
    boxZoom= false;
    if(boxZoomStart[2]==mouseX && boxZoomStart[3]==mouseY) { //but only if not just a single click
      return;
    }
    double xit = boxZoomStart[0];
    double xat = Map(mouseX, 0, width, xmin, xmax);
    double xi = Math.min(xit, xat);
    double xa = Math.max(xit, xat);
    double ymouse = Map(mouseY, 0, height, ymax, ymin);
    double ym = boxZoomStart[1]+(ymouse-boxZoomStart[1])/2.;
    setWindowZoom(xi, xa, ym);
  }
}
void keyPressed() { //handling keyboard inputs (with a nice giant if else)
  if (key=='i') { //save image
    String name = "image"+year()+month()+day()+hour()+minute()+frameCount+".png";
    save(name);
    println("saved "+name);
  } else if (key=='+') {//next Function
    toPlot = (toPlot+1)%myFuncs.size();
    myFuncs.get(toPlot).reset();
  } else if (isBetween(key, '0', '9')) { //change Function
    toPlot=(key%'0')%myFuncs.size();
    myFuncs.get(toPlot).reset();
  } else if (key=='r') {//reset current Function
    myFuncs.get(toPlot).reset();
  } else if (key=='w') {//move up
    ymin+=zoomConst*(ymax-ymin);
    ymax+=zoomConst*(ymax-ymin);
  } else if (key=='s') {//move down
    ymin-=zoomConst*(ymax-ymin);
    ymax-=zoomConst*(ymax-ymin);
  } else if (key=='d') {//move right
    xmin+=zoomConst*(xmax-xmin);
    xmax+=zoomConst*(xmax-xmin);
  } else if (key=='a') {//move left
    xmin-=zoomConst*(xmax-xmin);
    xmax-=zoomConst*(xmax-xmin);
  } else if (key=='k') {//toggle camera
    camera = !camera;
  } else if (key=='x') {//toggle scale
    scale =!scale;
  } else if (key=='c') {//toggle coordinates
    coords = !coords;
  } 
}

//draws the current coordinates of mouse position
void drawCoords() {
  if (mousePressed && mouseButton==LEFT) {
    double xcor = Map(mouseX, 0, width, xmin, xmax);
    double ycor = Map(mouseY, 0, height, ymax, ymin);
    String toText = "("+xcor+" | "+ycor+")";
    text(toText, mouseX, mouseY);
    println(toText);
  }
}

//draws the scale/axes
void drawScale() {
  //x axis
  float scaleAbs = width/20;
  float linlen = width/100;
  for (float x =0; x<width; x = x+scaleAbs) {
    double xcord = Map(x, 0, width, xmin, xmax);
    stroke(0);
    line(x, height, x, height-linlen);
    fill(0);
    text((float)xcord, x, height-linlen);
  }
  //y axis
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
//draws the rectangle for the boxzoom
void drawboxZoom() {
  if (boxZoom) {
    float x1 = (float)boxZoomStart[2];
    float y1 = (float)boxZoomStart[3];
    fill(#1C9BFF, 150);
    stroke(0);
    strokeWeight(2);
    rect(x1, y1, mouseX-x1, mouseY-y1);
  }
}

//like map for double
double Map(double value, double istart, double istop, double ostart, double ostop) {
  return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}
//returns if x is in [a,b]
boolean isBetween(double x, double a, double b) {
  return a<=x&&x<=b;
}
