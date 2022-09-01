import 'dart:math';

import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/helper/preference_helper.dart';
import 'package:bridge_counter/src/model/historic_results.dart';
import 'package:bridge_counter/src/view/common/bridge_drawer.dart';
import 'package:bridge_counter/src/view/home/historic_result_tile.dart';
import 'package:bridge_counter/src/view/pontuacao/pontuacao_page.dart';
import 'package:bridge_counter/utils/ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.team1,
    required this.team2,
  }) : super(key: key);

  final String? team1;
  final String? team2;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Translator translator;

  late String team1;
  late String team2;

  List<HistoricResult> results = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    translator = context.read<Translator>();
    team1 = widget.team1 ?? '';
    team2 = widget.team2 ?? '';

    results = getResults();
  }

  List<HistoricResult> getResults() {
    results = PreferenceHelper.instance.getPastResults();

    setState(() => isLoading = false);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BridgeDrawer(translator),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translator.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Text(
              translator.previousResults,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, i) {
                      return HistoricResultTile(
                        result: results[i],
                        locale: translator.locale.languageCode,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => newGameDialog(context),
          tooltip: translator.newGame,
          child: Icon(MdiIcons.cards),
        ),
      ),
    );
  }

  void newGameDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: team1,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: translator.team1,
                ),
                onChanged: (value) => team1 = value,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: team2,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: translator.team2,
                ),
                onChanged: (value) => team2 = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translator.cancel),
            ),
            TextButton(
              onPressed:
                  checkTeamsInput() ? null : () => startGame(team1, team2),
              child: Text(translator.newGame),
            ),
          ],
        );
      },
    );
  }

  bool checkTeamsInput() {
    return team1.isNotEmpty && team2.isNotEmpty && team1.compareTo(team2) == 0;
  }

  void startGame(String team1, String team2) {
    if (!kIsWeb) Ads.instance.showInterstitialAd();
    PreferenceHelper().saveTeams(team1, team2);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PontuacaoPage(team1: team1, team2: team2),
      ),
    );
  }
}
