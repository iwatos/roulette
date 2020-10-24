import 'package:flutter/material.dart';
import 'package:roulette/ui/top.dart';

void main() {
  runApp(RouletteApp());
}

class RouletteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopPage(title: 'ルーレット'),
    );
  }
}
