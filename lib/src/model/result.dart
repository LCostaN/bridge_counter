import 'package:flutter/foundation.dart';

@immutable
class Result {
  final int teamScoring;

  final int overtrick;
  final int undertrick;
  final int points;
  final int challenge;

  Result(this.teamScoring, this.overtrick, this.undertrick, this.points, this.challenge);
}
