import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SierpinskiDreieck extends PApplet {

int x=PApplet.parseInt(random(360));
int y=PApplet.parseInt(random(360));
public void setup() {
point(x,y);

triangle(300,0,600,520,0,520);
}
public void draw() {
int z=PApplet.parseInt(random(3));

if (z==0) {
  x=(x+300)/2;
  y=y/2;
  point(x,y);
}
if (z==1) {
  x=x/2;
  y=(y+520)/2;
  point(x,y);
}
if (z==2) {
  x=(x+600)/2;
  y=(y+520)/2;
  point(x,y);
}
}
  public void settings() { 
size(600,520); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SierpinskiDreieck" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
