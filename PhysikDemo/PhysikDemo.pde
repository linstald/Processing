ArrayList<Mass> masses;
float xp;
float yp;
float mp;
float dt = 0.001; //the smaller the better
void setup() {
  size(800, 800);
  masses = new ArrayList<Mass>();
  for (int i = 0; i<40; i++) {
    float m = random(30, 50);
    float x = random(m, width-m);
    float y = random(m, height-m);
    float dx = random(0, 5);
    float dy = random(0, 5);
    masses.add(new Mass(x, y, dx, dy, m));
  }
}
void draw() {
  frameRate(60);
  background(255);
  for (Mass m1 : masses) {
    m1.show();
  }
  for (float i = 0; i<(1/dt); i++) {
    for (Mass m1 : masses) {
      m1.update();
      for (Mass m2 : masses) {
        if (m1.distance(m2)!=0) {
          if (m1.collidesWith(m2)) {
            PVector vel1 = m1.collide(m2);
            PVector vel2 = m2.collide(m1);
            m1.vel.set(vel1);
            m1.pos.set(m1.pos.x+vel1.x*dt, m1.pos.y+vel1.y*dt);
            m2.vel.set(vel2);
            m2.pos.set(m2.pos.x+vel2.x*dt, m2.pos.y+vel2.y*dt);
          }
        }
      }
    }
  }
}

void mousePressed() {
  xp = mouseX;
  yp = mouseY;
  mp = 100;
  fill(0);
  ellipse(xp, yp, mp, mp);
}

void keyPressed() {
  if (key == ' ') {
    masses.clear();
  }
}

void mouseDragged() {
  ellipse(xp, yp, mp, mp);
  line(xp, yp, mouseX, mouseY);
}


void mouseReleased() {
  PVector dir = new PVector(xp-mouseX, yp-mouseY);
  dir.setMag(map(dir.mag(), 0, width, 0, 20));

  masses.add(new Mass(xp, yp, dir.x, dir.y, mp));
}
