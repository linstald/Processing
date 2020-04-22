class Form {

  //Attribute
  PVector pos;
  PVector vel;
  float speed;
  float rotationphase = 0;
  float rotationspeed;
  float r;
  ArrayList<PVector> border;
  color c;



  //Konstruktor
  Form(float x, float y, float r) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(random(-width/6, width/6), random(-height/2, -2*height));
    this.speed = random(5, 30);
    this.rotationspeed = random(0, 1);
    this.vel.setMag(speed);
    this.r = r;
    this.c = color(random(160, 250), random(30, 100), random(20, 50));

    border = new ArrayList<PVector>();

    float noisestartx = random(0, 1000);
    float noisestarty = random(0, 1000);
    float noisevaluex;
    float noisevaluey;
    float noiseradius = random(1, 2);


    for (float a = 0; a<TWO_PI; a+= PI/r) { //border mit den verschiedenen Vektorobjekten füllen

      noisevaluex = noisestartx+cos(a)*noiseradius;
      noisevaluey = noisestarty+sin(a)*noiseradius;
      float rad = r*noise(noisevaluex, noisevaluey); 

      border.add(new PVector(rad * cos(a), rad * sin(a)));//bestimmt die art der Form in Polarkoordinaten
    }
  }

  //Methoden
  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotationphase);
    fill(c);
    beginShape();
    for (PVector v : border) {
      vertex(v.x, v.y);
    }
    endShape();
    popMatrix();
  }

  void move() {
    //position + geschwindigkeit (änderung der position per zeiteinheit)
    this.pos.add(this.vel);

    //gravitation berücksichtigen
    this.vel.x *= 0.99; //Reibung der Luft;
    this.vel.y += GRAVITY;

    //rotation
    this.rotationphase += 0.03;
  }

  boolean mouseover() {  
    return this.isinborder(mouseX, mouseY, border);
  }

  boolean isinborder(float x, float y, ArrayList<PVector> border) {
    int cxt = 0;
    int cxd = 0;
    int cyt = 0;
    int cyd = 0;


    for (int i = 0; i < border.size(); i++) {
      float borderx = border.get(i).x+pos.x;
      float bordery = border.get(i).y+pos.y;
      float nborderx;
      float nbordery;

      if (i!=border.size()-1) {
        nborderx = border.get(i+1).x+pos.x;
        nbordery = border.get(i+1).y+pos.y;
      } else {
        nborderx = border.get(0).x+pos.x;
        nbordery = border.get(0).y+pos.y;
      }

      if (isbetween(x, borderx, nborderx)) {      
        if (bordery > y) {
          cyt++;
        } else {
          cyd++;
        }
        // print(true+"x"+cyt+"/"+cyd);
      }
      if (isbetween(y, bordery, nbordery)) {
        if (borderx > x) {
          cxt++;
        } else {
          cxd++;
        }
      }
    }
    //print(cyt +" " + cyd +"/"+cxt+" "+cyd);
    if (cyt%2 == 1 && cyd%2 == 1 && cxt%2 == 1 && cxd%2 == 1) {
      return true;
    } else {
      return false;
    }
  }

  boolean isbetween(float x, float low, float  top) {
    float low_;
    float top_;
    if (low < top) {
      low_ = low;
      top_ = top;
    } else {
      low_ = top;
      top_ = low;
    }
    return x>=low_ && x<=top_;
  }
}
