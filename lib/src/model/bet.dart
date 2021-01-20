import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';
import 'package:flutter/foundation.dart';

class Bet {
  final int bettingTeam;
  final int rounds;
  final Naipe naipe;
  final Multiplier multiplier;

  const Bet({
    @required this.bettingTeam,
    @required this.rounds,
    @required this.naipe,
    @required this.multiplier,
  });
}
