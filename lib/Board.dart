import 'dart:io';

class Board {
  var size;
  var currentBoard;

  Board(sizeIn) {
    this.size = sizeIn;
    this.currentBoard = createBoard(size);
  }

  dynamic createBoard(size) {
    var newBoard = List.generate(size, (i) => List.filled(size, 0));

    return newBoard;
  }

  dynamic placeToken(x, y, player) {
    if (player == true) {
      currentBoard[x][y] = 1;
    } else {
      currentBoard[x][y] = 2;
    }
  }

  dynamic getCurrentBoard() {
    return this.currentBoard;
  }

  dynamic getSize() {
    return this.size;
  }

  dynamic isWin(win, row, isPlayer) {
    if (win) {
      if (isPlayer) {
        for (var i = 0; i < row.length / 2; i++) {}
      }
    }
  }

  void isDraw(draw) {
    if (draw) {
      stdout.write('Draw!');
      exit(0);
    }
  }
}