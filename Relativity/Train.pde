class Train {
  PVector pos;
  PVector vel;
  float anten1;
  float anten2;
  float len;
  boolean rayupdate = false;
  boolean stop = false;
  Ray r1;
  Ray r2;

  Train(float x, float y, float vel) {
    pos = new PVector(x, y);
    len = width/3;
    this.vel = new PVector(vel, 0);
    anten1 = pos.x-len/2;
    anten2 = pos.x+len/2;
  } 

  void update() {
    if (!stop) {
      pos.add(vel);
    } else {
      rect(r1.pos.x, r1.pos.y+25, 10, 50);
    }
    anten1 = pos.x-len/2;
    anten2 = pos.x+len/2;
    if (rayupdate) {
      r1.update();
      r2.update();
      r1.show();
      r2.show();
      //if (r1.reach(pos)) {
      //  println("Ray 1 has reached Center");
      //}
      //if (r2.reach(pos)) {
      //  println("Ray 2 has reached Center");
      //}
      if (r1.reach(r2)) {
        //println("Arrival in Perspective of not moved observer");
        rayupdate = false;

        //r1 = null;
        //r2 = null;
        stop = true;
      }
    }
  }

  void show() {
    fill(255);
    stroke(0);
    rect(pos.x, pos.y, len, 30); //draw train
    strokeWeight(3);
    line(pos.x, pos.y+15, pos.x, pos.y);
  }
  

  void sendRays() {
    rayupdate = true;
    r1 = new Ray(new PVector(anten1, pos.y), 1);
    r2 = new Ray(new PVector(anten2, pos.y), -1);
  }
}
