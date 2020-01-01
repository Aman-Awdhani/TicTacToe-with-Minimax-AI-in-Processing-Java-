int minimax(String[][] board1, boolean isMax) {
  
  String resultStr = checkWin();
  int result = 0;
  
  if (resultStr == ai)
    result = 1;
  else if (resultStr == player)
    result = -1;
      
  if (resultStr != null){   
    return result;
  }
  
  //if maximizer
  if (isMax) {

    int bestScore = -100;    
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {

        if (board1[i][j] == "") {

          board1[i][j] = ai;
          int score = minimax(board1, false);
          
          board1[i][j] = "";
          bestScore = max(score,bestScore);     
        }
      }
    }
    return bestScore;
  } 
  //if minimizer
  else {
    int bestScore = 100;    
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {

        if (board1[i][j] == "") {

          board1[i][j] = player;
          int score = minimax(board1, true);
          board1[i][j] = "";
          bestScore = min(bestScore, score);
             
          }
        }
      }
      return bestScore;
    }  
  }
