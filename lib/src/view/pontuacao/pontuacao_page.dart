import 'package:bridge_counter/constants/multiplier.dart';
import 'package:bridge_counter/constants/naipe.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/controller/game_controller.dart';
import 'package:bridge_counter/src/model/game_round.dart';
import 'package:bridge_counter/src/view/aposta/aposta_page.dart';
import 'package:bridge_counter/src/view/common/bridge_drawer.dart';
import 'package:bridge_counter/src/view/fim_rodada/fim_rodada_page.dart';
import 'package:bridge_counter/src/view/pontuacao/pontuacao_list.dart';
import 'package:bridge_counter/utils/ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PontuacaoPage extends StatefulWidget {
  const PontuacaoPage({
    Key? key,
    required this.team1,
    required this.team2,
  }) : super(key: key);

  final String team1;
  final String team2;

  @override
  PontuacaoPageState createState() => PontuacaoPageState();
}

class PontuacaoPageState extends State<PontuacaoPage> {
  late GameController controller;
  late Translator translator;

  @override
  void initState() {
    super.initState();
    controller = GameController(widget.team1, widget.team2);
    translator = context.read<Translator>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BridgeDrawer(translator),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.score,
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
              onPressed: () => _reset(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PontuacaoList(
                      team: controller.team1,
                      upperPoints: controller.team1Overpoints,
                      underPoints: controller.team1Underpoints,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PontuacaoList(
                      team: controller.team2,
                      upperPoints: controller.team2Overpoints,
                      underPoints: controller.team2Underpoints,
                    ),
                  ),
                ],
              ),
            ),
            if (controller.newRound != null)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cardIcon(controller.newRound!.bet.naipe),
                    const SizedBox(width: 12),
                    Text(controller.newRound!.bet.rounds.toString()),
                    const SizedBox(width: 12),
                    Text(multiplyText(controller.newRound!.bet.multiplier)),
                    const SizedBox(width: 12),
                    Text(controller.newRound!.bet.bettingTeam),
                  ],
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(controller.newRound == null
            ? translator.bet
            : translator.calculate),
        onPressed: controller.gameEnded ? null : () => controller.newRound == null
            ? goToBetPage(context)
            : contarVazas(context),
      ),
    );
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
      case Naipe.paus:
        return Icon(MdiIcons.cardsClub, color: Colors.black);
      case Naipe.ouros:
        return Icon(MdiIcons.cardsDiamond, color: Colors.red);
      case Naipe.copas:
        return Icon(MdiIcons.cardsHeart, color: Colors.red);
      case Naipe.espada:
        return Icon(MdiIcons.cardsSpade, color: Colors.black);
      case Naipe.semNaipe:
        return Icon(Icons.do_not_disturb_alt, color: Colors.black);
      default:
        return Container();
    }
  }

  String multiplyText(Multiplier value) {
    switch (value) {
      case Multiplier.double:
        return translator.double;
      case Multiplier.redouble:
        return translator.redouble;
      default:
        return '-';
    }
  }

  void goToBetPage(BuildContext context) async {
    GameRound? result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ApostaPage(
        team1: controller.team1,
        team2: controller.team2,
      ),
    ));

    controller.newRound = result;
    setState(() {});
  }

  void contarVazas(BuildContext context) async {
    int? result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FimRodadaPage(),
    ));

    if (result == null) return;
    controller.finishRound(result);

    if (controller.gameEnded) mostrarFimDeJogo();
    setState(() {});
  }

  void mostrarFimDeJogo() {
    String team1 = controller.team1;
    String team2 = controller.team2;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          translator.teamWin(
            team1,
            team2,
            controller.getScore1,
            controller.getScore2,
            controller.grandTotal(team1),
            controller.grandTotal(team2)
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _reset();
            },
            child: Text(translator.playAgain),
          ),
        ],
      ),
    );
  }

  void _reset() async {
    if (!kIsWeb) Ads.instance.showInterstitialAd();
    setState(() => controller = GameController(widget.team1, widget.team2));
  }
}
