// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MortgageApp());
}

class MortgageApp extends StatelessWidget {
  const MortgageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'B + C Mortgage Calculator', home: MainScreen());
  }
}

