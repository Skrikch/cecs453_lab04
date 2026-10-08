// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'widgets/mortgage_calculator.dart';

void main() {
  runApp(const MortgageApp());
}

class MortgageApp extends StatefulWidget {
  const MortgageApp({super.key});

  @override
  State<MortgageApp> createState() => _MortgageAppState();
}

// State implementation
class _MortgageAppState extends State<MortgageApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'B + C Mortgage Calculator',
        home: MainScreen(),

        // The different screens
        routes: {
          '/': (context) => MainScreen(),    // default (screen that shows the information)
          '/InputScreen': (context) => InputScreen(),   // screen that calls for input
        },
    );
  }
}

// Screens
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainState();
}

class _MainState extends State<MainScreen> {
  // Variables
  bool isAccepted = false;    // holds value for whether Terms and Conditions accepted or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mortgage Calculator')),
      body: Column(
        children: [
          Text('Amount'),
          Text('Years'),
          Text('Interest Rate'),

          Text('Monthly Payment'),
          Text('Total Payment'),

          CheckboxListTile(
            title: const Text('Accept Terms & Conditions'),
            value: isAccepted,
            onChanged: (bool? value) {
              setState(() {
                isAccepted = value!;
              });
            }
          ),

          TextButton(
            onPressed: null,
            child: Text('Modify Data')
          )
        ],
      ),
    );
  }
}

