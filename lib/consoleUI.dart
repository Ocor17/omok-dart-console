import 'dart:io';
import 'responseParser.dart';
import 'Board.dart';

class ConsoleUI{
  ///This gets the server URL
  String askForServerURL(){
    ///This is the default URL to use if user doesn't enter one
    var defaultUrl = 'http://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
    stdout.write('Enter the server URL [default: $defaultUrl] ');
    var url = getInput();
    if (url == '') {
      ///check for empty string
      url = defaultUrl;
    }
    return url;
  }
  ///This gets user input
  String getInput(){
    var input = stdin.readLineSync();
    return input;
  }
  ///This gets the server strategy choice from the user
  String askForStrategy(){
    var defaultStrat = '1';
    stdout.write('Select the server strategy, 1. Smart 2. Random [default: 1]');
    var line = getInput();
    if (line != '1' || line != '2') {
      //check for empty string
      line = defaultStrat;
    }
    return line;
  }
  ///This gets the users choice on where to place a stone
  String askForMove(){
    stdout.write('Enter x and y (8 10, e.g., 6 5)');
    var line = getInput();
    return line;
  }
  ///This is the overall loop to check for invalid inputs when getting player move
  dynamic promptMove(Board b){
    var rp = ResponseParser();
    var size = b.size;

    var input = askForMove();
    var moves = input.split(' ');
    var x = rp.parseToInteger(moves[1]);
    var y = rp.parseToInteger(moves[0]);

    while(true){
      ///checks for choices outside the size of the board
      if(x > size || y > size){
        stdout.write('Invalid Indices');
        input = askForMove();
        moves = input.split(' ');
        try {
          x = rp.parseToInteger(moves[1]);
          y = rp.parseToInteger(moves[0]);
        }on FormatException{
          stdout.write('Format Exception');
          continue;
        }
        on RangeError{
          continue;
        }
        continue;
      }
      ///This tries to place the token and if it returns false it means the space is taken
      else if(b.placeToken(x, y, true)){
        break;
      }
      ///This is if the placement returns false then the space is not empty
      else if(!b.placeToken(x, y, true)){
        stdout.write('Not empty!');
        input = askForMove();
        moves = input.split(' ');
        try {
          x = rp.parseToInteger(moves[1]);
          y = rp.parseToInteger(moves[0]);
        }on FormatException{
          stdout.write('Format Exception');
          continue;
        }
        on RangeError{
          continue;
        }
        continue;
      }
      else{
        stdout.write('Entered wrong data');
        input = askForMove();
        moves = input.split(' ');
        try {
          x = rp.parseToInteger(moves[1]);
          y = rp.parseToInteger(moves[0]);
        }on FormatException{
          stdout.write('Format Exception');
          continue;
        }
        on RangeError{
          continue;
        }
        continue;
      }
    }
    return [x,y];
  }

  ///This gets the strategy calls to get the user input and makes sure the input is valid
  String getChosenStrategy(List strategies){
    var rp = ResponseParser();
    var smart = strategies[0];
    var random = strategies[1];
    var line = askForStrategy();

    try {
      var selection = rp.parseToInteger(line);
      if (selection == 1){
        stdout.write('Selected strategy: $smart');
        return smart;
      }
      else if(selection == 2){
        stdout.write('Selected strategy: $random');
        return random;
      }
      else{
        stdout.write('Invalid Selection: $selection');
      }
      ///This will loop until a valid input is given
      while (selection != 1 && selection != 2){
        line = askForStrategy();
        selection = rp.parseToInteger(line);
        if (selection == 1){
          stdout.write('Selected strategy: $smart');
          return smart;
        }
        else if(selection == 2){
          stdout.write('Selected strategy: $random');
          return random;
        }
        else{
          stdout.write('Invalid Selection: $selection');
        }
      }
    } on FormatException { stdout.write('invalid format'); }
    return random;
  }

  ///draws the board to display after each turn to the user
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
}