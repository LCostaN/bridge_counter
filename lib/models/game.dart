import 'dart:math';

import 'package:bridge_counter/models/bet.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/models/score.dart';
import 'package:bridge_counter/models/team.dart';
import 'package:mobx/mobx.dart';

part 'game.g.dart';

class Game = _Game with _$Game;

abstract class _Game with Store {
  _Game(Team team1, Team team2) {
    teams[0] = team1;
    teams[1] = team2;
  }

  @observable
  ObservableList<Team> teams = ObservableList()..addAll([null, null]);
  @observable
  ObservableList<Bet> bets = ObservableList()..addAll([null, null]);
  @observable
  ObservableList<Bet> undoneBets = ObservableList()..addAll([null, null]);

  @observable
  Bet _currentBet;
  @observable
  bool gameover = false;

  @computed
  Bet get currentBet => _currentBet;
  @computed
  int get rounds => teams[0].gamesWon + teams[1].gamesWon;

  @action
  void makeBet(Bet bet) {
    undoneBets.clear();
    _currentBet = bet;
  }

  @action
  void undo() {
    var lastBet = bets.last;
    var team = lastBet.result >= lastBet.rounds
        ? lastBet.bettingTeam
        : lastBet.opponentTeam;
    teams[team].undo();
    undoneBets.add(bets.last);
  }

  @action
  void redo() {
    var lastBet = undoneBets.removeLast();
    _currentBet = lastBet;
    roundResult(lastBet.result);
  }

  @action
  bool roundResult(int rounds) {
    currentBet.result = rounds;
    var bet = currentBet;

    bets.add(currentBet);
    _currentBet = null;

    var vul = teams[bet.bettingTeam].gamesWon == 1;

    if (rounds < bet.rounds) {
      var points = calculateUndertricks(bet.rounds - rounds, bet.multiply, vul);
      teams[bet.opponentTeam].addPoints(Score(0, 0, points));
    } else {
      var opponentVul = teams[bet.opponentTeam].gamesWon == 1;

      var underPoints = calculateUnderpoints(
        bet.rounds - 6,
        bet.naipe,
        bet.multiply,
      );

      var slam = max(bet.rounds - 11, 0);
      var abovePoints = calculateOvertricks(
        rounds - bet.rounds,
        bet.naipe,
        bet.multiply,
        vul,
        slam,
      );

      var team = teams[bet.bettingTeam];
      var score = team.gamesWon == 0
          ? Score(underPoints, 0, abovePoints)
          : Score(0, underPoints, abovePoints);

      team.addPoints(score, opponentVul);

      if (team.gamesWon > 1) {
        gameover = true;
      }
    }

    return gameover;
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

    if (slam > 0) {
      if (vulnerable) {
        total += slam == 1 ? 500 : 750;
      } else {
        total += slam == 1 ? 1000 : 1500;
      }
    }

    return total;
  }
}
