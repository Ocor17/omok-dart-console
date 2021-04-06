import 'dart:io';
import 'package:omok_exercise/webClient.dart';
import 'Board.dart';
import 'ResponseParser.dart';

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
    var x, y;

    while (true) {
      try {
        stdout.write('\nselect x:\n');
        var xIn = stdin.readLineSync();
        x = int.parse(xIn);
        stdout.write('\nselect y:\n');
        var yIn = stdin.readLineSync();
        y = int.parse(yIn);

        if (x < 1 || x > 15 || y < 1 || y > 15) {
          //edit to use size of board!!!!!!!
          throw FormatException('index out of bounds for game!');
        }
        break;
      } on FormatException catch (e) {
        stdout.write('Error! $e');
        continue;
      }
    }

    return {'x': x, 'y': y};
  }

  void MainMenu() async {
    var parse = ResponseParser();
    var web = WebClient();

    //console.drawBoard(board.getCurrentBoard());
    print('\u23FA');

    showMesseage();

    var url = promptServer();

    var gameInfo = parse.parseInfo(await web.getInfo(url));

    var board = Board(gameInfo['size']);

    var strat =
        promptStrategy(gameInfo['strategy']); //var gets set for future use

    var newGamePid = parse.parseNew(await web.getNew(url, strat));

    var i = 0;
    while (i < 5) {
      var move = promptPlayer();

      var playing = parse
          .parsePlay(await web.getPlay(url, move['x'], move['y'], newGamePid));

      //board.isWin(playing['player']['isWin'], playing['player']['row'], true);
      //board.isWin(playing['player']['isWin'], playing['player']['row'], false);

      board.placeToken(playing['player']['x'], playing['player']['y'], true);
      board.placeToken(
          playing['computer']['x'], playing['computer']['y'], false);

      drawBoard(board.getCurrentBoard());
      i++;
    }
  }
}
