import 'package:bridge_counter/src/model/bet.dart';
import 'package:bridge_counter/src/model/game_round.dart';

abstract class IGameController {
  GameRound? newRound;

  IGameController(String team1, String team2) {
  }

  void startRound(Bet bet);
  void finishRound(int tricks);
}
