import 'package:bridge_counter/src/model/game_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  Future<void> saveTeams(String team1, String team2) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('team1', team1);
    pref.setString('team2', team2);
  }

  Future<List<String>> getTeams() async {
    var result = <String>['',''];
    var pref = await SharedPreferences.getInstance();
    
    if(pref.containsKey('team1')) {
      result[0] = pref.getString('team1') ?? "";
      result[1] = pref.getString('team2') ?? "";
    }

    return result;
  }

  List getPastResults() {return [];}
  void addNewResult(GameState state) {}
}