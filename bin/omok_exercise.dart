import 'dart:io';

import 'package:omok_exercise/Board.dart';
import 'package:omok_exercise/ConsoleUI.dart';
import '../lib/ResponseParser.dart';
import '../lib/webClient.dart';

void main() async {
  var parse = ResponseParser();
  var web = WebClient();
  var console = ConsoleUI();

  //console.drawBoard(board.getCurrentBoard());
  print('\u23FA');

  console.showMesseage();

  var url = console.promptServer();

  var gameInfo = parse.parseInfo(await web.getInfo(url));

  var board = Board(gameInfo['size']);

  var strat = console
      .promptStrategy(gameInfo['strategy']); //var gets set for future use

  var newGamePid = parse.parseNew(await web.getNew(url, strat));

  var i = 0;
  while (i < 5) {
    var move = console.promptPlayer();

    var playing = parse
        .parsePlay(await web.getPlay(url, move['x'], move['y'], newGamePid));

    board.isWin(playing['player']['isWin'], playing['player']['row'], true);
    board.isWin(playing['player']['isWin'], playing['player']['row'], false);

    board.placeToken(playing['player']['x'], playing['player']['y'], true);
    board.placeToken(playing['computer']['x'], playing['computer']['y'], false);

    console.drawBoard(board.getCurrentBoard());
    i++;
  }

  //print(playing);

  //print(newGamePid);
  /**
  var test = [
    [0, 1, 0, 0, 0],
    [0, 2, 0, 2, 0]
  ];

  //print(test);
  var testTwp = parse.parsePlay(
      '{"response":true,"ack_move":{"x":3,"y":0,"isWin":false,"isDraw":false,"row":[]},"move":{"x":0,"y":1,"isWin":false,"isDraw":false,"row":[]}}');
  //console.drawBoard(test);

  print(testTwp['player']['x']);
  **/
}
