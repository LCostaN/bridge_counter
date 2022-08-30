import 'dart:convert';

import 'package:bridge_counter/src/model/historic_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static PreferenceHelper _instance = PreferenceHelper._();
  static PreferenceHelper get instance => _instance;

  PreferenceHelper._() {
    init();
  }

  factory PreferenceHelper() => instance;

  SharedPreferences? _pref;

  Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  Future<void> saveTeams(String team1, String team2) async {
    _pref!.setString('team1', team1);
    _pref!.setString('team2', team2);
  }

  Future<List<String>> getTeams() async {
    var result = <String>['', ''];

    if (_pref!.containsKey('team1')) {
      result[0] = _pref!.getString('team1') ?? "";
      result[1] = _pref!.getString('team2') ?? "";
    }

    return result;
  }

  List<HistoricResult> getPastResults() {
    var stringList = _pref!.getStringList('previousResults') ?? [];
    var result = <HistoricResult>[];

    stringList.forEach((pastString) {
      var json = jsonDecode(pastString);
      result.add(HistoricResult.fromJson(json));
    });

    result.sort((a, b) => a.date.compareTo(b.date));

    return result;
  }

  void addNewResult(HistoricResult result) {
    var list = getPastResults();

    list.insert(0, result);
    if(list.length > 30) list.removeLast();

    var stringList = list.map((e) => e.toString()).toList();
    _pref!.setStringList('previousResults', stringList);
  }
}
