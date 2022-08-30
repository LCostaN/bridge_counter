import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/helper/preference_helper.dart';
import 'package:bridge_counter/src/view/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var translator = Translator();

  await initialize(translator);

  var teams = await PreferenceHelper().getTeams();
  var team1 = teams[0];
  var team2 = teams[1];

  runApp(
    ChangeNotifierProvider.value(
      value: translator,
      child: MyApp(team1: team1, team2: team2,),
    ),
  );
}

Future<void> initialize(Translator translator) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting();
  await translator.initialize();

  await PreferenceHelper().init();
}