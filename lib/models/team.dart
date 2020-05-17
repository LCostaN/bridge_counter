import 'package:bridge_counter/models/score.dart';

class Team {
  String name;
  List<Score> scores = [];
  int currentUnder = 0;
  int currentAbove = 0;
  int gamesWon = 0;

  List<int> get underHistory {
    return scores
        .where((score) => score.under != 0)
        .map((e) => e.under)
        .toList();
  }

  List<int> get under2History {
    return scores
        .where((score) => score.under2 != 0)
        .map((e) => e.under2)
        .toList();
  }

  List<int> get aboveHistory {
    return scores
        .where((score) => score.bonus != 0)
        .map((e) => e.bonus)
        .toList();
  }

  int get underTotal {
    var _total = 0;

    scores.forEach((score) => _total += score.under);
    return _total;
  }

  int get under2Total {
    var _total = 0;

    scores.forEach((score) => _total += score.under2);
    return _total;
  }

  int get aboveTotal {
    var _total = 0;

    scores.forEach((score) => _total += score.bonus);
    return _total;
  }

  int get total {
    int _total = 0;
    scores
        .forEach((score) => _total += score.bonus + score.under + score.under2);

    return _total;
  }

  Team(this.name);

  void addPoints(Score points, [bool opponentVul = false]) {
    scores.add(points);
    currentAbove += points.bonus;
    currentUnder += points.under + points.under2;

    if (currentUnder >= 100) {
      gamesWon += 1;
      currentUnder = 0;

      if (gamesWon > 1) {
        addPoints(Score(0, 0, opponentVul ? 500 : 700));
      }
    }
  }

  void undo() {
    if (gamesWon > 1) {
      gamesWon -= 1;
      undo();
    }

    scores.removeLast();

    currentUnder = gamesWon == 0 ? underTotal : under2Total;
    currentAbove = aboveTotal;
  }
}
