import 'dart:math';

import 'package:bridge_counter/src/model/bet.dart';
import 'package:flutter/material.dart';
import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ApostaPage extends StatefulWidget {
  const ApostaPage({Key key, this.team1, this.team2}) : super(key: key);

  final String team1;
  final String team2;

  @override
  _ApostaPageState createState() => _ApostaPageState();
}

class _ApostaPageState extends State<ApostaPage> {
  int currentRounds;
  int currentNaipe;
  int currentTeam;
  int currentDouble;

  Translator translator;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
          shrinkWrap: true,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(6.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translator.trickNumber,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 100).ceil(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 7,
                      itemBuilder: (context, i) => RaisedButton(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "${i + 1}",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: currentRounds == i
                            ? null
                            : () => escolherNumeroDeApostas(i),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(6.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translator.suit,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 100).ceil(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, i) => RaisedButton(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: SizedBox.expand(
                          child: FittedBox(child: cardIcon(i)),
                        ),
                        onPressed: currentNaipe == i
                            ? null
                            : () => setState(() => currentNaipe = i),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(6.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translator.team,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Text(
                                widget.team1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: currentTeam == 0
                                  ? null
                                  : () => setState(
                                        () => currentTeam = 0,
                                      ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: RaisedButton(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Text(
                                widget.team2,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: currentTeam == 1
                                  ? null
                                  : () => setState(
                                        () => currentTeam = 1,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(6.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translator.multiplier,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 100).ceil(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, i) => RaisedButton(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "${pow(2, i)}x",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: currentDouble == i
                            ? null
                            : () => setState(() => currentDouble = i),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => RaisedButton(
                padding: const EdgeInsets.all(24.0),
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => startRound(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool verificarValoresEscolhidos() {
    if (currentRounds == null) {
      ScaffoldMessenger.maybeOf(context).hideCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context).showSnackBar(
        SnackBar(content: Text(translator.noTrickSelected)),
      );
      return false;
    } else if (currentNaipe == null) {
      ScaffoldMessenger.maybeOf(context).hideCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context).showSnackBar(
        SnackBar(content: Text(translator.noSuitSelected)),
      );
      return false;
    } else if (currentTeam == null) {
      ScaffoldMessenger.maybeOf(context).hideCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context)
          .showSnackBar(SnackBar(content: Text(translator.noTeamSelected)));
      return false;
    }
    currentDouble ??= 0;

    return true;
  }

  void startRound(BuildContext context) {
    if (verificarValoresEscolhidos()) return;

    Bet bet = Bet(
      bettingTeam: currentTeam,
      rounds: currentRounds + 1,
      naipe: Naipe.values[currentNaipe],
      multiplier: Multiplier.values[currentDouble],
    );
    setState(() {});
    Navigator.of(context).pop(bet);
  }

  void escolherNumeroDeApostas(int rounds) {
    setState(() => currentRounds = rounds);
  }

  Widget cardIcon(int i) {
    var naipe = Naipe.values[i];
    switch (naipe) {
      case Naipe.paus:
        return Icon(MdiIcons.cardsClub);
      case Naipe.ouros:
        return Icon(MdiIcons.cardsDiamond, color: Colors.red);
      case Naipe.copas:
        return Icon(MdiIcons.cardsHeart, color: Colors.red);
      case Naipe.espada:
        return Icon(MdiIcons.cardsSpade);
      case Naipe.semNaipe:
        return Icon(
          Icons.do_not_disturb_alt,
          color: Colors.red,
        );
      default:
        return Container();
    }
  }
}
