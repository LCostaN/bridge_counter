import 'dart:async';

import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/ui/point_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() => runZoned(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        var translator = Translator();
        await translator.initialize();
        runApp(
          Provider.value(
            value: translator,
            child: MyApp(),
          ),
        );
      },
      onError: (e, stack) {
        assert(debugPrint(e, stack));
      },
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Translator>(
      builder: (context, translator, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: translator.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PointScreen(),
        builder: (context, child) => Observer(builder: (context) => child),
      ),
    );
  }
}

bool debugPrint(e, StackTrace stack) {
  print(e);
  print(stack);

  return true;
}
