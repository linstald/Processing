class Ray {
  PVector pos;
  PVector vel;
  PVector origin;

  Ray(PVector pos, int dir) {
    this.origin = pos;
    this.pos = pos;
    this.vel = new PVector(dir*C, 0 );
  }

  void update() {
    pos.add(vel);
  }

  void show() {
    fill(#FEFF00);
    noStroke();
    ellipse(pos.x, pos.y, 10, 10);
  }

  boolean reach(Ray r) {
    return dist(pos.x, pos.y, r.pos.x, r.pos.y)<5;
  }
  
  boolean reach(PVector ops) {
    return dist(pos.x, pos.y, ops.x, ops.y)<5;
  }
}
