import 'dart:convert';

class ResponseParser {
  dynamic parseInfo(response) {
    //needs to be used with http get request
    var info = json.decode(response);
    var strat = info['strategies'];
    var size = info['size'];
    var list = {};
    for (var i = 0; i < strat.length; i++) {
      list[i + 1] = strat[i];
    }
    var gameInfo = {'size': size, 'strategy': list};
    return gameInfo;
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
    var test = ackMove['x'];

    print(' $serverResponse\n $ackMove\n $move\n $test');

    return {'player': ackMove, 'computer': move};
  }
}
