import 'dart:async';

import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';
import 'package:bridge_counter/src/model/bet.dart';
import 'package:bridge_counter/src/model/game_state.dart';

class GameController {
  List<GameState> _states;
  List<GameState> _undos;
  String team1;
  String team2;

  GameState _currentState;

  GameState get last => _states.last ?? GameState();

  GameController() {
    newGame();
  }

  void newGame() {
    _states = [];
    _undos = [];
    _currentState = GameState();
  }

  void startRound(Bet bet) {
    _currentState.setBet(bet);
  }

  void finishRound(int tricks) {
    _currentState.finishRound(tricks);
    _states.add(_currentState);
    _undos.clear();
    _currentState = GameState.copy(_currentState);
  }

  void undo() {
    _undos.add(_states.removeLast());
  }

  void redo() {
    _states.add(_undos.removeLast());
  }
}
