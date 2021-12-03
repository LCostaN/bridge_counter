import 'package:bridge_counter/src/model/bet.dart';
import 'package:bridge_counter/src/model/result.dart';

class GameState {
  Bet _bet;
  Bet get bet => _bet;

  int _score1;
  int get score1 => _score1;
  int _score2;
  int get score2 => _score2;

  Result result;

  String get score => "$_score1 x $_score2";

  bool get isGameOver => _score1 == 2 || _score2 == 2;

  void setBet(Bet bet) {
    _bet = bet;
  }

  void finishRound(int total) {}

  GameState();

  GameState.copy(GameState previous) {
    _score1 = previous.score1;
    _score2 = previous.score2;
  }
}
