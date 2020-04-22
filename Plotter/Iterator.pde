class Iterator extends Function {
 int iterations;
 double rate;
 double xinit;
 double yinit;
 Iterator(double xinit, double rate) {
  iterations = 0;
  this.xinit = xinit;
  this.rate = rate;
  colorMode(RGB, 255, 255, 255);
 }
 void generate() {
   
   double prevy = 0;
   for(int i = 0; i<width; i++) {
     double x=Map(i,0,width, xmin, xmax);
     double y = Map(rate*x*(1-x), ymin, ymax, height, 0);
     stroke(0);
     strokeWeight(1);
     line(i-1, (float)prevy, i, (float)y);
     x = Map(x, ymin, ymax, height, 0);
     line(i-1,(float)x, i,(float)x);
     prevy = y;
   }
   int k = 0;
   double x =xinit;
   double y = 0;
   while(k<iterations) {
     double ytemp = rate*x*(1-x);
     double xcord = Map(x, xmin, xmax, 0, width);
     double ycord = Map(y, ymin, ymax, height, 0);
     double ytempcord = Map(ytemp, ymin, ymax, height, 0);
     double xycord = Map(ytemp, xmin, xmax, 0, width);
     line((float)xcord, (float)ycord, (float)xcord, (float)ytempcord);
     line((float)xcord, (float)ytempcord, (float)xycord, (float)ytempcord);
     x = ytemp;
     y = ytemp;
     k++;
   }
   iterations++;
 }
 
 void reset() {
   iterations=0;
   colorMode(RGB, 255, 255, 255);
 }
}
