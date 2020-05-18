double xMin = -1.2;
double xMax = 1.52;
double yMin = -0.2;
double yMax = 3;

ArrayList<Interval> intervals;

void setup() {
  size(1000, 800);
  intervals =new ArrayList<Interval>();
  intervals.add(new Interval(xMin, xMax));
}

void draw() {
  background(255);
  double area = 0;
  for(Interval i : intervals) {
    i.drawRectLess();
    area+=i.area();
  }
  println("Empiric: " +area+" | Actual: "+(F(xMax)-F(xMin)));
  drawFunction();
}

void mousePressed(){
 ArrayList<Interval> copy=new ArrayList<Interval>(intervals);
 intervals.clear();
 for(Interval i : copy){
   Interval[] arr =i.smaller();
   intervals.add(arr[0]);
   intervals.add(arr[1]);
 }
 println(intervals.size());
}

double f(double x) {
  return -(x*x*x*x)+(x*x*x)+(x*x)-x+1;
}

double F(double x) {
  return -(x*x*x*x*x)/5+(x*x*x*x)/4+(x*x*x)/3-(x*x)/2+x;
}

double minf(double a, double b) {
  double locMin = 0.125*(sqrt(17)-1);
  if(isBetween(locMin, a, b)) {
    return min(f(locMin), f(a), f(b));
  }else {
    return min(f(a), f(b));
  }
    
}

double map(double x, double a, double b, double c, double d) {
  return c+((x-a)/(b-a))*(d-c);
}

void drawFunction() {
  float prev = (float)map(f(xMin), yMin, yMax, height, 0);
  for (int i = 0; i<=width; i++) {
    double x = map(i, 0, width, xMin, xMax);
    double y = f(x);
    float j = (float)map(y, yMin, yMax, height, 0);
    stroke(255,0,0);
    strokeWeight(4);
    line(i-1, prev, i, j);
    prev=j;
  }
}

boolean isBetween(double x, double a, double b) {
   return a<=x && x<=b;
}

double min(double a, double b) {
  return a<b?a:b;
}
double min(double a, double b, double c) {
  return min(min(a, b), c);
}
