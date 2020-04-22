class Julia extends Function {
  int iterations;
  double xinit;
  double yinit;
  color[] farben;
  boolean colormode;
  Julia(int iterations, double x, double y, boolean colormode) {
    this.iterations=iterations;
    this.colormode =colormode;
    xinit = x;
    yinit = y;
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

  void generate() {
    generate(xinit, yinit);
  }

  void generate(double a, double b) {
    loadPixels();
    for (int i = 0; i < width; i = i+1) {
      double x;
      double y;
      int farbe;
      int k;  
      for (int j = 0; j < height; j = j+1) {
        x = Map(i, 0, width, xmin, xmax);
        y = Map(j, 0, height, ymax, ymin);
        k = 0;
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
          pixels[i+width*j]=farben[farbe];
        } else {
          if (k<iterations) {
            pixels[i+width*j]=color(k, 100, 100);
          } else {
            pixels[i+width*j]=color(0, 0, 0);
          }
        }
      }
    }
    updatePixels();
  }

  void reset() {
    if(colormode){
      colorMode(RGB, 255, 255, 255);
    }else {
      colorMode(HSB, iterations, 100, 100);
    }
  }
}
