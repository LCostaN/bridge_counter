import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/controller/game_controller.dart';
import 'package:bridge_counter/src/model/game_state.dart';
import 'package:bridge_counter/src/view/bridge_drawer.dart';
import 'package:bridge_counter/src/view/fim_rodada_page.dart';
import 'package:bridge_counter/utils/ads.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PontuacaoPage extends StatefulWidget {
  const PontuacaoPage({
    Key key,
  }) : super(key: key);

  @override
  PontuacaoPageState createState() => PontuacaoPageState();
}

class PontuacaoPageState extends State<PontuacaoPage> {
  GameController controller;
  Translator translator;

  String team1 = '';
  String team2 = '';

  @override
  void initState() {
    super.initState();
    controller = context.read<GameController>();
    translator = context.read<Translator>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameState>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          var game = snapshot.requireData;

          return Scaffold(
              drawer: BridgeDrawer(translator),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  game.roundsScore ?? '',
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
                      onPressed: () => _newGame(context),
                    ),
                  ),
                ],
              ),
              body: Container());
        });
  }

  void _undo() {
    controller.undo();
    setState(() {});
  }

  void _redo() {
    controller.redo();
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

  void contarVazas(BuildContext context) async {
    Ads.instance.hideAd();

    var result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FimRodadaPage(),
    ));

    if (result == null) return;
    await controller.calcularRodada(result);

    if (controller.gameOver)
      mostrarFimDeJogo(
        controller.jogoWinnerTeam,
        game.total1,
        game.total2,
      );

    if (controller.rodadaCompleta)
      mostrarFimDeRodada(
        controller.rodadaWinnerTeam,
        game.score1,
        game.score2,
      );
  }

  void mostrarFimDeJogo(String winnerTeam, score1, score2) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          translator.teamWin(winnerTeam, score1, score2),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              _newGame(context);
            },
            child: Text(translator.playAgain),
          ),
        ],
      ),
    );
  }

  void mostrarFimDeRodada(String winnerTeam, int score1, int score2) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          translator.teamWinRound(
            winnerTeam,
            0,
            0,
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
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translator.cancel),
            ),
            FlatButton(
              onPressed: team1.isNotEmpty &&
                      team2.isNotEmpty &&
                      team1.compareTo(team2) == 0
                  ? null
                  : () => _reset(team1, team2),
              child: Text(translator.newGame),
            ),
          ],
        );
      },
    );
  }

  void _reset(String name1, String name2) async {
    await Ads.instance.showAd();
    setState(() => controller.newGame());
    Navigator.of(context).pop();
  }
}
