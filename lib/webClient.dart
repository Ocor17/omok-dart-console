import 'package:http/http.dart' as http;
import 'dart:io';
import 'responseParser.dart';

class WebClient{
  Future httpResponse(url) async{
    var response = await http.get(url);
    return response;
  }

  Future<String> getNew(url, strategy) async {
    var rp = ResponseParser();
    stdout.write('Creating new game...\n');
    var newURl = rp.parseToURL(url + '/new?strategy=' + strategy);
    var response = await http.get(newURl);
    var newGame = response.body;

    return newGame;
  }

  Future<String> getPlay(url, x, y, pid) async {
    var rp = ResponseParser();
    var newURl = rp.parseToURL(url + '/play?pid=' + pid + '&move=' + x.toString() + ',' + y.toString());
    var response = await http.get(newURl);

    var play = response.body;

    return play;
  }
}