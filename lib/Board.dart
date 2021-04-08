
class Board {
  var size;
  var currentBoard;

  Board(sizeIn) {
    size = sizeIn;
    currentBoard = createBoard(size);
  }

  dynamic createBoard(size) {
    var newBoard = List.generate(size, (i) => List.filled(size, 0));

    return newBoard;
  }

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

  dynamic getCurrentBoard() {
    return currentBoard;
  }

  dynamic getSize() {
    return size;
  }

}
