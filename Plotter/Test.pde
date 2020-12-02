import java.lang.Math;

class Test extends Function {
  int iterations;
  color[] colors;
  double threshold;
  Complex c;
  Complex z;
  Test(int iterations) {
    this.iterations = iterations;
    this.threshold = Math.exp(iterations);
    this.c = new Complex();
    this.z = new Complex();

    colorMode(HSB, iterations, 100, 100);
  }

  void generate() {
    loadPixels();
    for (int j = 0; j < height; j = j+1) {
      for (int i = 0; i < width; i = i+1) {

        double a = Map(i, 0, width, xmin, xmax);
        double b = Map(j, 0, height, ymax, ymin);
        c.set(a, b);
        z.set(1, 0);
        int k = 0;

        while (k<iterations && z.absSq() < threshold) {
          Complex t = z.add(z, c);
          z = t.mult(t);
          k++;
        }

        if (k<iterations) {
          pixels[i+j*width]=color(k, 100, 100);
        } else {
          pixels[i+j*width]=color(0, 0, 0);
        }
      }
    }
    updatePixels();
  }
  void reset() {
    setWindow(-30, 30, 0);
    colorMode(HSB, iterations, 100, 100);
  }
}
