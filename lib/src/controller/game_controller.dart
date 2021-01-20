import 'dart:async';

import 'package:bridge_counter/src/model/game_state.dart';

class GameController {
  final _blocController = StreamController();

  Stream get stream => _blocController.stream;

  List<GameState> _states;
  String team1;
  String team2;

  GameController() {
    newGame();
  }

  void newGame() {
    _states = [];
  }

  void dispose() {
    _blocController.close();
  }
}
