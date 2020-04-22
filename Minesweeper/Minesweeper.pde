int cols =30;
int rows;
int bombs = 40;
int[][] grid;
/* grid[x][y]
*       
*  >= 0 && <10: not opened field
*  >=10 && <20: marked with a flag (red circle)
*  >=20 && <30: field is open
*  
*  %10=..:      Information about bombs around field
*  ..0:         0 bombs around, normal field (flood open, when opened)
*  ..>=1 && <9: amount of bombs around this field
*  ..==9:       this field is a bomb
*/
boolean finished;
int finishTime;

void setup() {
  fullScreen();
  textAlign(CENTER, CENTER);
  float fieldWidth = width/cols;
  rows = int(height/fieldWidth);
  finished = false;
  grid = new int[cols][rows];
  distributeBombs(bombs);
  countBombs();
  drawGrid();
}

void draw() {
  if (finished) {
    openGrid();
    if(mousePressed && (frameCount-finishTime)>5) {
      finished = false;
      setup();
    }
  }
  if (!finished && correct()) {
    finished= true;
    finishTime = frameCount;
  }
}

void mousePressed() {
  if (!finished) {
    float fieldWidth = width/cols;
    int x = int(mouseX/fieldWidth);
    int y = int(mouseY/fieldWidth);
    if (mouseButton==LEFT) {
      openField(x, y);
    } else {
      if (grid[x][y]>=10 && grid[x][y]<20) {
        grid[x][y]= grid[x][y]-10;
        fill(140);
        rect(x*fieldWidth, y*fieldWidth, fieldWidth, fieldWidth);
      } else if (grid[x][y]<10) {
        grid[x][y]= grid[x][y]%10+10;
        fill(255, 0, 0);
        circle(x*fieldWidth+fieldWidth/2, y*fieldWidth+fieldWidth/2, fieldWidth/3);
      }
    }
  }
}

boolean correct() {
  boolean result = true;
  for (int x = 0; x<cols; x++) {
    for (int y = 0; y<rows; y++) {
      result = result && grid[x][y]>=19;
      if (!result) {
        return false;
      }
    }
  }
  return result;
}

void openField(int x, int y) {
  drawField(x, y);
  grid[x][y] = (grid[x][y]%10)+20;
  if (grid[x][y]%10==9) {
    finished = true;
    finishTime = frameCount;
  } else if (grid[x][y]%10==0) {
    for (int i= -1; i<2; i++) {
      for (int j= -1; j<2; j++) {
        if (!(i==0&&j==0)) {
          int xindex = x+i;
          int yindex = y+j;
          if (!(xindex<0 || xindex>=cols || yindex<0 || yindex>=rows)) {
            if (grid[xindex][yindex]<20) {
              openField(xindex, yindex);
            }
          }
        }
      }
    }
  }
}

void openGrid() {
  for (int x = 0; x<cols; x++) {
    for (int y = 0; y<rows; y++) {
      drawField(x, y);
    }
  }
}

void drawField(int x, int y) {
  float fieldWidth = width/cols;
  fill(200);
  rect(x*fieldWidth, y*fieldWidth, fieldWidth, fieldWidth);
  if (grid[x][y]%10==9) {
    fill(0);
    circle(x*fieldWidth+fieldWidth/2, y*fieldWidth+fieldWidth/2, fieldWidth/3);
    return;
  } else if (grid[x][y]%10==1) {
    fill(0, 150, 40);
  } else if (grid[x][y]%10==2) {
    fill(0, 200, 130);
  } else if (grid[x][y]%10==3) {
    fill(0, 50, 150);
  } else if (grid[x][y]%10==4) {
    fill(0, 40, 150);
  } else if (grid[x][y]%10==5) {
    fill(110, 40, 150);
  } else if (grid[x][y]%10==6) {
    fill(150, 40, 130);
  } else if (grid[x][y]%10==7) {
    fill(150, 60, 150);
  } else if (grid[x][y]%10==8) {
    fill(150, 0, 0);
  } else if (grid[x][y]%10==0) {
    return;
  }
  textSize(fieldWidth/3);
  text(grid[x][y]%10, x*fieldWidth+fieldWidth/2, y*fieldWidth+fieldWidth/2);
}


void drawGrid() {
  float fieldWidth = width/cols;
  for (int x = 0; x<cols; x++) {
    for (int y = 0; y<rows; y++) {
      fill(140);
      stroke(0);
      strokeWeight(2);
      rect(x*fieldWidth, y*fieldWidth, fieldWidth, fieldWidth);
    }
  }
}

void distributeBombs(int amount) {
  if (amount==0) {
    return;
  }
  int x = int(random(1)*cols);
  int y = int(random(1)*rows);
  if (grid[x][y] == 0) {
    grid[x][y] = 9;
    float fieldWidth = width/cols;
    fill(255, 255, 0);
    circle(x*fieldWidth+fieldWidth/2, y*fieldWidth+fieldWidth/2, fieldWidth/3);
    distributeBombs(amount-1);
  } else {
    distributeBombs(amount);
  }
}

void countBombs() {
  for (int x = 0; x<cols; x++) {
    for (int y = 0; y<rows; y++) {
      if (grid[x][y]!=9) {
        grid[x][y] = countField(x, y);
      }
    }
  }
}

int countField(int x, int y) {
  int result = 0;
  for (int i= -1; i<2; i++) {
    for (int j= -1; j<2; j++) {
      if (!(i==0&&j==0)) {
        int xindex = x+i;
        int yindex = y+j;
        if (xindex<0 || xindex>=cols || yindex<0 || yindex>=rows) {
          result+=0;
        } else if (grid[xindex][yindex]%10==9) {
          result++;
        }
      }
    }
  }
  return result;
}
