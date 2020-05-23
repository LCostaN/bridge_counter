import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/ui/bridge_drawer.dart';
import 'package:bridge_counter/ui/calc_screen.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/models/game.dart';
import 'package:bridge_counter/models/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Translator>(
      builder: (context, translator, _) => Observer(
        builder: (context) => Scaffold(
          drawer: BridgeDrawer(translator),
          appBar: AppBar(
            centerTitle: game != null,
            title: Text(
              game == null
                  ? translator.title
                  : '${game.teams[0].gamesWon} - '
                      '${game.teams[1].gamesWon}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              FlatButton(
                textColor: Colors.white,
                child: Text(
                  translator.newGame,
                ),
                onPressed: () => _newGame(translator),
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
                                    game.teams[0].name,
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
                                    itemCount:
                                        game.teams[0].aboveHistory.length,
                                    itemBuilder: (context, i) => Container(
                                      padding: const EdgeInsets.all(4.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                          '${game.teams[0].aboveHistory[i]}'),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                  indent: 8.0,
                                  endIndent: 8.0,
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minHeight: 50),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount:
                                        game.teams[0].underHistory.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                            '${game.teams[0].underHistory[i]}'),
                                      );
                                    },
                                  ),
                                ),
                                game.teams[0].gamesWon == 0
                                    ? Container()
                                    : Divider(
                                        thickness: 2,
                                        color: Colors.black,
                                        indent: 8.0,
                                        endIndent: 8.0,
                                      ),
                                game.teams[0].gamesWon == 0
                                    ? Container()
                                    : ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(minHeight: 50),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(16.0),
                                          itemCount: game
                                              .teams[0].under2History.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                  '${game.teams[0].under2History[i]}'),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
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
                                    game.teams[1].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: 50),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount:
                                        game.teams[1].aboveHistory.length,
                                    itemBuilder: (context, i) => Container(
                                      padding: const EdgeInsets.all(4.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                          '${game.teams[1].aboveHistory[i]}'),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                  indent: 8.0,
                                  endIndent: 8.0,
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minHeight: 50),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount:
                                        game.teams[1].underHistory.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                            '${game.teams[1].underHistory[i]}'),
                                      );
                                    },
                                  ),
                                ),
                                game.teams[1].gamesWon == 0
                                    ? Container()
                                    : Divider(
                                        thickness: 2,
                                        color: Colors.black,
                                        indent: 8.0,
                                        endIndent: 8.0,
                                      ),
                                game.teams[1].gamesWon == 0
                                    ? Container()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(16.0),
                                        itemCount:
                                            game.teams[1].under2History.length,
                                        itemBuilder: (context, i) {
                                          return Container(
                                            padding: const EdgeInsets.all(4.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${game.teams[1].under2History[i]}'),
                                          );
                                        },
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
                                  height: 36,
                                  width: double.maxFinite,
                                  child: FittedBox(
                                    child: Text(
                                      'Time ' +
                                          game
                                              .teams[
                                                  game.currentBet.bettingTeam]
                                              .name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${game.teams[0].total}  x  "
                          "${game.teams[1].total}",
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
          bottomNavigationBar: game == null || game.gameover == true
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
          floatingActionButton: game == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    game.undoneBets.length > 0
                        ? FloatingActionButton(
                            backgroundColor: Colors.green,
                            heroTag: 'redo',
                            onPressed: _redo,
                            tooltip: translator.redo,
                            child: Icon(MdiIcons.redoVariant),
                          )
                        : Container(width: 8),
                    const SizedBox(height: 12.0),
                    game.bets.length > 0
                        ? FloatingActionButton(
                            heroTag: 'undo',
                            onPressed: _undo,
                            tooltip: translator.undo,
                            child: Icon(MdiIcons.undoVariant),
                          )
                        : Container(width: 8),
                  ],
                ),
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
    int before;
    bool gameOver;

    if (game.currentBet != null) {
      team = game.currentBet.bettingTeam;
      before = game.teams[team].gamesWon;
    }

    gameOver = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CalcScreen(game: game),
      ),
    );
    setState(() {});

    if (gameOver ?? false) {
      var score1 = game.teams[0].total;
      var score2 = game.teams[1].total;
      var winner = score1 > score2 ? 0 : 1;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            translator.teamWin(game.teams[winner].name, score1, score2),
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
      if (team != null && game.teams[team].gamesWon == 1 && before == 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(translator.teamWinRound(
                team + 1, game.teams[0].gamesWon, game.teams[1].gamesWon)),
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
    showDialog(
      context: context,
      builder: (context) {
        String name1 = game?.teams?.elementAt(0)?.name ?? "";
        String name2 = game?.teams?.elementAt(1)?.name ?? "";

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
              onPressed: () => _reset(name1, name2),
              child: Text(translator.newGame),
            ),
          ],
        );
      },
    );
  }

  void _reset(String name1, String name2) async {
    setState(() => game = Game(Team(name1), Team(name2)));
    Navigator.of(context).pop();
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CalcScreen(game: game),
      ),
    );
    setState(() {});
  }
}
