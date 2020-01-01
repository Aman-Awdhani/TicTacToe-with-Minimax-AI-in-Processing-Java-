
int size;
String player = "X";
String ai = "O";
boolean x = true;
boolean o = false;

String[][] board = {{"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}};



void setup() {
  size(600, 600);
  size = width/3; 
  printGame();
}

void draw() {
  if (!o)return;
  if (!movesLeft())return; 
  bestMove();
  printWinner();
}

void mousePressed() {

  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {

      float dis = dist(j*size+size/2, i*size+size/2, mouseX, mouseY);
      if (dis<100) {  

        if (board[i][j]!="")return;

        if (x) {
          board[i][j] = player;
          x=false;
          o=true;
        } 
        printGame();
      }
    }
  }
  printWinner();
}

//check best move for ai
void bestMove() {
  int bestScore = -1000;
  int xPos=-1, yPos =-1;
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {

      if (board[i][j] == "") {

        board[i][j] = ai;
        
        //calls minimax
        int score = minimax(board, false);
        board[i][j] = "";
        if (score>bestScore) {
          bestScore = score;
          xPos=i;
          yPos=j;
        }
      }
    }
  }
  board[xPos][yPos] = ai; 
  x=true;
  o=false;
  printGame();
}

//check win
String checkWin() {

  String winner = null;

  for (int i=0; i<3; i++) {  
    if (board[i][0] == "") continue;
    if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] == board[i][2]) {

      winner = board[i][0];
    }
  }

  for (int i=0; i<3; i++) {
    if (board[0][i] == "") continue;
    if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] == board[2][i]) {

      winner = board[0][i];
    }
  }


  if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] == board[2][2] && board[0][0] !="") {
    winner = board[0][0];
  }

  if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] == board[2][0] && board[2][0] !="") {
    winner = board[0][2];
  }

  if (winner == null && !movesLeft()) {   
    return "Tie";
  } else {
    return winner;
  }
}

//check move left
boolean movesLeft() {
  //check draw
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      if (board[i][j] == "")
        return true;
    }
  }
  return false;
}

//debug winner
void printWinner() {
  String winner = checkWin();
  if (winner!=null) {
    print(winner , "Wins");
    x=false;
    o=false;
  }
}

void grid() {

  stroke(255);
  strokeWeight(5);

  for (int i=0; i<=width; i+=size) {
    for (int j=0; j<=width; j+=size) {

      line(i, j, i, j+height);
      line(i, j, i+width, j);
    }
  }
}

void printGame() {

  background(0);
  grid();
  textSize(100);
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {

      text(board[i][j], j*size+size/3, i*size+size/1.5);
    }
  }
}
