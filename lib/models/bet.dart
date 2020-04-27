import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';

class Bet {
  final int bettingTeam;
  final int _rounds;
  final Naipe naipe;
  final Multiplier multiply;
  int result;

  Bet(
      {this.bettingTeam,
      int count,
      this.naipe,
      this.multiply = Multiplier.none})
      : _rounds = count;

  int get opponentTeam => bettingTeam == 0 ? 1 : 0;

  int get rounds => 6 + _rounds;
}