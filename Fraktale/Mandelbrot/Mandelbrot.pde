float x;
float y;
float a;
float b;
float xmin = -2.5;
float xmax = 1.5;
float ymin = -1.5;
float ymax = 1.5;
int k;
float t;
int farbe;
color [] farben = new color[11];
int iterations = 20;

void setup() {
  farben [0] = color(#FF0000);
  farben [1] = color(#FF00C4);
  farben [2] = color(#B200FF);
  farben [3] = color(#2D00FF);
  farben [4] = color(#008EFF);
  farben [5] = color(#00FFCA);
  farben [6] = color(#00FF30);
  farben [7] = color(#C3FF00);
  farben [8] = color(#FFC800);
  farben [9] = color(#FF5E00);
  farben [10] = color(#000000);
  size(1200, 900);

  drawMandelbrot(); 
  save("mandelbrot.png");
}

void draw(){
  drawMandelbrot();
}
void keyPressed(){
  if(key=='+'){
    xmin+=0.1;
    xmax-=0.1;
    ymin+=0.1;
    ymax-=0.1;
  }
  if(key=='-') {
    xmin-=0.1;
    xmax+=0.1;
    ymin-=0.1;
    ymax+=0.1;
  }
}
void drawMandelbrot(){
   for (int i = 0; i < height; i = i+1) {
    for (int j = 0; j < width; j = j+1) {
      a = map(j, 0, width, xmin, xmax);
      b = map(i, 0, height, ymin, ymax);
      k = 0;
      x=0;
      y=0;
      while (k<iterations && (x*x + y*y) <4) {
        t = (x*x) - (y*y) + a;
        y = 2*x*y+b;
        x = t;
        k++;
      }
      if (k<iterations) {
        farbe = k%10;
      } else {
        farbe = 10;
      }
      fill(farben[farbe]);
      noStroke();
      rect(j,i, 1, 1);
      rect(j, -i, 1, 1);
    }
  }
}
