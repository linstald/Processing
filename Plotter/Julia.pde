class Julia extends Function {
  int iterations;
  Complex c;
  Complex z;
  color[] colors;
  boolean colormode;
  Julia(int iterations, double x, double y, boolean colormode) {
    this.iterations=iterations;
    this.colormode =colormode;
    this.c = new Complex(x, y);
    this.z = new Complex();
    if (colormode) {
      colors = new color[11];
      colors [0] = color(#FF0000);
      colors [1] = color(#FF00C4);
      colors [2] = color(#B200FF);
      colors [3] = color(#2D00FF);
      colors [4] = color(#008EFF);
      colors [5] = color(#00FFCA);
      colors [6] = color(#00FF30);
      colors [7] = color(#C3FF00);
      colors [8] = color(#FFC800);
      colors [9] = color(#FF5E00);
      colors [10] = color(#000000);
    } else {
      colorMode(HSB, iterations, 100, 100);
    }
  }

  void generate() {
    loadPixels();
    for (int j = 0; j < height; j = j+1) {
      for (int i = 0; i < width; i = i+1) {

        double a = Map(i, 0, width, xmin, xmax);
        double b = Map(j, 0, height, ymax, ymin);
        z.set(a, b);
        int k = 0;  

        while (k<iterations && z.absSq() < 4) {
          z.mult(z).add(c);
          k++;
        }
        int col;
        if (colormode) {
          if (k<iterations) {
            col = k%10;
          } else {
            col = 10;
          }
          pixels[i+width*j]=colors[col];
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
    setWindow(-2, 2, 0);
    if (colormode) {
      colorMode(RGB, 255, 255, 255);
    } else {
      colorMode(HSB, iterations, 100, 100);
    }
  }
}
