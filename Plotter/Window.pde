//sets the window, without setting the reset values
void setWindowZoom(double xi, double xa, double ymn){
  xmin = xi;
  xmax = xa;
  ymin = ymn-(height/2.0)/(width/(xa-xi));
  ymax = ymn+(height/2.0)/(width/(xa-xi));
  
}
//sets the window and also sets the reset values
void setWindow(double xi, double xa, double ymn) {
  resxmin = xi;
  resxmax = xa;
  ym = ymn;
  resetWindow();
}
//sets the window and also sets the reset values
void setWindow(double xi, double xa) {
  resxmin = xi;
  resxmax = xa;
  resetWindow();
}
//resets the window
void resetWindow() {
  xmin = resxmin;
  xmax = resxmax;
  ymin = ym-(height/2.0)/(width/(resxmax-resxmin));
  ymax = ym+(height/2.0)/(width/(resxmax-resxmin));
}

void zoomIn(double x, double y, boolean mouse) {
  //detect in which proportion the point lies on the window
  double w;
  double h;
  if (mouse) {
    w = width;
    h = height;
    y= height-y;
  } else {
    w=xmax-xmin;
    h=ymax-ymin;
    x=x-xmin;
    y=y-ymin;
  }
  double xfac = x/w;
  double yfac = y/h;
  //increase factor = zoomConst*plotterheight/width
  double xIncr = (xmax-xmin)*zoomConst;
  double yIncr = (ymax-ymin)*zoomConst;
  //zoom in: xmin++, xmax--, ymin++, ymax--
  xmin = xmin + xfac*xIncr;
  xmax = xmax - (1-xfac)*xIncr;
  ymin = ymin + yfac*yIncr;
  ymax = ymax - (1-yfac)*yIncr;
}
void zoomOut(double x, double y, boolean mouse) {
  //detect in which proportion the point lies on the window
  double w;
  double h;
  if (mouse) {
    w = width;
    h = height;
  } else {
    w=xmax-xmin;
    h=ymax-ymin;
    x = x-xmin;
    y = y-ymin;
  }
  double xfac = x/w;
  double yfac = y/h;
  //increase factor = zoomConst*windowlength/width
  double xIncr = (xmax-xmin)*zoomConst;
  double yIncr = (ymax-ymin)*zoomConst;
  //zoom out: xmin--, xmax++, ymin--, ymax++
  //inverse from zoom in, therefore 1-fac->fac, fac->1-fac
  xmin = xmin - xfac*xIncr;
  xmax = xmax + (1-xfac)*xIncr;
  ymin = ymin - (1-yfac)*yIncr;
  ymax = ymax + yfac*yIncr;
}
