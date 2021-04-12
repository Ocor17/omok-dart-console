import 'dart:convert';
import 'dart:io';

class ResponseParser {
  ///This will parse the string given to URL
  Uri parseToURL(input) {
    var url = Uri.parse(input);
    return url;
  }

  ///This will parse the server strategy response from the webclient to a list to be used
  List getServerStrategies(response) {
    var info = json.decode(response.body);
    var values = info.values.toList();
    var strategies = values[1];
    return strategies;
  }

  ///This gets the board size from the response and returns a list
  int getBoardSize(response) {
    var info = json.decode(response.body);
    var values = info.values.toList();
    var size = values[0];
    return size;
  }

  ///This parses strings to integers and checks if the format doesnt fit
  int parseToInteger(line) {
    var selection = 0;
    try {
      selection = int.parse(line);
    } on FormatException {
      stdout.write('Format Exception when parsing to integer');
    }
    return selection;
  }

  ///This parses the response from the getNew in webClient to get the new game PID
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

  ///This parses the response from getPlay in webClient to get the conditions for win and draw and the computer move
  dynamic parsePlay(response) {
    print(response);
    var play = json.decode(response);
    var serverResponse = play['response']; //server response: true or false
    var ackMove = play['ack_move']; //player move: x,y,isWin,isDraw
    var move = play['move']; //comp move: x,y,isWin,isDraw,row

    return {'player': ackMove, 'computer': move};
  }
}
