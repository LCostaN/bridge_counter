import 'package:bridge_counter/models/bet_n.dart';

class Score {
  final Bet bet;
  List<int> pointsAbove = [0,0];
  List<int> pointsUnder = [0,0];

  List<bool> winRound = [false,false];

  int get totalTeam1 => pointsAbove[0] + pointsUnder[0];
  int get totalTeam2 => pointsAbove[1] + pointsUnder[1];

  Score(this.bet);

  void populatePoints(Score last) {
    pointsUnder = List()..addAll(last.pointsUnder);
    pointsAbove = List()..addAll(last.pointsAbove);
    winRound    = List()..addAll(last.winRound);
  }
}