import 'dart:async';

import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/ui/point_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runZoned(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        runApp(
          Provider(
            create: (_) => Translator(),
            child: MyApp(),
          ),
        );
      },
      onError: (e, stack) {
        assert(debugPrint(e, stack));
      },
    );

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

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
                      scaffoldBackgroundColor: Colors.grey.shade300,
                    ),
                    home: PointScreen(),
                    navigatorObservers: [
                      FirebaseAnalyticsObserver(analytics: analytics),
                    ],
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
