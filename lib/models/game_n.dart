import 'dart:math';

import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/models/bet_n.dart';
import 'package:bridge_counter/models/round_result.dart';
import 'package:bridge_counter/models/score_n.dart';

class Game {
  List<Bet> bets = [];
  List<String> teams = ["", ""];
  List<Score> scores = [];
  List<List<RoundResult>> results = [[], []];

  List<Bet> undoneBets = [];
  List<Score> undoneScores = [];
  List<List<RoundResult>> undoneResults = [[], []];

  Game(String team1, String team2) {
    teams[0] = team1;
    teams[1] = team2;
  }

  void undo() {
    undoneBets.add(bets.removeLast());
    undoneScores.add(scores.removeLast());
    undoneResults[0].add(results[0].removeLast());
    undoneResults[1].add(results[1].removeLast());
  }

  void redo() {
    bets.add(undoneBets.removeLast());
    scores.add(undoneScores.removeLast());
    results[0].add(undoneResults[0].removeLast());
    results[1].add(undoneResults[1].removeLast());
  }

  String get scoreBoard {
    var win = scores.length > 0 ? scores.last.winRound : null;
    if (win == null)
      return '0 - 0';
    else {
      var team1 = win[0] ? '1' : '0';
      var team2 = win[1] ? '1' : '0';

      return '$team1 - $team2';
    }
  }

  String get totalScore {
    var score = scores.length > 0 ? scores.last : null;

    return score != null ? "${score.totalTeam1}  x  ${score.totalTeam2}" : "0 X 0";
  }

  Bet get currentBet => bets.length > 0 && bets.last.result == null ? bets.last : null;

  void makeBet(Bet bet) {
    undoneBets.clear();
    undoneScores.clear();
    undoneResults[0].clear();
    undoneResults[1].clear();
    
    bets.add(bet);
  }

  bool calculateRound(int roundsWon) {
    var gameOver = false;
    var bet = currentBet; // get CurrentBet to a variable to access info.
    currentBet.result =
        roundsWon; // add Result to currentBet. CurrentBet returns null after this.
    var score = Score(bets.last); // Start Score by saving the bet.
    if (scores.length > 0) score.populatePoints(scores.last);

    RoundResult winResult;
    RoundResult loseResult;

    if (roundsWon < bet.rounds) {
      var points = calculateUndertricks(
        bet.rounds - roundsWon,
        bet.multiply,
        bet.vulnerable,
      );

      score.pointsAbove[bet.winningTeam] += points;
      winResult = RoundResult(0, points);
      loseResult = RoundResult(0, 0);
    } else {
      var underPoints = calculateUnderpoints(
        bet.rounds - 6,
        bet.naipe,
        bet.multiply,
      );

      var slam = max(bet.rounds - 11, 0);
      var abovePoints = calculateOvertricks(
        roundsWon - bet.rounds,
        bet.naipe,
        bet.multiply,
        bet.vulnerable,
        slam,
      );

      // Fim de Round. Pontos >= 100; (Embaixo a linha)
      if (score.pointsUnder[bet.winningTeam] + underPoints >= 100) {
        if (!score.winRound[bet.winningTeam]) {
          // Primeira vitória do time
          score.winRound[bet.winningTeam] = true;
        } else {
          // Segunda vitória do Time
          abovePoints += score.winRound[bet.losingTeam] ? 500 : 700;
          gameOver = true;
        }

        score.pointsAbove[bet.winningTeam] +=
            score.pointsUnder[bet.winningTeam] + underPoints + abovePoints;
        score.pointsUnder[bet.winningTeam] = 0;

        score.pointsAbove[bet.losingTeam] += score.pointsUnder[bet.losingTeam];
        score.pointsUnder[bet.losingTeam] = 0;

        winResult = RoundResult(-1 * underPoints, underPoints + abovePoints);
        loseResult = RoundResult(
          (-1 * score.pointsUnder[bet.losingTeam]),
          score.pointsUnder[bet.losingTeam],
        );
      } else {
        score.pointsAbove[bet.winningTeam] += abovePoints;
        score.pointsUnder[bet.winningTeam] += underPoints;

        winResult = RoundResult(underPoints, abovePoints);
        loseResult = RoundResult(0, 0);
      }
    }

    scores.add(score);
    results[bet.winningTeam].add(winResult);
    results[bet.losingTeam].add(loseResult);

    return gameOver;
  }

  int calculateUndertricks(
      int underTricks, Multiplier multiplier, bool vulnerable) {
    var total = 0;
    switch (multiplier) {
      case Multiplier.none:
        total += underTricks * (vulnerable ? 100 : 50);
        break;
      case Multiplier.double:
        total += vulnerable ? 200 : 100;
        underTricks--;
        while (underTricks > 0) {
          if (!vulnerable && underTricks < 2) {
            total += 200;
          } else {
            total += 300;
          }
          underTricks--;
        }
        break;
      case Multiplier.redouble:
        total += vulnerable ? 400 : 200;
        underTricks--;
        while (underTricks > 0) {
          if (!vulnerable && underTricks < 2) {
            total += 400;
          } else {
            total += 600;
          }
          underTricks--;
        }
        break;
    }

    return total;
  }

  int calculateUnderpoints(int rounds, Naipe naipe, Multiplier multiplier) {
    int trick;
    int total = 0;

    switch (naipe) {
      case Naipe.semNaipe:
      case Naipe.espada:
      case Naipe.copas:
        trick = 30;
        break;
      case Naipe.ouros:
      case Naipe.paus:
        trick = 20;
        break;
    }

    int semNaipeAdd = 10;
    switch (multiplier) {
      case Multiplier.none:
        break;
      case Multiplier.double:
        trick *= 2;
        semNaipeAdd *= 2;
        break;
      case Multiplier.redouble:
        trick *= 4;
        semNaipeAdd *= 4;
        break;
    }

    total += rounds * trick;
    total += naipe == Naipe.semNaipe ? semNaipeAdd : 0;

    return total;
  }

  int calculateOvertricks(
    int rounds,
    Naipe naipe,
    Multiplier multiplier,
    bool vulnerable,
    int slam,
  ) {
    int trick;
    int total = 0;
    if (multiplier == Multiplier.none) {
      switch (naipe) {
        case Naipe.semNaipe:
        case Naipe.espada:
        case Naipe.copas:
          trick = 30;
          break;
        case Naipe.ouros:
        case Naipe.paus:
          trick = 20;
          break;
      }
    } else {
      if (multiplier == Multiplier.double) {
        trick = vulnerable ? 200 : 100;
        total += 50;
      } else {
        trick = vulnerable ? 400 : 200;
        total += 100;
      }
    }

    total += rounds * trick;

    var slamPoints = [0, 500, 750];
    var vulPoints = [0, 1000, 1500];

    total += vulnerable ? vulPoints[slam] : slamPoints[slam];

    return total;
  }
}
