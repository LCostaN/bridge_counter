import 'dart:async';

import 'package:bridge_counter/point_screen.dart';
import 'package:flutter/material.dart';

void main() => runZoned(
      () async {
        runApp(MyApp());
      },
      onError: (e, stack) {
        assert(debugPrint(e, stack));
      },
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bridge Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PointScreen(),
    );
  }
}

bool debugPrint(e, StackTrace stack) {
  print(e);
  print(stack);

  return true;
}
