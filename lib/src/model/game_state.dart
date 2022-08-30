import 'package:bridge_counter/src/helper/point_calculator.dart';
import 'package:bridge_counter/src/model/game_round.dart';

class GameState {
  PointCalculator _calc = PointCalculator();

  String team1;
  String team2;

  Map<String, int> scores = {};
  Map<String, List<List<GameRound>>> points = {};

  GameState? previous;
  GameState? next;

  GameState(this.team1, this.team2, [this.previous]) {
    scores[team1] = 0;
    scores[team2] = 0;

    points[team1] = [[], [], []];
    points[team2] = [[], [], []];
  }

  factory GameState.copy(GameState old) {
    var newState = GameState(old.team1, old.team2, old);
    newState.scores = Map.from(old.scores);
    newState.points = Map.from(old.points);

    return newState;
  }

  String get score => "${scores[team1]} x ${scores[team2]}";
  int get score1 => scores[team1]!;
  int get score2 => scores[team2]!;

  String? winnerTeam;

  bool _gameOver = false;
  bool get isGameOver => _gameOver;

  int get currentRound => scores[team1]! + scores[team2]!;

  void finishRound(GameRound round, int tricks) {
    int targetTricks = round.bet.rounds + 6;
    if (targetTricks > tricks) {
      var result = calculateLosingPoints(round, tricks);
      var team = round.bet.bettingTeam == team1 ? team2 : team1;

      points[team]![currentRound].add(result);
    } else {
      var result = calculateWinningPoints(round, tricks);
      points[round.bet.bettingTeam]![currentRound].add(result);
      checkNewScore();
    }
  }

  GameRound calculateLosingPoints(GameRound round, int tricks) {
    var target = round.bet.rounds + 6;
    var multiplier = round.bet.multiplier;
    var isVulnerable = scores[round.bet.bettingTeam] == 1;

    var underTricks = target - tricks;

    var overPoints =
        _calc.calculateUndertricks(underTricks, multiplier, isVulnerable);

    round.addOverPoint(overPoints);

    return round;
  }

  GameRound calculateWinningPoints(GameRound round, int tricks) {
    var target = round.bet.rounds + 6;
    var naipe = round.bet.naipe;
    var multiplier = round.bet.multiplier;
    var isVulnerable = scores[round.bet.bettingTeam] == 1;

    var overTricks = tricks - target;

    var underPoints = _calc.calculateTricks(target, multiplier, naipe);
    var insult = _calc.calculateInsult(multiplier);

    round.underPoints = underPoints;
    round.addOverPoint(insult);

    if (overTricks > 0) {
      var overTrickPoints = _calc.calculateOverTricks(
        overTricks,
        multiplier,
        naipe,
        isVulnerable,
      );
      round.addOverPoint(overTrickPoints);
    }

    if (target > 11) {
      var slam = _calc.calculateSlam(target, isVulnerable);
      round.addOverPoint(slam);
    }

    return round;
  }

  void checkNewScore() {
    var team1Total = 0;
    var team2Total = 0;

    points[team1]![currentRound].forEach((round) {
      team1Total += round.underPoints;
    });

    points[team2]![currentRound].forEach((round) {
      team2Total += round.underPoints;
    });

    String? loserTeam;
    if (team1Total >= 100) {
      winnerTeam = team1;
      loserTeam = team2;
    } else if (team2Total >= 100) {
      winnerTeam = team2;
      loserTeam = team1;
    } else {
      winnerTeam = null;
      loserTeam = null;
    }

    if (winnerTeam != null) {
      var gameSet = currentRound;
      var newScore = scores[winnerTeam!]! + 1;
      scores[winnerTeam!] = newScore;
      if (newScore == 2) {
        int extraPoints = scores[loserTeam!] == 0 ? 700 : 500;
        points[winnerTeam!]![gameSet].last.addOverPoint(extraPoints);
        _gameOver = true;
      }
    }
  }
}
