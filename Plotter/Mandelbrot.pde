class Mandelbrot extends Function {
  int iterations;
  color[] farben;
  boolean colormode;
  //Constructor
  Mandelbrot(int iterations, boolean colormode) {
    this.iterations = iterations;
    this.colormode = colormode;
    if (colormode) {
      farben = new color[11];
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
    } else {
      colorMode(HSB, iterations, 100, 100);
    }
  }
  //method to draw set according to iterations and 'farben' array
  void generate() {
    loadPixels();
    for (int i = 0; i < width; i = i+1) {
      for (int j = 0; j < height; j = j+1) {
        double a = Map(i, 0, width, xmin, xmax);
        double b = Map(j, 0, height, ymax, ymin);
        int k = 0;
        double x=0;
        double y=0;
        int farbe;
        while (k<iterations && (x*x + y*y) < 4) {
          double t = (x*x) - (y*y) + a;
          y = 2*x*y+b;
          x = t;
          k++;
        }
        if (colormode) {
          if (k<iterations) {
            farbe = k%10;
          } else {
            farbe = 10;
          }
          pixels[i+j*width]=farben[farbe];
        } else {
          if (k<iterations) {
            pixels[i+j*width]=color(k, 100, 100);
          } else {
            pixels[i+j*width]=color(0, 0, 0);
          }
        }
      }
    }
    updatePixels();
  }

  void reset() {
    if (colormode) {
      colorMode(RGB, 255, 255, 255);
    } else {
      colorMode(HSB, iterations, 100, 100);
    }
  }
}
