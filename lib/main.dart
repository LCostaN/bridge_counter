import 'dart:async';

import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/controller/game_controller.dart';
import 'package:bridge_counter/src/view/home/home_page.dart';
import 'package:bridge_counter/src/view/pontuacao/pontuacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => Translator(),
              ),
            ],
            child: MyApp(),
          ),
        );
      },
      (e, stack) {
        assert(debugPrint(e, stack));
      },
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Translator>(
      builder: (context, translator, _) => FutureBuilder(
        future: translator.initialize(),
        builder: (context, data) =>
            data.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: translator.title,
                    theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        color: Colors.black,
                      ),
                      primarySwatch: Colors.green,
                      scaffoldBackgroundColor: Colors.grey.shade200,
                    ),
                    home: PontuacaoPage(
                      team1: "Samambaia",
                      team2: "Palmeira",
                    ),
                  ),
      ),
    );
  }
}

bool debugPrint(e, StackTrace stack) {
  print(e);
  print(stack);

  return true;
}
