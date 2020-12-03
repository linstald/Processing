class Mass {
  //Attribute
  PVector pos;
  PVector vel;
  PVector acc;
  float m;
  PVector p;
  boolean collided = false;
  int cto = 5;
 
  

  //Konstruktor
  Mass(float x, float y, float xd, float yd, float m) {
    pos = new PVector(x, y);
    vel = new PVector(xd, yd);
    acc = new PVector();
    p = new PVector(m*xd, m*yd);
    this.m = m;
  }

  //Methoden
  void show() {
    fill(0);
    ellipse(pos.x, pos.y, m, m);
  }

  void update() {
    vel.add(acc);
    //vel.mult(0.999); //Friction
    float tempx = vel.x*dt;
    float tempy = vel.y*dt;
    pos.add(tempx, tempy);
    p.set(vel.x*m, vel.y*m);
    bounceWalls();
    //vel.limit(10);
    
    
    if (collided) {
      cto--;
    }
    if (cto<0) {
     collided = true; 
    }
  }
  
  void bounceWalls() {
   if (pos.x>(width-m/2)) {
     vel.set(-vel.x, vel.y);
     pos.set(width-m/2, pos.y);
     //collided = true;
   }
   if (pos.x<(m/2)) {
     vel.set(-vel.x, vel.y);
     pos.set(m/2, pos.y);
     //collided = true;
   }
   if (pos.y>(height-m/2)) {
     vel.set(vel.x, -vel.y);
     pos.set(pos.x, height-m/2);
     //collided = true;
   }
   if (pos.y<(m/2)) {
     vel.set(vel.x, -vel.y);
     pos.set(pos.x, m/2);
     //collided = true;
   }
  }

  PVector collide(Mass m2) {
    float velx = 2*(((this.p.x)+(m2.p.x)) / ( this.m+m2.m))-this.vel.x;
    float vely = 2*(((this.p.y)+(m2.p.y)) / ( this.m+m2.m))-this.vel.y;
    
    return (new PVector(velx, vely));
  }

  boolean collidesWith(Mass m2) {
    //collided = true;
    return this.distance(m2)<=((this.m/2)+(m2.m/2));
  }
  
  float distance(Mass m2) {
   return dist(this.pos.x, this.pos.y, m2.pos.x, m2.pos.y);
  }
}
