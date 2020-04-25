import 'package:bridge_counter/bet.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';

class Game {
  Game(String team1, String team2) {
    names[0] = team1;
    names[1] = team2;
  }

  List<String> names = ["", ""];
  List<int> underPoints = [0, 0];
  List<int> abovePoints = [0, 0];
  List<bool> winOnce = [false, false];

  List<Bet> bets = [];

  Bet _currentBet;

  Bet get currentBet => _currentBet;

  void makeBet(Bet bet) {
    _currentBet = bet;
  }

  bool roundResult(int rounds) {
    rounds += 6;
    var gameOver = false;
    var bet = currentBet;

    bets.add(currentBet);
    _currentBet = null;

    if (rounds < bet.rounds) {
      scoreUndertricks(bet.opponentTeam, bet.rounds - rounds, bet.multiply);
    } else {
      score(bet.bettingTeam, bet.rounds - 6, bet.naipe, bet.multiply);
      scoreOvertricks(
          bet.bettingTeam, rounds - bet.rounds, bet.naipe, bet.multiply);

      if (underPoints[bet.bettingTeam] >= 100) {
        gameOver = endRound(bet.bettingTeam);
      }
    }

    return gameOver;
  }

  bool endRound(int team) {
    var endGame = false;

    if (winOnce[team] == false) {
      winOnce[team] = true;
    } else {
      var opponent = team == 0 ? 1 : 0;
      abovePoints[team] += winOnce[opponent] ? 500 : 700;
      endGame = true;
    }

    return endGame;
  }

  void scoreUndertricks(int scoreTeam, int underTricks, Multiplier multiplier) {
    var opponent = scoreTeam == 1 ? 0 : 1;
    var vul = winOnce[opponent];
    switch (multiplier) {
      case Multiplier.none:
        abovePoints[scoreTeam] += underTricks * (vul ? 100 : 50);
        break;
      case Multiplier.double:
        abovePoints[scoreTeam] += vul ? 200 : 100;
        underTricks--;
        while (underTricks > 0) {
          if (!vul && underTricks < 2) {
            abovePoints[scoreTeam] += 200;
          } else {
            abovePoints[scoreTeam] += 300;
          }
          underTricks--;
        }
        break;
      case Multiplier.redouble:
        abovePoints[scoreTeam] += vul ? 400 : 200;
        underTricks--;
        while (underTricks > 0) {
          if (!vul && underTricks < 2) {
            abovePoints[scoreTeam] += 400;
          } else {
            abovePoints[scoreTeam] += 600;
          }
          underTricks--;
        }
        break;
    }
  }

  void score(int team, int rounds, Naipe naipe, Multiplier multiplier) {
    int trick;
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

    underPoints[team] += rounds * trick;
    underPoints[team] += naipe == Naipe.semNaipe ? semNaipeAdd : 0;
  }

  void scoreOvertricks(
      int team, int rounds, Naipe naipe, Multiplier multiplier) {
    int trick;
    bool vul = winOnce[team];
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
        trick = vul ? 200 : 100;
      } else {
        trick = vul ? 400 : 200;
      }
    }

    abovePoints[team] += rounds * trick;
  }
}