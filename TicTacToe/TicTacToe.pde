final int VOID = 0;
final int X = 1;
final int O = 2;
final int TIE = 3;

int [][] board;

int turn;
boolean finished;
float buffer;
float w;
Checkbox b;

String[] xturn = {"X ist dran", "X's turn"};
String[] oturn = {"O ist dran", "O's turn"};
String[] xwin = {"X hat gewonnen", "X wins"};
String[] owin = {"O hat gewonnen", "O wins"};
String[] tie = {"Unentschieden", "It's a tie"};

void setup() {
  size(600, 700);
  textSize(30);
  w = width/3;
  buffer = w/4;
  finished=false;
  turn=X;
  board = new int[3][3];
  //draw board
  fill(255);
  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      strokeWeight(1);
      rect(i*w, j*w, w, w);
      board[i][j] = VOID;
    }
  }
  b = new Checkbox(3*w-3*buffer/2,height-3*buffer/2, buffer, buffer, "DE", "EN");
  fill(255);
  strokeWeight(1);
  rect(0, 3*w, 3*w, w/2);
}

void draw() {
  fill(255);
  strokeWeight(1);
  rect(0, 600, 600, w/2);
  int langind = b.getStatus()?0:1;
  if (!finished) {
    if (turn==X) {
      textAlign(CENTER, CENTER);
      fill(0);
      text(xturn[langind], width/2, height-buffer);
    } else {
      fill(0);
      text(oturn[langind], width/2, height-buffer);
    }
  }
  b.show();
  int winner = checkWinner();
  if (winner != VOID) {
    finished = true;
    if (winner == X) {
      fill(0);
      text(xwin[langind], width/2, height-buffer);
      //println(X);
    } else if (winner == O) {
      fill(0);
      text(owin[langind], width/2, height-buffer);
      //println(O);
    } else {
      fill(0);
      text(tie[langind], width/2, height-buffer);
      //println(TIE);
    }
  }
}


void mouseReleased() {
  if (!finished) {
    int x = mouseX;
    int y = mouseY;
    if (b.mouseOver()) {
      b.change();
    }
    noFill();
    //check board and draw corresponding shape on right field
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        if (isbetween2(x, y, i*w, (i+1)*w, j*w, (j+1)*w) && board[i][j]==VOID) {
          if (turn == O) {
            strokeWeight(4);
            ellipse(i*w+w/2, j*w+w/2, w/2, w/2);
            turn=X;
            board[i][j] = O;
          } else {
            strokeWeight(4);
            cross(i*w+w/2, j*w+w/2, w-buffer);
            turn=O;
            board[i][j] = X;
          }
        }
      }
    }
  } else {
    finished = false;
    setup();
  }
}

int checkWinner() {
  //horizontal
  for (int j = 0; j<3; j++) {
    if (areequal(board[0][j], board[1][j], board[2][j])&&board[0][j] != VOID) {
        strokeWeight(16);
        line(buffer, j*w+w/2, 3*w-buffer, j*w+w/2);
        return board[0][j];
    }
  }
  //vertical
  for (int i = 0; i<3; i++) {
    if (areequal(board[i][0], board[i][1], board[i][2])&&board[i][0] != VOID) {
        strokeWeight(16);
        line(i*w+w/2, buffer, i*w+w/2, 3*w-buffer);
        return board[i][0];
    }
  }
  //diagonals
  if (areequal(board[0][0], board[1][1], board[2][2])&&board[0][0] != VOID) {
      strokeWeight(16);
      line(buffer, buffer, 3*w-buffer, 3*w-buffer);
      return board[0][0];
  }
  if (areequal(board[2][0], board[1][1], board[0][2])&&board[2][0] != VOID) {
    strokeWeight(16);
    line(3*w-buffer, buffer, buffer, 3*w-buffer);
    return board[2][0];
  }

  //go through every field and return no winner (VOID) if at least one field is still empty
  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      if (board[i][j] == VOID) {
        return VOID;
      }
    }
  }
  //else... (noone has three in a row, every field is obtained)
  return TIE;
}

boolean areequal(float a, float b, float c) {
  return a==b && b==c;
}
//function drawing the cross
void cross(float x, float y, float w) {
  line(x-w/2, y-w/2, x+w/2, y+w/2);
  line(x+w/2, y-w/2, x-w/2, y+w/2);
}

boolean isbetween(float x, float a, float b) {
  return x>=a && x<=b;
}
boolean isbetween2(float x, float y, float a, float b, float c, float d) {
  return isbetween(x, a, b) && isbetween(y, c, d);
}
