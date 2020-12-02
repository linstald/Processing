import java.lang.Math;
/**
 *  a class which implements complex numbers
 *  re = real part
 *  im = imaginary part
 *  => Complex z = new Complex(a, b) = a+bi
 */

class Complex {
  double re;
  double im;

  //Constructors
  Complex() {
    this.re= 0;
    this.im=0;
  }

  Complex(double re, double im) {
    this.re = re;
    this.im = im;
  }

  Complex(Complex c) {
    this.re = c.re;
    this.im = c.im;
  }

  Complex set(double re, double im) {
    this.re = re;
    this.im = im;
    return this;
  }

  /**
   *  copies coordinates of this to a new Complex
   */
  Complex copy() {
    return new Complex(re, im);
  }
  /**
   *  adds this to z
   *  (a+bi)+(c+di)=(a+c)+(b+d)i
   *  returns this
   */
  Complex add(Complex z) {
    this.re+=z.re;
    this.im+=z.im;
    return this;
  }
  /**
   *  adds w to z and returns a new Complex w+z
   */
  Complex add(Complex w, Complex z) {
    return new Complex(w.re+z.re, w.im+z.im);
  }
  /**
   *  subtracts z from this
   *  (a+bi)-(c+di)=(a-c)+(b-d)i
   *  returns this
   */
  Complex sub(Complex z) {
    this.re-=z.re;
    this.im-=z.im;
    return this;
  }
  /*
  *  subtract z from w and returns a new Complex w-z
   */
  Complex sub(Complex w, Complex z) {
    return new Complex(w.re-z.re, w.im-z.im);
  }
  /**
   *  multiplies this with z
   *  (a+bi)*(c*di)=(ac-bd)+(ad+bc)i
   *  returns this
   */
  Complex mult(Complex z) {
    double tempre = this.re*z.re-this.im*z.im;
    this.im = this.re*z.im+this.im*z.re;
    this.re = tempre;
    return this;
  }
  /**
   * multiplies w with z and returns a new Complex w*z
   */
  Complex mult(Complex w, Complex z) {
    return new Complex(w.re*z.re-w.im*z.im, w.re*z.im+w.im*z.re);
  }
  /**
   *  scales this with t
   *  (a+bi)*t=ta+tbi
   *  returns this
   */
  Complex scale(double t) {
    this.im *= t;
    this.re *= t;
    return this;
  }
  /**
   *  scales w with t
   *  (a+bi)*t=ta+tbi
   *  returns w*t
   */
  Complex scale(Complex w, double t) {
    return new Complex(w.im * t, w.re * t);
  }
  /**
  *  divides this by z
  *  (a+bi)/(c+di) = (a+bi)*(c-di)/(c^2+d^2)
  *  returns this
  */
  Complex div(Complex z) {
    return mult(z.conj()).scale(1/z.absSq());
  }
  /**
  *  divides w by z
  *  (a+bi)/(c+di) = (a+bi)*(c-di)/(c^2+d^2)
  *  returns new Complex w/z
  */
  Complex div(Complex w, Complex z) {
    return new Complex(w.mult(w, z.conj()).scale(1/z.absSq()));
  }
  /**
   *  raises this to the z
   *  (a+bi)^(c+di) = (r*e^(i*phi))^(c+di)=e^((ln(r)*c-phi*d)+i*(ln(r)*d+phi*c))
   *  returns this
   */
  Complex pow(Complex z) {
    if (this.re==0 && this.re==0) {
      if (z.im!=0 || z.re!=0) {
        return new Complex();
      } else {
        return new Complex(1, 0);
      }
    }
    double r = this.abs();
    double phi = this.arg();

    double R = Math.exp(Math.log(r)*z.re-phi*z.im);
    double T = Math.log(r)*z.im+phi*z.re;

    re = R*Math.cos(T);
    im = R*Math.sin(T);
    return this;
  }
  /**
   * raises w to the z
   * returns new Complex w^z
   */
  Complex pow(Complex w, Complex z) {
    if (w.re==0 && w.re==0) {
      if (z.im!=0 || z.re!=0) {
        return new Complex();
      } else {
        return new Complex(1, 0);
      }
    }
    double r = w.abs();
    double phi = w.arg();

    double R = Math.exp(Math.log(r)*z.re-phi*z.im);
    double T = Math.log(r)*z.im+phi*z.re;


    double a = R*Math.cos(T);
    double b = R*Math.sin(T);
    return new Complex(a, b);
  }
  /**
   *  absloute value of a Complex
   */
  double abs() {
    return Math.sqrt(re*re+im*im);
  }
  /**
   *  conjugate of a Complex
   */
  Complex conj() {
    return new Complex(re, -im);
  }
  /**
   *  absolute value squared of a Complex
   */
  double absSq() {
    return re*re+im*im;
  }
  /**
   *  the argument when writing in polarform
   *  i.e. phi in (a+bi)=r*e^(i*phi)
   */
  double arg() {
    if (re==0) {
      if (im>=0) {
        return HALF_PI;
      }
      return -HALF_PI;
    }
    return Math.atan2(im, re);
  }
}
