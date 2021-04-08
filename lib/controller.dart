import 'Board.dart';
import 'responseParser.dart';
import 'consoleUI.dart';
import 'webClient.dart';

class Controller{
  void controlPanel() async{
    var consoleUI = ConsoleUI();
    var webClient = WebClient();
    var responseParser = ResponseParser();
    var mainURL = 'http://omok.atwebpages.com';

    var url = responseParser.parseToURL(consoleUI.askForServerURL());
    var serverResponse = await webClient.httpResponse(url);
    var strategies = responseParser.getServerStrategies(serverResponse);
    var sizeOfBoard = responseParser.getBoardSize(serverResponse);
    var board = Board(sizeOfBoard);
    var strat = consoleUI.getChosenStrategy(strategies);
    var newGamePid = responseParser.parseNew(await webClient.getNew(mainURL, strat));

    while(true) {
      var move = consoleUI.promptMove(board);
      print('Move made: $move');
      var playing = responseParser.parsePlay(
          await webClient.getPlay(mainURL, move[0], move[1], newGamePid));
      if (playing['player']['isWin'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        print('\n');
        print('Player Won!');
        print('Winning Row: ');
        print(playing['player']['row']);
        print('Thanks for Playing');
        break;
      }
      else if (playing['computer']['isWin'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        print('\n');
        print('Computer Won!');
        print('Winning Row: ');
        print(playing['computer']['row']);
        print('Thanks for Playing');
        break;
      }
      else if (playing['player']['isDraw'] == true) {
        consoleUI.drawBoard(board.getCurrentBoard());
        print('Draw!');
        print('Thanks for Playing');
        break;
      }
      board.placeToken(
          playing['computer']['x'], playing['computer']['y'], false);
      consoleUI.drawBoard(board.getCurrentBoard());
      print('\n');
    }
  }
}