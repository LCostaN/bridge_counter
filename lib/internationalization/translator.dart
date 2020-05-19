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
  ObservableMap<String, Map<String, String>> localizedStrings = ObservableMap();

  @computed
  Locale get locale => _locale;

  set locale(Locale val) {
    _locale = val;

    load();

    _save();
  }

  @computed
  String get title => localizedStrings[_locale.languageCode]['title'];
  @computed
  String get currentBet => localizedStrings[_locale.languageCode]['currentBet'];
  @computed
  String get playAgain => localizedStrings[_locale.languageCode]['playAgain'];
  @computed
  String get newGame => localizedStrings[_locale.languageCode]['newGame'];
  @computed
  String get calculate => localizedStrings[_locale.languageCode]['calculate'];
  @computed
  String get bet => localizedStrings[_locale.languageCode]['bet'];
  @computed
  String get undo => localizedStrings[_locale.languageCode]['undo'];
  @computed
  String get double => localizedStrings[_locale.languageCode]['double'];
  @computed
  String get redouble => localizedStrings[_locale.languageCode]['redouble'];
  @computed
  String get team1 => localizedStrings[_locale.languageCode]['team1'];
  @computed
  String get team2 => localizedStrings[_locale.languageCode]['team2'];
  @computed
  String get cancel => localizedStrings[_locale.languageCode]['cancel'];
  @computed
  String get language => localizedStrings[_locale.languageCode]['language'];
  @computed
  String get trickNumber =>
      localizedStrings[_locale.languageCode]['trickNumber'];
  @computed
  String get suit => localizedStrings[_locale.languageCode]['suit'];
  @computed
  String get team => localizedStrings[_locale.languageCode]['team'];
  @computed
  String get multiplier => localizedStrings[_locale.languageCode]['multiplier'];

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

  _Translator();

  Future<void> initialize() async {
    var pref = await SharedPreferences.getInstance();
    var lang = pref.getString('language');
    locale ??= lang != null ? Locale(lang) : Locale('en');

    await load();
  }

  @action
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
  }
}
