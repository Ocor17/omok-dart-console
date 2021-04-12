
class Board {
  var size;
  var currentBoard;
  ///This is the board constructor to create a board object
  Board(sizeIn) {
    size = sizeIn;
    currentBoard = createBoard(size);
  }
  ///creates the board with the size specified
  dynamic createBoard(size) {
    var newBoard = List.generate(size, (i) => List.filled(size, 0));

    return newBoard;
  }
  ///places a token on the board in the places specified and checks if its a player or computer
  bool placeToken(x, y, player) {
    if (player == true) {
      if(currentBoard[x][y] == 0){
        currentBoard[x][y] = 1;
        return true;
      }
    }
    else{
      currentBoard[x][y] = 2;
      return true;
    }
    return false;
  }
  ///This gets the board of the current game
  dynamic getCurrentBoard() {
    return currentBoard;
  }
  ///This gets the size of the board 
  dynamic getSize() {
    return size;
  }

}
