import java.lang.Math;
class Interval {
  double a;
  double b;
  double area=0;
  Interval(double a, double b) {
    this.a =a;
    this.b =b;
  }

  Interval[] smaller() {
    double frac = (b-a)/3;
    double split = (a+frac)+Math.random()*((b-frac)-(a+frac));
    Interval first = new Interval(a, split);
    Interval second = new Interval(split, b);
    Interval[] arr = {first, second};
    return arr;
  }
  void drawRectLess() {
    double min = minf(a,b);
    float x = (float)map(a, xMin, xMax, 0, width);
    float w = (float)map(b-a, 0, xMax-xMin, 0, width);
    float h = (float)map(minf(a, b), yMin, yMax, 0, height);
    stroke(0);
    strokeWeight(1);
    fill(20, 255,160, 80);
    rect(x,height, w, -h);
    area = (b-a)*min;
  }
  
  double area() {
    return area;
  }
  
  
}
