int iterations = 1;
float len = 10;
float angle = radians(120);
String input;
VarsLSystem v = new VarsLSystem();
void setup() {
  size(660, 660);
  input = v.make(iterations);
  //println(input);
}

void draw() {
  background(255);
  translate(10, height-10);
  input = v.make(iterations);
  len = pow(0.5, iterations-6)*10;
  
  for (int i = 0; i<input.length(); i++) {
    char curchar = input.charAt(i);
    switch(curchar) {
    case 'F': //move and draw line
      line(0, 0, len, 0);
      translate(len, 0);
      break;
    case 'H': //only move
      translate(len, 0);
      break;
    case 'G': //move and draw line
      line(0, 0, len, 0);
      translate(len, 0);
      break;
    case '+':
      rotate(angle);   
      break;
    case '-':
      rotate(-angle);   
      break;
    case '[':
      pushMatrix();   
      break;
    case ']':
      popMatrix();  
      break;
    }
  }
}
void mousePressed() {
  iterations++;
}
