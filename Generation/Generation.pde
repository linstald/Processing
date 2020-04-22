Population p;
Player best;
ArrayList<Obstacle> obst = new ArrayList<Obstacle>();
int maxdur;
int count = 0;
int generation = 1;
PVector target;
PVector start;

void setup() {
  size(1200, 800);
  maxdur = 600;
  frameRate(70);
  target = new PVector(random(30,width+30), random(30,height-30));
  start = new PVector(width/2, height/2);
  p = new Population(1000);
  obst.add(new Obstacle(600, 70, 150, 20, new PVector(0, 80)));
  obst.add(new Obstacle(60, 360, 20, 120, new PVector(1, 50)));
  obst.add(new Obstacle(340, 600, 150, 20, new PVector(2, 0)));
  obst.add(new Obstacle(700, 120, 30, 400, new PVector(2, 0)));
}
void draw() {
  if (count >= maxdur) {
    p.calcFitness();
    best = new Player(start.x, start.y, p.getBestDna());
    p.newpopul();
    for (Obstacle o : obst) {
      o.reset();
    }
    count = 0;
    generation++;
  }

  background(255);
  fill(0);
  text("Zeit: "+count, width-150, 20);
  text("#Generationen: "+generation, width-150, 35);
  text("#getroffen: "+p.reachcount, width-150, 50);
  fill(#00FF30);
  rect(width-150, 55, 10, 10);
  fill(0);
  text(": momentan Bester", width-140, 65);
  fill(#FFB700);
  rect(width-150, 70, 10, 10);
  fill(0);
  text(": Bester letzte Generation", width-140, 80);

  for (Obstacle o : obst) {
    o.show();
  }

  p.update();
  p.calcFitness();

  if (generation > 1) {
    best.update();
    best.show(color(#FFB700));
  }
  fill(#FF001E);
  ellipse(target.x, target.y, 30, 30);
  count++;
}

boolean isbetween(float x, float b1, float b2) {
  return (x>b1&&x<b2);
}