ArrayList<PVector> snake;
PVector target;
void setup() {
  size(800, 800);
  snake = new ArrayList<PVector>();

  snake.add(new PVector(0, 0));
  //println("anfang "+snake);
  frameRate(60);
  target = new PVector(random(50, width), random(50, height));
}


void draw() {

  background(255);
  boolean no = false;

  for (int i = snake.size()-1; i>=0; i--) {
    PVector v = snake.get(i);
    fill(48, map(i, 0, snake.size(), 255, 100), 10);
    noStroke();
    ellipse(v.x, v.y, 50, 50);
  }
  fill(205, 65, 54);
  ellipse(target.x, target.y, 50, 50);

  PVector last = snake.get(snake.size()-1);
  PVector dir = new PVector(mouseX-last.x, mouseY-last.y);
  dir.setMag(5);
  PVector toadd = new PVector(last.x+dir.x, last.y+dir.y);
  snake.add(toadd);

  if (dist(last.x, last.y, target.x, target.y)<50) {
    no = true;
    setnewtarget();
  }
  if (!no) {
    snake.remove(0);
  }
  //println("nach addr "+snake);
  //println(snake.size());
}


void setnewtarget() {
  target.x = random(50, width);
  target.y = random(50, height);

  for (PVector v : snake) {
    if (dist(v.x, v.y, target.x, target.y)<25) {
      setnewtarget();
    }
  }
}


void keyPressed() {
  if (key == ' ') {
    snake.add(new PVector(snake.get(snake.size()-1).x, snake.get(snake.size()-1).y));
    println(snake.size());
  }
  
}
