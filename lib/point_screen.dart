import 'package:bridge_counter/calc_screen.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/models/game.dart';
import 'package:bridge_counter/models/team.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) => _newGame());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: game == null
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(
                '${game.teams[0].gamesWon} - '
                '${game.teams[1].gamesWon}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.green,
                              alignment: Alignment.center,
                              child: Text(
                                game.teams[0].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16.0),
                              itemCount: game.teams[0].aboveHistory.length,
                              itemBuilder: (context, i) => Container(
                                padding: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                child: Text('${game.teams[0].aboveHistory[i]}'),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16.0),
                              itemCount: game.teams[0].underHistory.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: const EdgeInsets.all(4.0),
                                  alignment: Alignment.center,
                                  child:
                                      Text('${game.teams[0].underHistory[i]}'),
                                );
                              },
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
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount:
                                        game.teams[0].under2History.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                            '${game.teams[0].under2History[i]}'),
                                      );
                                    },
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
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.green,
                              alignment: Alignment.center,
                              child: Text(
                                game.teams[1].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16.0),
                              itemCount: game.teams[1].aboveHistory.length,
                              itemBuilder: (context, i) => Container(
                                padding: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                child: Text('${game.teams[1].aboveHistory[i]}'),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16.0),
                              itemCount: game.teams[1].underHistory.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: const EdgeInsets.all(4.0),
                                  alignment: Alignment.center,
                                  child:
                                      Text('${game.teams[1].underHistory[i]}'),
                                );
                              },
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
                                "Aposta Atual",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 48,
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        child: Text(multiplyText(
                                            game.currentBet.multiply)),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                game.gameover
                    ? Card(
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
                      )
                    : Container(),
                Container(),
              ],
            ),
      bottomNavigationBar: game == null || game.gameover == true
          ? null
          : RaisedButton(
              padding: const EdgeInsets.all(24.0),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(game.currentBet == null ? "Apostar" : "Contabilizar"),
              onPressed: contabilizar,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'New Game',
        child: Icon(MdiIcons.restart),
      ),
    );
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

  String multiplyText(Multiplier value) {
    switch (value) {
      case Multiplier.double:
        return 'DOBRADO';
      case Multiplier.redouble:
        return 'RE-DOBRADO';
      default:
        return '';
    }
  }

  void contabilizar() async {
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
            "Time ${game.teams[winner].name} Venceu!\n\n"
            "Placar final:\n"
            "Time 1  $score1  x  $score2  Time2\n\n"
            "Jogar novamente?",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _newGame();
              },
              child: Text("Jogar Novamente"),
            ),
          ],
        ),
      );
    } else {
      if (team != null && game.teams[team].gamesWon == 1 && before == 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              'Time ${team + 1} venceu uma rodada! Placar atual: '
              '${game.teams[0].gamesWon} - '
              '${game.teams[1].gamesWon}',
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

  void _newGame() async {
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
                  labelText: "Time 1",
                ),
                onChanged: (value) => name1 = value,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: name2,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: "Time 2",
                ),
                onChanged: (value) => name2 = value,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () => _reset(name1, name2),
              child: Text('Novo Jogo'),
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
