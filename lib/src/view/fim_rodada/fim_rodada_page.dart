import 'package:flutter/material.dart';
import 'package:bridge_counter/internationalization/translator.dart';
import 'package:provider/provider.dart';

class FimRodadaPage extends StatefulWidget {
  const FimRodadaPage({Key? key}) : super(key: key);

  @override
  _FimRodadaPageState createState() => _FimRodadaPageState();
}

class _FimRodadaPageState extends State<FimRodadaPage> {
  late Translator translator;

  int? currentRounds = 0;

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
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 14,
                      itemBuilder: (context, i) => ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "$i",
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
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text(
            translator.calculate,
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () => finishRound(context),
        ),
      ),
    );
  }

  bool checkNumeroSelecionado() {
    if (currentRounds == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translator.noTrickSelected)),
      );
      return false;
    }

    return true;
  }

  void finishRound(BuildContext context) {
    if (!checkNumeroSelecionado()) return;

    Navigator.of(context).pop(currentRounds!);
  }

  void escolherNumeroDeApostas(int rounds) {
    setState(() => currentRounds = rounds);
  }
}
