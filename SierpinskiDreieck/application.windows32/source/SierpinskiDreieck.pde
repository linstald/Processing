int x=int(random(360));
int y=int(random(360));
void setup() {
point(x,y);
size(600,520);
triangle(300,0,600,520,0,520);
}
void draw() {
int z=int(random(3));

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