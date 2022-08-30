import 'package:bridge_counter/internationalization/translator.dart';
import 'package:bridge_counter/src/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.team1, required this.team2});

  final String team1;
  final String team2;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: context.watch<Translator>().title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        home: HomePage(team1: team1, team2: team2),
      ),
    );
  }
}