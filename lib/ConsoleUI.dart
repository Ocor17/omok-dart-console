import 'dart:io';

class ConsoleUI {
  void showMesseage() {
    stdout.write('Welcome to Omok Game\n');
  }

  String promptServer() {
    var URL = 'http://omok.atwebpages.com';
    stdout.write('Enter server URL [default: $URL ]\n');
    var selectURL = stdin.readLineSync();

    if (selectURL == '') {
      //check for empty string
      selectURL = URL;
    }
    return selectURL;
  }

  String promptStrategy(list) {
    var selectedStrat;
    var selection;

    while (true) {
      stdout.write('Select server strategy $list \n');
      var line = stdin.readLineSync();
      try {
        selection = int.parse(line);
        if (selection == 1 || selection == 2) {
          selectedStrat = list[selection];
          break;
        } else {
          stdout.write('INVALID SELECTION $selection \n');
        }
      } on FormatException {
        stdout.write('SELECTION NOT A NUMBER\n');
      }
    }

    stdout.write('selected strategy $selectedStrat \n');
    return selectedStrat;
  }

  dynamic drawBoard(currentBoard) {
    for (var i = 0; i < currentBoard.length; i++) {
      stdout.write('$i\t');
      for (var j = 0; j < currentBoard[i].length; j++) {
        if (currentBoard[i][j] == 0) {
          stdout.write('-\t');
        } else if (currentBoard[i][j] == 1) {
          stdout.write('X\t');
        } else if (currentBoard[i][j] == 2) {
          stdout.write('O\t');
        }
      }
      stdout.write('\n');
    }
    stdout.write('  ');
    for (var last = 0; last < currentBoard[0].length; last++) {
      stdout.write('\t$last');
    }
  }

  dynamic promptPlayer() {
    stdout.write('\nselect x\n');
    var x = stdin.readLineSync();

    stdout.write('\nselect y\n');
    var y = stdin.readLineSync();

    return {'x': x, 'y': y};
  }
}
