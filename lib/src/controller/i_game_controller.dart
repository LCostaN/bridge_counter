import 'package:bridge_counter/src/model/bet.dart';
import 'package:bridge_counter/src/model/game_state.dart';
import 'package:bridge_counter/src/model/game_round.dart';

abstract class IGameController {
  late GameState _state;
  GameRound? newRound;

  IGameController(String team1, String team2) {
    _state = GameState(team1, team2);
  }

  void startRound(Bet bet);
  void finishRound(int tricks);
  void redo();
  void undo();
}
