class Ball {
  float mass;
  float r;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector weight;

  ArrayList<PVector> forces;

  Ball(float mass, float x, float y, float xvel, float yvel) {
    this.mass = mass;
    r = mass/2;
    pos = new PVector(x, y);
    vel = new PVector(xvel, yvel);
    acc = new PVector();
    weight = PVector.mult(gravity, mass);

    forces = new ArrayList<PVector>();
  }

  void show() {
    fill(0);
    stroke(0);
    strokeWeight(1);
    circle(pos.x, pos.y, 2*r);
    if (debug)utils.drawVector(PVector.mult(vel, 2*r), pos, color(0, 255, 0));
    
  }

  void update(ArrayList<GroundSegment> gs) {
    
    //calculate forces which apply always
    applyLocalForces();

    //calculate physics (i.e. collisions and movement)
    collisions(gs);
    vel.add(PVector.mult(acc, TIME_UNIT));
    pos.add(PVector.mult(vel, TIME_UNIT));
    
    if (debug)drawForces();
    //refresh forces and acceleration
    forces.clear();
    acc.set(0, 0);
    
  }

  void applyLocalForces() {
    //gravity
    applyForce(weight);
    //friction
    applyForce(friction());
  }

  PVector friction() {
    return PVector.mult(vel, (-1)*vel.magSq()*0.0001*mass);
  }
  void collisions(ArrayList<GroundSegment> gs) {
    for (GroundSegment g : gs) {
      collision(g);
    }
  }

  /**
   *  determines wheter the ball is colliding with the GroundSegment gs
   *  and calculates the new velocity
   **/
  void collision(GroundSegment gs) {
    //helping vector
    PVector normal = gs.getNormal(this);

    float dist = gs.distance(this);
    if (abs(dist)<r) {
      /*
      distance < r => ball is interleaving with the segment
      this is in general false, as the position should be corrected such that 
      the distance between the gs and the ball gets 0, therefore in opposite direction
      of the velocity with a magnitude calculated with an expensive calculation
      therefore sometimes in a steep gs, the ball just slide down, without velocity change
      */
      pos.add(PVector.mult(normal, abs(r-abs(dist))));
    }

    /*
    if intersecting in next timeunit do the following steps, else go on
    1. calculate the Intersectionpoint of the ball and the segment
    2. calculate exact time of intersection
    3. set position to the colliding point
    4. calculate new direction of velocity by the principle of "entryangle = exitangle"
      4.1. determine angle of intersection (we use negative velocity to get the smaller angle)
      4.2. calculate the angle of rotation of the normal and the velocity vector
           which is rotated counterclockwise by the angle calculated above
      4.3. if you can rotate the negative vel vector counter clockwise and get (nearly)
           the normal vector of the segment, you can rotate the vector twice and get the new
           velocity. If not you have to rotate clockwise, therefore negate the angle
    5. add vel * remaining time of this time step to the position
    */
    
    PVector intersection = collHandler.intersect(this, gs);
    
    PVector nPoint = getnPoint(gs);
    //debug drawings
    stroke(0, 0, 255);
    strokeWeight(5);
    if (debug)point(nPoint.x, nPoint.y);
    
    
    if (intersection!=null) {
      
      float time = utils.scalarQuotient(PVector.sub(intersection, nPoint), vel);
      
      pos.add(PVector.mult(vel, time));
      
      float angle = PVector.angleBetween(normal, vel.mult(-1));
      PVector velCopy = vel.copy();
      
      float hNormal = normal.heading();
      float hvelRot = velCopy.rotate(angle).heading();
      
      if (!utils.isInRange(hvelRot, hNormal, 0.0001)) {
        angle *= -1;
      }
      vel.rotate(2*angle);
      vel.mult(0.99999);
      pos.add(PVector.mult(vel, TIME_UNIT-time));
    }
  }
  
  /**
  *  returns the neares Point of the edge of the Ball
  *  to the GroundSegment gs
  */
  PVector getnPoint(GroundSegment gs) {
    PVector negNormal = gs.getNormal(this).mult(-r);
    return PVector.add(pos, negNormal);
  }
  /**
   *  applies a force f to the accleration according to Newton's laws
   **/
  void applyForce(PVector f) {
    forces.add(f);
    acc.add(PVector.div(f, mass));
  }
  /**
   *  generates a force according to the given acceleration a
   **/
  void generateForce(PVector a) {
    applyForce(PVector.mult(a, mass));
  }
  /**
   *  draws the forces which act on the ball
   **/
  void drawForces() {
    for (PVector v : forces) {
      PVector V = v.copy();
      V.mult(2*r);
      utils.drawVector(V, pos, color(255, 0, 0));
    }
  }
}
