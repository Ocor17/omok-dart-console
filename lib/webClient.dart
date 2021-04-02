import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

class WebClient {
  Future<String> getInfo(url) async {
    stdout.write('Obtaining server information ....\n');

    var response = await http.get('$url/info');
    var info = (response.body);
    //print(info);

    return info;
  }

  Future<String> getNew(url, strategy) async {
    stdout.write('Creating new game...\n');
    var response = await http.get('$url/new?strategy=$strategy');
    var newGame = response.body;

    return newGame;
  }

  Future<String> getPlay(url, x, y, pid) async {
    var response = await http.get('$url/play?pid=$pid&move=$x,$y');

    var play = response.body;

    return play;
  }
}
