import 'package:bridge_counter/point_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
