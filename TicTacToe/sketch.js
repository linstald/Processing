const VOID = 0;
const X = 1;
const O = 2;
const TIE = 3;
var board;
var turn;
var finished;
var buffer;
var w;

function setup() {
  createCanvas(600, 700);
  textSize(30);
  w = width / 3;
  buffer = w / 4;
  finished = false;
  turn = X;
  //draw board
  fill(255);
  for (let i = 0; i < 3; i++) {
    for (let j = 0; j < 3; j++) {
      strokeWeight(1);
      rect(i * w, j * w, w, w);
    }
  }
  board = [
    [VOID, VOID, VOID],
    [VOID, VOID, VOID],
    [VOID, VOID, VOID]
  ];

  fill(255);
  strokeWeight(1);
  rect(0, 3 * w, 3 * w, w / 2);
}

function draw() {
  fill(255);
  strokeWeight(1);
  rect(0, 600, 600, w / 2);

  if (!finished) {
    if (turn == X) {
      fill(0);
      text("X ist dran", w, 3 * w + buffer);
    } else {
      fill(0);
      text("O ist dran", w, 3 * w + buffer);
    }
  }

  var winner = checkWinner();
  if (winner != VOID) {
    finished = true;
    if (winner == X) {
      fill(0);
      text("X hat gewonnen", w, 650);
      //println(X);
    } else if (winner == O) {
      fill(0);
      text("O hat gewonnen", w, 650);
      //println(O);
    } else {
      fill(0);
      text("Unentschieden", w, 650);
      //println(TIE);
    }
  }
}

function mouseReleased() {
  if (!finished) {
    var x = mouseX;
    var y = mouseY;
    noFill();
    //check board and draw corresponding shape on right field
    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        if (isbetween2(x, y, i * w, (i + 1) * w, j * w, (j + 1) * w) && board[i][j] == VOID) {
          if (turn == O) {
            strokeWeight(4);
            ellipse(i * w + w / 2, j * w + w / 2, w / 2, w / 2);
            turn = X;
            board[i][j] = O;
          } else {
            strokeWeight(4);
            cross(i * w + w / 2, j * w + w / 2, w - buffer);
            turn = O;
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

function checkWinner() {
  //horizontal
  for (let j = 0; j < 3; j++) {
    if (areequal(board[0][j], board[1][j], board[2][j]) && board[0][j] != VOID) {
      strokeWeight(16);
      line(buffer, j * w + w / 2, 3 * w - buffer, j * w + w / 2);
      return board[0][j];
    }
  }
  //vertical
  for (let i = 0; i < 3; i++) {
    if (areequal(board[i][0], board[i][1], board[i][2]) && board[i][0] != VOID) {
      strokeWeight(16);
      line(i * w + w / 2, buffer, i * w + w / 2, 3 * w - buffer);
      return board[i][0];
    }
  }
  //diagonals
  if (areequal(board[0][0], board[1][1], board[2][2]) && board[0][0] != VOID) {
    strokeWeight(16);
    line(buffer, buffer, 3 * w - buffer, 3 * w - buffer);
    return board[0][0];
  }
  if (areequal(board[2][0], board[1][1], board[0][2]) && board[2][0] != VOID) {
    strokeWeight(16);
    line(3 * w - buffer, buffer, buffer, 3 * w - buffer);
    return board[2][0];
  }

  //go through every field and return no winner (VOID) if at least one field is still empty
  for (let i = 0; i < 3; i++) {
    for (let j = 0; j < 3; j++) {
      if (board[i][j] == VOID) {
        return VOID;
      }
    }
  }
  //else... (noone has three in a row, every field is obtained)
  return TIE;
}

function areequal(a,  b,  c) {
  return a == b && b == c;
}
//function drawing the cross
function cross( x,  y,  w) {
  line(x - w / 2, y - w / 2, x + w / 2, y + w / 2);
  line(x + w / 2, y - w / 2, x - w / 2, y + w / 2);
}

function isbetween( x,  a,  b) {
  return x >= a && x <= b;
}

function isbetween2( x,  y,  a,  b,  c,  d) {
  return isbetween(x, a, b) && isbetween(y, c, d);
}