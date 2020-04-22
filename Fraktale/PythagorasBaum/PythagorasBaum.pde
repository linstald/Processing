void setup() {
  fullScreen();
  background(255);
  frameRate(30);
}
void draw() {
  background(255);
  pythbaum(width/2, height, height/6, map(mouseX,0,width,0,PI), 14);
}
void pythbaum(float x, float y, float a, float angle, int rek) {
  float angle2 = PI-angle;
  float c = a*sin(angle/2);
  float d = a*sin(angle2/2);
  if (rek>1) {
    stroke(#00FF70);
    fill(#89830E);
    translate(x, y);
    rect(-a/2, -a, a, a);
    triangle(-a/2, -a, cos(angle)*a/2, -a-sin(angle)*a/2, a/2, -a);
    translate(cos(angle)*a/2, -a-sin(angle)*a/2);
    pushMatrix();
    rotate(angle2/2);
    pythbaum(c/2, 0, c, angle, rek-1);
    rotate(-angle2/2);
    popMatrix();
    rotate(-angle/2);
    pythbaum(-d/2, 0, d, angle2, rek-1);
  } else {
    translate(x, y);
    rect(-a/2, -a, a, a);
    triangle(-a/2, -a, cos(angle)*a/2, -a-sin(angle)*a/2, a/2, -a);
    
  }
}
