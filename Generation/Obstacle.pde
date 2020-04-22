class Obstacle {
  float x;
  float y;
  float w;
  float h;
  float x0;
  float y0;
  float w0;
  float h0;
  PVector mov;
  boolean sw = true;
  int swc = 0;
  Obstacle (float x, float y, float w, float h, PVector mov) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.x0 = x;
    this.y0 = y;
    this.w0 = w;
    this.h0 = h;
    this.mov = mov;
  }
  void show() {
    fill(0);
    rect(x, y, w, h);
    switch(int(mov.x)) {
    case 0: 
      if (sw) {
        x++;
        swc++;
      } else {
        x--;
        swc--;
      }
      break;
    case 1: 
      if (sw) {
        y++;
        swc++;
      } else {
        y--;
        swc--;
      }
      break;
    default:
      break;
    }
    if (swc > int(mov.y) || swc < 0) {
      sw = !sw;
    }
  }

  void reset() {
    this.x = this.x0;
    this.y = this.y0;
    this.w = this.w0;
    this.h = this.h0;
    this.sw = true;
    this.swc = 0;
  }
}