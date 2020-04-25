import 'package:bridge_counter/calc_screen.dart';
import 'package:bridge_counter/enums/multiplier.dart';
import 'package:bridge_counter/enums/naipe.dart';
import 'package:bridge_counter/game.dart';
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
                '${game.winOnce[0] ? 1 : 0} - '
                '${game.winOnce[1] ? 1 : 0}',
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
                                game.names[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: Text('${game.abovePoints[0]}'),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: Text('${game.underPoints[0]}'),
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
                                game.names[1],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: Text('${game.abovePoints[1]}'),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: Text('${game.underPoints[1]}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                game.currentBet == null
                    ? Container()
                    : SizedBox(
                        height: 48,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Aposta Atual: ${game.currentBet.rounds - 6} - ',
                              ),
                              cardIcon(game.currentBet.naipe),
                            ],
                          ),
                        ),
                      ),
                game.currentBet == null
                    ? Container()
                    : SizedBox(
                        height: 48,
                        width: double.maxFinite,
                        child: FittedBox(
                          child: Text(multiplyText(game.currentBet.multiply)),
                        ),
                      ),
                Container(),
              ],
            ),
      bottomNavigationBar: RaisedButton(
        padding: const EdgeInsets.all(24.0),
        color: Colors.green,
        textColor: Colors.white,
        child: Text("Contabilizar"),
        onPressed: contabilizar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'New Game',
        child: Icon(Icons.refresh),
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
    switch(value) {
      case Multiplier.double:
        return 'DOBRADO';
      case Multiplier.redouble:
        return 'RE-DOBRADO';
      default:
        return '';
    }
  }

  void contabilizar() async {
    var team = game.currentBet.bettingTeam;
    var before = game.winOnce[team];

    var gameOver = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CalcScreen(game: game),
      ),
    );

    if (gameOver ?? false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Time ${team + 1} Venceu! Jogar novamente?"),
          actions: <Widget>[
            FlatButton(
              onPressed: _newGame,
              child: Text("Jogar Novamente"),
            ),
          ],
        ),
      );
    } else {
      if (game.winOnce[team] != before) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              'Time ${team + 1} venceu uma rodada! Placar atual: '
              '${game.winOnce[0] ? 1 : 0} - '
              '${game.winOnce[1] ? 1 : 0}',
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
    }
  }

  void _newGame() async {
    showDialog(
      context: context,
      builder: (context) {
        String name1 = game?.names?.elementAt(0) ?? "";
        String name2 = game?.names?.elementAt(1) ?? "";

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: name1,
                decoration: InputDecoration(
                  labelText: "Time 1",
                ),
                onChanged: (value) => name1 = value,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: name2,
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
    setState(() => game = Game(name1, name2));
    Navigator.of(context).pop();
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CalcScreen(game: game),
      ),
    );
    setState(() {});
  }
}
