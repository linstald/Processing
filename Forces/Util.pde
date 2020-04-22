class Util {
 
  /**
   *  returns true if x is in between range a to b
   */
  boolean isBetween(float x, float a, float b) {
    return abs(a-x)<=abs(a-b)&&abs(b-x)<=abs(a-b);
  }


  /**
   *  draws a Vector v at position pos with color c
   **/

  void drawVector(PVector v, PVector pos, color c) {
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(3);
    stroke(c);
    fill(c);
    line(0, 0, v.x, v.y);
    rotate(v.heading());
    float arrowSize = min(v.mag()+1, 10);
    translate(v.mag()-arrowSize, 0);
    triangle(0, arrowSize / 2, 0, -arrowSize / 2, arrowSize, 0);
    popMatrix();
  }
  /**
   *  returns true if x and y are equal with a error of delta
   */
  boolean isInRange(float x, float y, float delta) {
    return abs(x-y)<delta;
  }
  /**
   *  returns the value of the component division
   *  of two vectors, (i.e. (x, y)'/'(u, v) = x/u = y/v)
   *  its the inverse function of the scalar multiplication
   *  with respect to division by zero exceptions
   */
  float scalarQuotient(PVector a, PVector b) {
    if (b.x==0) {
      if (b.y==0) {
        return Float.MAX_VALUE;
      }
      return a.y/b.y;
    }
    return a.x/b.x;
  }
}
