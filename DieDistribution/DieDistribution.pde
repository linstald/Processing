void setup() {
  size(800, 800);
  background(255);
}
int prevn = 10;
int prevk = 1;
void draw() {
  
  int currn = (int)map(mouseX, 0, width, 100, 1000000);
  int currk = (int)map(mouseY, height, 0, 1, 100);
  if(currn!=prevn || currk!=prevk) drawDistribution(currn, currk);
  prevn = currn;
  prevk = currk;
  fill(0);
  textSize(16);
  text("n= "+currn, 40, 20);
  text("k= "+currk, 40, 40);
}


void drawDistribution(int n, int k) {
  background(255);
  int res[] = new int[k*6+1];
  for(int i = 0; i<n; i++) {
    int r = 0;
    for(int l = 0; l<k; l++) {
      r+=die();
    }
    res[r]++;
  }  
  float space = width/res.length;
  for(int i = k; i<res.length; i++) {
    float p = res[i]/(float)n;
    float x = map(i, k, res.length, 0 , width);
    float y = map(p, 0, 1, height, -k*height/5);
    fill(0);
    textSize(min(16, max(1, height/(20*k))));
    textAlign(CENTER);
    text(i, x+space/2, width);
    rect(x, height-20, space,y-height);
    text(p, x+space/2, y-25);
  }
  
}


int die() {
  return floor(random(6))+1;
}
