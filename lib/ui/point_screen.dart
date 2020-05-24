import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/models/game_n.dart';
import 'package:bridge_counter/ui/bridge_drawer.dart';
import 'package:bridge_counter/ui/calc_screen.dart';
import 'package:bridge_counter/utils/ads.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({
    Key key,
  }) : super(key: key);

  @override
  PointScreenState createState() => PointScreenState();
}

class PointScreenState extends State<PointScreen> {
  Game game;
  bool gameOver;

  @override
  void initState() {
    super.initState();
    gameOver = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Translator>(
      builder: (context, translator, _) => Scaffold(
        drawer: BridgeDrawer(translator),
        appBar: AppBar(
          centerTitle: game != null,
          title: Text(
            game == null ? translator.title : game.scoreBoard,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(translator.newGame),
                onPressed: () => _newGame(translator),
              ),
            ),
          ],
        ),
        body: game == null
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 60,
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: Text(
                                  game.teams[0],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minHeight: 50),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: game.results[0].length,
                                  itemBuilder: (context, i) => game
                                              .results[0][i].above ==
                                          0
                                      ? Container()
                                      : Container(
                                          padding: const EdgeInsets.all(4.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${game.results[0][i].above}',
                                            style: i ==
                                                    game.results[0].length - 1
                                                ? TextStyle(color: Colors.green)
                                                : null,
                                          ),
                                        ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.black,
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(minHeight: 50),
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      '${game.scores.length > 0 ? game.scores.last.pointsUnder[0] : 0}',
                                    ),
                                    Expanded(
                                      child: Text(
                                        game.results[0].length > 0 &&
                                                game.results[0].last.under != 0
                                            ? (game.results[0].last.under > 0
                                                    ? '+ '
                                                    : '') +
                                                '${game.results[0].last.under}'
                                            : '',
                                        style: TextStyle(
                                            color: game.results[0].length > 0 &&
                                                    game.results[0].last.under >
                                                        0
                                                ? Colors.green
                                                : Colors.red),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 60,
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: Text(
                                  game.teams[1],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minHeight: 50),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: game.results[1].length,
                                  itemBuilder: (context, i) => game
                                              .results[1][i].above ==
                                          0
                                      ? Container()
                                      : Container(
                                          padding: const EdgeInsets.all(4.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${game.results[1][i].above}',
                                            style: i ==
                                                    game.results[1].length - 1
                                                ? TextStyle(color: Colors.green)
                                                : null,
                                          ),
                                        ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.black,
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(minHeight: 50),
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      '${game.scores.length > 0 ? game.scores.last.pointsUnder[1] : 0}',
                                    ),
                                    Expanded(
                                      child: Text(
                                        game.results[1].length > 0 &&
                                                game.results[1].last.under != 0
                                            ? (game.results[1].last.under > 0
                                                    ? '+ '
                                                    : '') +
                                                '${game.results[1].last.under}'
                                            : '',
                                        style: TextStyle(
                                            color: game.results[1].length > 0 &&
                                                    game.results[1].last.under >
                                                        0
                                                ? Colors.green
                                                : Colors.red),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  game.currentBet == null
                      ? Container()
                      : Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.green,
                                alignment: Alignment.center,
                                child: Text(
                                  translator.currentBet,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 48,
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${game.currentBet.rounds - 6}   ',
                                        ),
                                        cardIcon(game.currentBet.naipe),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              game.currentBet.multiply == Multiplier.none
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 36,
                                        width: double.maxFinite,
                                        child: FittedBox(
                                          child: Text(
                                            multiplyText(translator,
                                                game.currentBet.multiply),
                                          ),
                                        ),
                                      ),
                                    ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                height: 48,
                                width: double.maxFinite,
                                child: Text(
                                  'Time ${game.teams[game.currentBet.bettingTeam]}',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                  game.bets.length == 0
                      ? Container()
                      : Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              game.totalScore,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  Container(),
                ],
              ),
        bottomNavigationBar: game == null
            ? null
            : RaisedButton(
                padding: const EdgeInsets.all(24.0),
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  game.currentBet == null
                      ? translator.bet
                      : translator.calculate,
                ),
                onPressed: () => contabilizar(translator),
              ),
        floatingActionButton: gameOver
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  game.undoneBets.length > 0
                      ? FloatingActionButton(
                          backgroundColor: Colors.blue,
                          heroTag: 'redo',
                          onPressed: _redo,
                          tooltip: translator.redo,
                          child: Icon(MdiIcons.redoVariant),
                        )
                      : Container(width: 8),
                  const SizedBox(height: 12.0),
                  game.bets.length > 0
                      ? FloatingActionButton(
                          backgroundColor: Colors.blue,
                          heroTag: 'undo',
                          onPressed: _undo,
                          tooltip: translator.undo,
                          child: Icon(MdiIcons.undoVariant),
                        )
                      : Container(width: 8),
                ],
              ),
      ),
    );
  }

  void _undo() {
    game.undo();
    setState(() {});
  }

  void _redo() {
    game.redo();
    setState(() {});
  }

  Widget cardIcon(Naipe naipe) {
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

  String multiplyText(Translator translator, Multiplier value) {
    switch (value) {
      case Multiplier.double:
        return translator.double;
      case Multiplier.redouble:
        return translator.redouble;
      default:
        return '';
    }
  }

  void contabilizar(Translator translator) async {
    int team;
    bool before;

    Ads.instance.hideAd();

    if (game.currentBet != null) {
      team = game.currentBet.bettingTeam;
      before = game.scores.length > 0 ? game.scores.last.winRound[team] : false;
    }

    gameOver = (await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (context) => CalcScreen(game: game)),
    )) ?? false;
    setState(() {});

    if (gameOver ?? false) {
      var score1 = game.scores.last.totalTeam1;
      var score2 = game.scores.last.totalTeam2;
      var winner = score1 > score2 ? 0 : 1;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            translator.teamWin(game.teams[winner], score1, score2),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _newGame(translator);
              },
              child: Text(translator.playAgain),
            ),
          ],
        ),
      );
    } else {
      if (team != null && game.scores.last.winRound[team] != before) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              translator.teamWinRound(
                team + 1,
                game.scores.last.winRound[0] ? 1 : 0,
                game.scores.last.winRound[1] ? 1 : 0,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok'),
              ),
            ],
          ),
        );
      }
      setState(() {});
    }
  }

  void _newGame(Translator translator) async {
    await showDialog(
      context: context,
      builder: (context) {
        String name1 = '';
        String name2 = '';

        if (game != null) {
          name1 = game.teams[0];
          name2 = game.teams[1];
        }

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: name1,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: translator.team1,
                ),
                onChanged: (value) => name1 = value,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: name2,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: translator.team2,
                ),
                onChanged: (value) => name2 = value,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translator.cancel),
            ),
            FlatButton(
              onPressed: name1.isNotEmpty &&
                      name2.isNotEmpty &&
                      name1.compareTo(name2) == 0
                  ? null
                  : () => _reset(name1, name2),
              child: Text(translator.newGame),
            ),
          ],
        );
      },
    );
  }

  void _reset(String name1, String name2) async {
    await Ads.instance.showAd();
    setState(() => game = Game(name1, name2));
    Navigator.of(context).pop();
  }
}
