import 'dart:convert';

import 'dart:io';

class ResponseParser {
  Uri parseToURL(input) {
    var url = Uri.parse(input);
    return url;
  }

  List getServerStrategies(response) {
    var info = json.decode(response.body);
    var values = info.values.toList();
    var strategies = values[1];
    return strategies;
  }

  int getBoardSize(response) {
    var info = json.decode(response.body);
    var values = info.values.toList();
    var size = values[0];
    return size;
  }

  int parseToInteger(line) {
    var selection = 0;
    try {
      selection = int.parse(line);
    } on FormatException {
      stdout.write('Format Exception when parsing to integer');
    }
    return selection;
  }

  dynamic parseNew(response) {
    var newGame = json.decode(response);
    var status = newGame['response'];
    var serverResponse;

    if (status) {
      serverResponse = newGame['pid'];
    } else {
      serverResponse = newGame['reason'];
    }

    return serverResponse;
  }

  dynamic parsePlay(response) {
    var play = json.decode(response);
    var serverResponse = play['response']; //server response: true or false
    var ackMove = play['ack_move']; //player move: x,y,isWin,isDraw
    var move = play['move']; //comp move: x,y,isWin,isDraw,row

    return {'player': ackMove, 'computer': move};
  }
}
