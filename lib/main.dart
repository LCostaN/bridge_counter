import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/helper/preference_helper.dart';
import 'package:bridge_counter/src/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  var translator = Translator();
  await translator.initialize();

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

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.team1, required this.team2});

  final String team1;
  final String team2;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: context.watch<Translator>().title,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade600,
          ),
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        home: HomePage(team1: team1, team2: team2),
      ),
    );
  }
}
