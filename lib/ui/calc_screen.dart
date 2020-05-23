import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bridge_counter/models/bet.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/models/game.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CalcScreen extends StatefulWidget {
  CalcScreen({Key key, this.game}) : super(key: key);

  final Game game;

  @override
  _CalcScreenState createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  int currentRounds;
  int currentNaipe;
  int currentTeam;
  int currentDouble;

  @override
  void initState() {
    super.initState();

    if (widget.game.currentBet == null) {
      currentDouble = 0;
      currentTeam = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Translator>(
      builder: (context, translator, _) => Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: SafeArea(
          child: Observer(
            builder: (context) => ListView(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (MediaQuery.of(context).size.width / 200)
                                    .ceil(),
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: widget.game.currentBet == null ? 7 : 13,
                          itemBuilder: (context, i) => RaisedButton(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              "${i + 1}",
                              style: TextStyle(fontSize: 30),
                            ),
                            onPressed:
                                currentRounds == i ? null : () => round(i),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.game.currentBet != null
                    ? Container()
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width / 200)
                                          .ceil(),
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
                widget.game.currentBet != null
                    ? Container()
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
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
                                height: 120,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: RaisedButton(
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Text(
                                          widget.game.teams[0].name,
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
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Text(
                                          widget.game.teams[1].name,
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
                widget.game.currentBet != null
                    ? Container()
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width / 200)
                                          .ceil(),
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
                                    style: TextStyle(fontSize: 30),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.game.currentBet != null
            ? null
            : Builder(
                builder: (context) => RaisedButton(
                  padding: const EdgeInsets.all(24.0),
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text(
                    "Start",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => startRound(context, translator),
                ),
              ),
      ),
    );
  }

  void startRound(BuildContext context, Translator translator) {
    if (currentRounds == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(translator.noTrickSelected)),
      );
      return;
    } else if (currentNaipe == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(translator.noSuitSelected)),
      );
      return;
    } else if (currentTeam == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Por favor selecione o time que ganhou a aposta.")));
      return;
    } else if (currentDouble == null) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
          content:
              Text("Por favor selecione a situação (dobrado/redobrado).")));
      return;
    } else {
      setState(() {
        widget.game.makeBet(
          Bet(
            bettingTeam: currentTeam,
            count: currentRounds + 1,
            naipe: Naipe.values[currentNaipe],
            multiply: Multiplier.values[currentDouble],
          ),
        );
      });
      Navigator.of(context).pop();
    }
  }

  void round(int rounds) {
    if (widget.game.currentBet == null) {
      setState(() => currentRounds = rounds);
    } else {
      var gameOver = widget.game.roundResult(rounds + 1);

      Navigator.of(context).pop(gameOver);
    }
  }

  Widget cardIcon(int i) {
    var naipe = Naipe.values[i];
    switch (naipe) {
      case Naipe.semNaipe:
        return Icon(
          Icons.do_not_disturb_alt,
          color: Colors.red,
        );
      case Naipe.espada:
        return Icon(MdiIcons.cardsSpade);
      case Naipe.copas:
        return Icon(MdiIcons.cardsHeart, color: Colors.red);
      case Naipe.ouros:
        return Icon(MdiIcons.cardsDiamond, color: Colors.red);
      case Naipe.paus:
        return Icon(MdiIcons.cardsClub);
      default:
        return Container();
    }
  }
}
