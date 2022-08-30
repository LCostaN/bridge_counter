import 'dart:convert';

class HistoricResult {
  final String team1, team2;
  final int points1, points2;
  final DateTime date;

  HistoricResult({
    required this.team1,
    required this.team2,
    required this.points1,
    required this.points2,
    required this.date,
  });

  factory HistoricResult.fromJson(Map<String, dynamic> json) {
    String team1 = json['team1'];
    String team2 = json['team2'];
    int points1 = json['points1'];
    int points2 = json['points2'];
    DateTime date = DateTime.parse(json['date']);

    return HistoricResult(
      team1: team1,
      team2: team2,
      points1: points1,
      points2: points2,
      date: date,
    );
  }

  Map<String, dynamic> toMap() => {
    "team1": team1,
    "team2": team2,
    "points1": points1,
    "points2": points2,
    "date": date.toIso8601String(),
  };

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
