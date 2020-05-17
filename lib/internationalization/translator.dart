import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'translator.g.dart';

class Translator = _Translator with _$Translator;

abstract class _Translator with Store {
  @observable
  Locale _locale;
  @observable
  Map<String, String> localizedStrings;

  @computed
  Locale get locale => _locale;
  set locale(Locale val) {
    _locale = val;

    _save();
  }

  @computed
  String get title => localizedStrings['title'];
  @computed
  String get currentBet => localizedStrings['currentBet'];
  @computed
  String get playAgain => localizedStrings['playAgain'];
  @computed
  String get newGame => localizedStrings['newGame'];
  @computed
  String get calculate => localizedStrings['calculate'];
  @computed
  String get bet => localizedStrings['bet'];
  @computed
  String get undo => localizedStrings['undo'];
  @computed
  String get double => localizedStrings['double'];
  @computed
  String get redouble => localizedStrings['redouble'];
  @computed
  String get team1 => localizedStrings['team1'];
  @computed
  String get team2 => localizedStrings['team2'];
  @computed
  String get cancel => localizedStrings['cancel'];

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
        return 'Team $team won a round! Current score: '
            '$score1 - '
            '$score2';
      case 'pt':
        return 'Time $team venceu uma rodada! Placar atual: '
            '$score1 - '
            '$score2';
      default:
        return 'Team $team won a round! Current score: '
            '$score1 - '
            '$score2';
    }
  }

  _Translator() {}

  Future<void> initialize() async {
    var pref = await SharedPreferences.getInstance();
    var lang = pref.getString('language');
    locale ??= lang != null ? Locale(lang) : Locale('en');

    await load();
  }

  @action
  Future<bool> load() async {
    try {
      String jsonString = await rootBundle
          .loadString('assets/translations/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  void _save() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('language', _locale.languageCode);
  }
}
