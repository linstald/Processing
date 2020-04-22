class Player {
  PVector pos = new PVector();
  PVector dir = new PVector();
  Dna dna;
  float fitness;
  boolean reached = false;
  boolean crashed = false;
  float mult = 1;
  Player(float x, float y) {
    pos.x = x;
    pos.y = y;
    dna = new Dna();
  }
  Player(float x, float y,Dna dna) {
    pos.x = x;
    pos.y = y;
    this.dna = dna;
  }

  void update() {
    switch (dna.genes[count]) {
      case 0: 
        dir.x = 1;
        dir.y = 0;
        break;
      case 1:
        dir.x = -1;
        dir.y = 0;
        break;
      case 2: 
        dir.x = 0;
        dir.y = 1;
        break;
      case 3:
        dir.x = 0;
        dir.y = -1;
        break;
      default:
        dir.x = 0;
        dir.y = 0;
        break;
    }
    if (!crashed && !reached) {
    pos.add(dir.mult(10));

    for (Obstacle o : obst) {
        if(this.hitObstacle(o)){
          this.crashed = true;
        }
      }
    
    if ((!isbetween(pos.x, 0, width)) || (!isbetween(pos.y, 0, height))) {
      crashed = true;
    }
    
    if (dist(pos.x, pos.y, target.x, target.y)<25) {
      reached = true;
      mult = 10*map(count,0,maxdur, 10,1);
    }
    }
    if (crashed) {
      mult = 0.01;
    }
  }
  void calcFitness() {
    fitness = map(abs(dist(pos.x, pos.y, target.x, target.y)),0,width, 1, 0)*mult;
  }
  
  boolean hitObstacle(Obstacle obst) {
   return (isbetween(pos.x, obst.x, obst.x+obst.w) && isbetween(pos.y, obst.y, obst.y+obst.h)); 
  }
  
  void show(color c) {
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, 20, 20);
  }
}