import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translator extends ChangeNotifier {
  Locale _locale;
  ObservableMap<String, Map<String, String>> localizedStrings = ObservableMap();

  Locale get locale => _locale;

  set locale(Locale val) {
    _locale = val;

    load();

    _save();
  }

  String get settings => localizedStrings[_locale.languageCode]['settings'];
  String get title => localizedStrings[_locale.languageCode]['title'];
  String get currentBet => localizedStrings[_locale.languageCode]['currentBet'];
  String get playAgain => localizedStrings[_locale.languageCode]['playAgain'];
  String get newGame => localizedStrings[_locale.languageCode]['newGame'];
  String get calculate => localizedStrings[_locale.languageCode]['calculate'];
  String get bet => localizedStrings[_locale.languageCode]['bet'];
  String get undo => localizedStrings[_locale.languageCode]['undo'];
  String get redo => localizedStrings[_locale.languageCode]['redo'];
  String get double => localizedStrings[_locale.languageCode]['double'];
  String get redouble => localizedStrings[_locale.languageCode]['redouble'];
  String get team1 => localizedStrings[_locale.languageCode]['team1'];
  String get team2 => localizedStrings[_locale.languageCode]['team2'];
  String get cancel => localizedStrings[_locale.languageCode]['cancel'];
  String get language => localizedStrings[_locale.languageCode]['language'];
  String get trickNumber =>
      localizedStrings[_locale.languageCode]['trickNumber'];
  String get suit => localizedStrings[_locale.languageCode]['suit'];
  String get team => localizedStrings[_locale.languageCode]['team'];
  String get multiplier => localizedStrings[_locale.languageCode]['multiplier'];
  String get howToPlay => localizedStrings[_locale.languageCode]['howToPlay'];
  String get credits => localizedStrings[_locale.languageCode]['credits'];
  String get noTrickSelected =>
      localizedStrings[_locale.languageCode]['noTrickSelected'];
  String get noSuitSelected =>
      localizedStrings[_locale.languageCode]['noSuitSelected'];

  String teamWin(String winningTeam, int score1, int score2) {
    switch (locale.languageCode) {
      case 'en':
        return "Team $winningTeam Won!\n\n"
            "Final Score:\n"
            "Team 1  $score1  x  $score2  Team 2\n\n"
            "Play again?";
      case 'pt':
        return "Time $winningTeam Venceu!\n\n"
            "Placar final:\n"
            "Time 1  $score1  x  $score2  Time2\n\n"
            "Jogar novamente?";
      default:
        return "Team $winningTeam Won!\n\n"
            "Final Score:\n"
            "Team 1  $score1  x  $score2  Team 2\n\n"
            "Play again?";
    }
  }

  String teamWinRound(int team, int score1, int score2) {
    switch (locale.languageCode) {
      case 'en':
        return 'Team $team won a round!\n'
            'Current score: '
            '$score1 - '
            '$score2';
      case 'pt':
        return 'Time $team venceu uma rodada!\nPlacar atual: '
            '$score1 - '
            '$score2';
      default:
        return 'Team $team won a round!\nCurrent score: '
            '$score1 - '
            '$score2';
    }
  }

  Translator() {
    initialize();
  }

  Future<void> initialize() async {
    var pref = await SharedPreferences.getInstance();
    var lang = pref.getString('language');
    var country = pref.getString('country');
    locale ??= lang != null && country != null
        ? Locale(lang, country)
        : Locale('en', 'US');

    await load();
  }

  Future<bool> load() async {
    try {
      if (localizedStrings.containsKey(_locale.languageCode))
        return true;
      else {
        String jsonString = await rootBundle
            .loadString('assets/translations/${locale.languageCode}.json');
        Map<String, dynamic> jsonMap = json.decode(jsonString);

        var strings = {
          _locale.languageCode: ObservableMap.of(
            jsonMap.map((key, value) {
              return MapEntry(key, value.toString());
            }),
          ),
        };
        localizedStrings.addAll(strings);

        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  void _save() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('language', _locale.languageCode);
    pref.setString('country', _locale.countryCode);

    notifyListeners();
  }
}
