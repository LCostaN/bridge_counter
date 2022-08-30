import 'package:bridge_counter/src/model/bet.dart';

class GameRound {
  Bet bet;
  int underPoints = 0;
  List<int> _overPoints = [];
  List<int> get overPoints => [..._overPoints];

  GameRound(this.bet);

  void addOverPoint(int i) {
    if (i > 0) _overPoints.add(i);
  }

  @override
  String toString() {
    return """
      bet: $bet,
      underPoints: $underPoints,
      overPoints: $overPoints,
    """;
  }
}
