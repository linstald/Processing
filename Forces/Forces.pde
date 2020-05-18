
final float TIME_UNIT = 1; //trepresents accuracy of animation;draw loop will calculate phyics 1/TIME_UNIT times
final float GRAVITY = 0.2;


ArrayList<Ball>  balls; //list of balls

ArrayList<GroundSegment> gs; //list of GroundSegments

boolean debug = false; //true: balls will draw their forces, velocity, various Points
IntersectionHandler collHandler = new IntersectionHandler(); //offers intersection calc methods

Util utils = new Util(); //offers util methods in a more generous level

int max_pop = 5000; //max Balls in balls
float min_size = 20; //minimum Ball size
float max_size = 50; //maximum Ball size

PVector gravity = new PVector(0, GRAVITY); //global gravity force
PVector windF = new PVector(); //windforce, direction steered by arrowkeys...
float windMag; //... magnitude of windforce

boolean add = true; //true: mouse interactions will add Balls; false: mouse interactions will draw Segments


void setup() {
  size(1920, 1080); //Full HD
  balls = new ArrayList<Ball>();
  gs = new ArrayList<GroundSegment>();
  windMag = (min_size+random(max_size-min_size))*GRAVITY;
  restoreWalls();
}




PVector start;//starting Vector for the added GroundSegments

void draw() {
  background(255);
  //draw Balls and Segments
  for (Ball b : balls) {
    b.show();
  }
  for (GroundSegment g : gs) {
    g.show();
  }
  //calculate physics
  float freq = 1/TIME_UNIT;
  for (int i = 0; i<freq; i++) {
    for (Ball b : balls) {
      b.update(gs);
      b.applyForce(windF);
    }
  }
  showText();
  if (!add&&mousePressed) {
    stroke(0);
    strokeWeight(1);
    if (start!=null)line(start.x, start.y, mouseX, mouseY);
  }
}


void mousePressed() {
  if (add) {
    balls.add(new Ball(random(min_size, max_size), mouseX, mouseY, 0, 0));
    if (balls.size()>max_pop) {
      balls.remove(0);
    }
  } else {
    start = new PVector(mouseX, mouseY);
  }
}

void mouseReleased() {
  if (!add) {

    gs.add(new GroundSegment(start.x, start.y, mouseX, mouseY));
  }
}

void mouseDragged() {
  if (add) {
    balls.add(new Ball(random(min_size, max_size), mouseX, mouseY, random(0), random(0)));
    if (balls.size()>max_pop) {
      balls.remove(0);
    }
  } else {
    line(start.x, start.y, mouseX, mouseY);
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case RIGHT:
      windF.set(windMag, 0);
      break;
    case LEFT:
      windF.set(-windMag, 0);
      break;
    case DOWN:
      windF.set(0, windMag);
      break;
    case UP:
      windF.set(0, -windMag);
      break;
    }
  } else {
    switch(key) {
    case ' ': 
      balls.clear();
      break;
    case 'c':
      gs.clear();
      restoreWalls();
      break;
    case 's':
      add = !add;
      break;
    case 'd':
      debug =!debug;
      break;
    case 'r':
      setup();
      break;
    }
  }
}

void keyReleased() {
  windF.set(0, 0);
}

void restoreWalls() {
  gs.add(new GroundSegment(0, 0, width, 0));
  gs.add(new GroundSegment(width, 0, width, height));
  gs.add(new GroundSegment(width, height, 0, height));
  gs.add(new GroundSegment(0, height, 0, 0));
}

void showText() {
  int textSize = width/75;
  textSize(textSize);
  fill(0);
  text(add?"Ball":"Segment", width- textSize*6, textSize*2);
  text(debug?"Debug":"Normal", width-textSize*6, textSize*3);
  text("Wind: "+nf(windMag,0,2), width-textSize*6, textSize*4);
}
