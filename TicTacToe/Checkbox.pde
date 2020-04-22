class Checkbox {
  float x, y, w, h;
  String text1, text2;
  boolean status = false;
  Checkbox(float x, float y, float w, float h, String text1, String text2) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text1 = text1;
    this.text2 = text2;
  }
  
  boolean mouseOver() {
    return isbetween2(mouseX, mouseY, x, x+w, y, y+h);
  }
  
  void change() {
    status = !status;
  }
  
  boolean getStatus() {
    return status;
  }

  void show() {
    //Rectmode:Corner
    stroke(0);
    if (mouseOver()) {
      fill(180, 180, 180);
    } else {
      fill(230, 230, 230);
    }
    rect(x, y, w, h);
    fill(0);
    if (status) {
      text(text1, x, y+h/2);
    } else {
      text(text2, x, y+h/2);
    }
  }
}
