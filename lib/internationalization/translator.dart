import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translator extends ChangeNotifier {
  Locale? _locale;
  Map<String, Map<String, String>> localizedStrings = Map();

  Locale get locale => _locale!;

  set locale(Locale val) {
    _locale = val;

    load();

    _save();
  }

  String get home => localizedStrings[locale.languageCode]!['home']!;
  String get settings => localizedStrings[locale.languageCode]!['settings']!;
  String get title => localizedStrings[locale.languageCode]!['title']!;
  String get currentBet =>
      localizedStrings[locale.languageCode]!['currentBet']!;
  String get playAgain => localizedStrings[locale.languageCode]!['playAgain']!;
  String get newGame => localizedStrings[locale.languageCode]!['newGame']!;
  String get calculate => localizedStrings[locale.languageCode]!['calculate']!;
  String get bet => localizedStrings[locale.languageCode]!['bet']!;
  String get undo => localizedStrings[locale.languageCode]!['undo']!;
  String get redo => localizedStrings[locale.languageCode]!['redo']!;
  String get double => localizedStrings[locale.languageCode]!['double']!;
  String get redouble => localizedStrings[locale.languageCode]!['redouble']!;
  String get team1 => localizedStrings[locale.languageCode]!['team1']!;
  String get team2 => localizedStrings[locale.languageCode]!['team2']!;
  String get cancel => localizedStrings[locale.languageCode]!['cancel']!;
  String get language => localizedStrings[locale.languageCode]!['language']!;
  String get trickNumber =>
      localizedStrings[locale.languageCode]!['trickNumber']!;
  String get suit => localizedStrings[locale.languageCode]!['suit']!;
  String get team => localizedStrings[locale.languageCode]!['team']!;
  String get multiplier =>
      localizedStrings[locale.languageCode]!['multiplier']!;
  String get howToPlay => localizedStrings[locale.languageCode]!['howToPlay']!;
  String get credits => localizedStrings[locale.languageCode]!['credits']!;
  String get noTrickSelected =>
      localizedStrings[locale.languageCode]!['noTrickSelected']!;
  String get noSuitSelected =>
      localizedStrings[locale.languageCode]!['noSuitSelected']!;
  String get noTeamSelected =>
      localizedStrings[locale.languageCode]!['noTeamSelected']!;
  String get previousResults =>
      localizedStrings[locale.languageCode]!['previousResults']!;

  String draw(int score1, int score2, int points1, int points2) {
    switch (locale.languageCode) {
      case 'en':
        return "It's a DRAW!\n\n"
            "Final Score:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Points:  $points1  x  $points2\n\n"
            "Play again?";
      case 'pt':
        return "É um EMPATE!\n\n"
            "Placar final:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Pontos  $points1  x  $points2\n\n"
            "Jogar novamente?";
      default:
        return "It's a DRAW!\n\n"
            "Final Score:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Points:  $points1  x  $points2\n\n"
            "Play again?";
    }
  }

  String teamWin(String team1, String team2, int score1, int score2,
      int points1, int points2) {
    if (points1 == points2) {
      return draw(score1, score2, points1, points2);
    }
    String winningTeam = points1 > points2 ? team1 : team2;
    switch (locale.languageCode) {
      case 'en':
        return "Team $winningTeam Won!\n\n"
            "Final Score:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Points:  $points1  x  $points2\n\n"
            "Play again?";
      case 'pt':
        return "Time $winningTeam Venceu!\n\n"
            "Placar final:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Pontos  $points1  x  $points2\n\n"
            "Jogar novamente?";
      default:
        return "Team $winningTeam Won!\n\n"
            "Final Score:\n"
            "$team1  $score1  x  $score2  $team2\n"
            "Points:  $points1  x  $points2\n\n"
            "Play again?";
    }
  }

  Translator() {
    initialize();
  }

  Future<void> initialize() async {
    var pref = await SharedPreferences.getInstance();
    String? lang = pref.getString('language');
    String? country = pref.getString('country');
    _locale ??= lang != null && country != null
        ? Locale(lang, country)
        : Locale('en', 'US');

    await load();
  }

  Future<void> load() async {
    try {
      if (localizedStrings.containsKey(locale.languageCode)) {
        notifyListeners();
        return;
      }

      String jsonString = await rootBundle
          .loadString('assets/translations/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      var strings = {
        locale.languageCode: Map.of(
          jsonMap.map((key, value) {
            return MapEntry(key, value.toString());
          }),
        ),
      };
      localizedStrings.addAll(strings);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void _save() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('language', locale.languageCode);
    if (locale.countryCode != null) {
      pref.setString('country', locale.countryCode!);
    }
  }
}
