// Vulkanspiel
// probiere die Steine, die aus dem Vulkan geschleudert werden aufzufangen (anklicken)

float r;
ArrayList<PVector> border;
int fps = 60;
float transx;
float transy;
float da = PI/30;
ArrayList<Form> forms;
final float GRAVITY = 0.3;
int score = 0;

void setup() {
  size(800, 1000);
  frameRate(fps);
  forms = new ArrayList<Form>();
  for (int i = 0; i<5; i++) {
    forms.add(new Form(random(width/3, 2*width/3), height/2, random(50, 100)));
  }
}

void draw() {
  background(#4C63A0);
  drawVulcano();

  if (frameCount%(fps/2)==0) {
    forms.add(new Form(random(width/3, 2*width/3), height/2, random(50, 100)));
  }
  forms.add(new Form(random(width/3, 2*width/3), height/2, random(10, 20)));
  for (int i = forms.size()-1; i>=0; i--) {
    Form f = forms.get(i);
    f.show();
    f.move();
    if (mousePressed) {
      if (f.mouseover()) {
        forms.remove(i);
        score++;
      }
    }
    if (f.pos.y>height) {
      forms.remove(i);
    }
  }
  //println(forms.size());
  textSize(30);
  fill(0);
  text("Score: "+score, 30, 30);
}

void drawVulcano() {
  fill(#95856D);
  beginShape();
  vertex(0, height);
  vertex(width, height);
  vertex(2*width/3+30, height/2-30);
  vertex(width/3-30, height/2-30);
  endShape();
}
