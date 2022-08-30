import 'package:bridge_counter/src/controller/i_game_controller.dart';
import 'package:bridge_counter/src/model/bet.dart';
import 'package:bridge_counter/src/model/game_state.dart';
import 'package:bridge_counter/src/model/game_round.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController implements IGameController {
  String team1;
  String team2;

  late GameState _state;

  GameRound? newRound;

  GameController(this.team1, this.team2) {
    _state = GameState(team1, team2);
  }

  String get score => _state.score;
  bool get gameEnded => _state.isGameOver;

  int get getScore1 => _state.score1;
  int get getScore2 => _state.score2;

  String? get winnerTeam => _state.winnerTeam;

  List<int> get team1Overpoints => getTeamOverpoints(team1);
  List<List<int>> get team1Underpoints => getTeamUnderpoints(team1);

  List<int> get team2Overpoints => getTeamOverpoints(team2);
  List<List<int>> get team2Underpoints => getTeamUnderpoints(team2);

  void startRound(Bet bet) {
    newRound = GameRound(bet);
  }

  void finishRound(int tricks) {
    _state.finishRound(newRound!, tricks);
    newRound = null;    
  }

  List<int> getTeamOverpoints(String team) {
    List<int> result = [];
    _state.points[team]!.forEach((gameSet) {
      gameSet.forEach((round) {
        result.addAll(round.overPoints);
      });
    });

    return result;
  }

  List<List<int>> getTeamUnderpoints(String team) {
    List<List<int>> result = [[], [], []];
    int i = 0;
    while (i < 3) {
      _state.points[team]![i].forEach((round) {
        if (round.underPoints > 0) result[i].add(round.underPoints);
      });
      i++;
    }

    return result;
  }

  @override
  void redo() {
    _state.redo();
  }

  @override
  void undo() {
    _state.undo();
  }

  int totalUpperPoints(String team) {
    int total = getTeamOverpoints(team).fold(0, (value, element) => value + element);
    return total;
  }

  int totalUnderPoints(String team, int i) {
    int total = getTeamUnderpoints(team)[i].fold(0, (value, element) => value + element);
    return total;
  }

  int grandTotal(String team) {
    var total = 0;
    total = totalUpperPoints(team) +
        totalUnderPoints(team, 0) +
        totalUnderPoints(team, 1) +
        totalUnderPoints(team, 2);
    return total;
  }
}
