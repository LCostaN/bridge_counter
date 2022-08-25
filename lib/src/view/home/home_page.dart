import 'dart:math';

import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/view/common/bridge_drawer.dart';
import 'package:bridge_counter/src/view/pontuacao/pontuacao_page.dart';
import 'package:bridge_counter/utils/ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Translator translator;

  String team1 = '';
  String team2 = '';

  @override
  void initState() {
    super.initState();
    translator = context.read<Translator>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BridgeDrawer(translator),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bridge Counter",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: Text(translator.newGame),
              onPressed: () => _newGame(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Text(
              "Resoultados anteriores: ",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                var score1 = Random().nextInt(2) + 1;
                var score2 = Random().nextInt(2) + 1;

                while (score1 == score2) {
                  score1 = Random().nextInt(2) + 1;
                  score2 = Random().nextInt(2) + 1;
                }

                return HistoricResultTile(
                  team1: "Samambaia",
                  team2: "Palmeira",
                  score1: score1,
                  score2: score2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _newGame(BuildContext context) async {
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
                  labelText: translator.team1,
                ),
                onChanged: (value) => team1 = value,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: team2,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
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
              onPressed: team1.isNotEmpty &&
                      team2.isNotEmpty &&
                      team1.compareTo(team2) == 0
                  ? null
                  : () => startGame(team1, team2),
              child: Text(translator.newGame),
            ),
          ],
        );
      },
    );
  }

  void startGame(String team1, String team2) {
    if (!kIsWeb) Ads.instance.showInterstitialAd();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PontuacaoPage(team1: team1, team2: team2),
      ),
    );
  }
}

class HistoricResultTile extends StatelessWidget {
  const HistoricResultTile({
    Key? key,
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
  }) : super(key: key);

  final String team1;
  final String team2;

  final int score1;
  final int score2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            child: score1 > score2 ? Icon(Icons.check) : Container(),
          ),
          Text("$team1  $score1  x  $score2  $team2"),
          SizedBox(
            width: 48,
            child: score2 > score1 ? Icon(Icons.check) : Container(),
          ),
        ],
      ),
    );
  }
}
