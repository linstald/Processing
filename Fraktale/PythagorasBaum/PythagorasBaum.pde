void setup() {
  fullScreen();
  background(255);
  strokeWeight(2);
  frameRate(24);
}
float w = 0;
void draw() {
  background(255);
  pythbaum(width/2, height, height/6, map(sin(w+=0.01),-1,1, HALF_PI/3, 2*HALF_PI/3), 7);
}
void pythbaum(float x, float y, float a, float angle, int rek) {
  translate(x, y); //set the origin to the position of the pythbaum
  
  float angle2 = HALF_PI-angle;
  float c = a*sin(angle); //length of right pythbaum base
  float d = a*cos(angle); //length of left pythbaum base
  float topx = -a/2+d*cos(angle); //coordinates of top of triangle
  float topy = -a-d*sin(angle);
  
  if(rek>1) stroke(#643B05); else stroke(#009818);
  fill(rek>1?#643B05:#009818);
  rect(-a/2, -a, a, a); //draw the stem
  triangle(-a/2, -a, topx, topy, a/2, -a); //draw the triangle
  
  if (rek>1) {
    translate(-a/2+cos(angle)*d, -a-sin(angle)*d); //top of triangle is now (0,0)
    pushMatrix();
    rotate(angle2); //rotate to the right with composite angle
    pythbaum(c/2, 0, c, angle2, rek-1); //draw the right pythbaum
    rotate(-angle2); //rotate back
    popMatrix();
    rotate(-angle); //rotate to the left with angle
    pythbaum(-d/2, 0, d, angle, rek-1); //draw the left pythbaum
  }
}
