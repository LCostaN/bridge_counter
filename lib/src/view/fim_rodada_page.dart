import 'package:flutter/material.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:provider/provider.dart';

class FimRodadaPage extends StatefulWidget {
  const FimRodadaPage({Key key}) : super(key: key);

  @override
  _FimRodadaPageState createState() => _FimRodadaPageState();
}

class _FimRodadaPageState extends State<FimRodadaPage> {
  Translator translator;

  int currentRounds = 0;

  @override
  void initState() {
    super.initState();

    translator = context.read<Translator>();
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

  bool checkNumeroSelecionado() {
    if (currentRounds == null) {
      ScaffoldMessenger.maybeOf(context).hideCurrentSnackBar();
      ScaffoldMessenger.maybeOf(context).showSnackBar(
        SnackBar(content: Text(translator.noTrickSelected)),
      );
      return false;
    }

    return true;
  }

  void startRound(BuildContext context) {
    if (checkNumeroSelecionado()) return;

    Navigator.of(context).pop(currentRounds + 1);
  }

  void escolherNumeroDeApostas(int rounds) {
    setState(() => currentRounds = rounds);
  }
}
