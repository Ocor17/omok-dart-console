import 'Board.dart';
import 'responseParser.dart';
import 'consoleUI.dart';
import 'webClient.dart';
import 'dart:io';

class Controller {
  void controlPanel() async {
    var consoleUI = ConsoleUI();
    var webClient = WebClient();
    var responseParser = ResponseParser();

    ///main url for the omok game to get the directories
    var mainURL = 'http://omok.atwebpages.com';

    ///This gets the URL
    var url = responseParser.parseToURL(consoleUI.askForServerURL());

    ///This will get the server response for strategies
    var serverResponse = await webClient.httpResponse(url);

    ///parse the server response with the server strategies
    var strategies = responseParser.getServerStrategies(serverResponse);

    ///This gets the board size from the server which is needed to make the board
    var sizeOfBoard = responseParser.getBoardSize(serverResponse);

    ///creates the board object for this game
    var board = Board(sizeOfBoard);

    ///gets the chosen strategy from the user or defaults on smart
    var strat = consoleUI.getChosenStrategy(strategies);

    ///creates a new game instance and gets the PID for it
    var newGamePid =
        responseParser.parseNew(await webClient.getNew(mainURL, strat));

    ///while loop to play the game and check who wins or if there is a draw
    while (true) {
      var move = consoleUI.promptMove(board);
      stdout.write('Move made: $move \n');

      ///This gets the play response with the computer move and the isWin/isDraw response
      var playing = responseParser.parsePlay(
          await webClient.getPlay(mainURL, move[1], move[0], newGamePid));

      ///This checks if the player won
      if (playing['player']['isWin'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        stdout.write('\n');
        stdout.write('Player Won!');
        stdout.write('Winning Row: ');
        stdout.write(playing['player']['row']);
        stdout.write('Thanks for Playing');
        break;
      }

      ///This checks if the computer won
      else if (playing['computer']['isWin'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        stdout.write('\n');
        stdout.write('Computer Won!');
        stdout.write('Winning Row: ');
        stdout.write(playing['computer']['row']);
        stdout.write('Thanks for Playing');
        break;
      }

      ///This checks if there is a draw
      else if (playing['player']['isDraw'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        stdout.write('Draw!');
        stdout.write('Thanks for Playing');
        break;
      }

      ///This places a token on the board of this game for the computer so it will display on the board
      board.placeToken(
          playing['computer']['x'], playing['computer']['y'], false);

      ///This draws the board for the user to see it each turn to decide a move
      consoleUI.drawBoard(board.getCurrentBoard());
      stdout.write('\n');
    }
  }
}
