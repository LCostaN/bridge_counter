import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';

class Bet {
  final int bettingTeam;
  final int _rounds;
  final Naipe naipe;
  final Multiplier multiply;
  final bool vulnerable;
  int result;

  Bet({
    this.bettingTeam,
    int count,
    this.naipe,
    this.multiply = Multiplier.none,
    this.vulnerable,
  }) : _rounds = count;

  int get winningTeam =>
      result != null ? result < rounds ? opponentTeam : bettingTeam : null;
  int get losingTeam => winningTeam != null ? winningTeam == 0 ? 1 : 0 : null;
  int get opponentTeam => bettingTeam == 0 ? 1 : 0;

  int get rounds => 6 + _rounds;
}
