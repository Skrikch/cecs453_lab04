// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';
import 'widgets/mortgage_calculator.dart';
import 'classes/mortgageResult_class.dart';

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
          '/CalcScreen': (context) => MortgageCalculator(),   // screen that calls for input
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
  bool _isAccepted = false;    // holds value for whether Terms and Conditions accepted or not
  // local variables to hold all needed calculated values
  double principleAmount = 0;
  int years = 0;
  double interestRate = 0.0;
  double monthlyPayment = 0.0;
  double totalPayment = 0.0;


  Future<void> _onButtonPressed()  async {
    final MortgageResult? result = await Navigator.pushNamed<MortgageResult>(context, '/mortgage');

    if (result != null) {
      // Inputting all of the calculated output values into the local variables
      principleAmount = result.principalAmount;
      years = result.years;
      interestRate = result.interestRate;
      monthlyPayment = result.monthlyPayment;
      totalPayment = result.totalPayment;
    }
  }

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

          // Checkbox to ensure Terms & Conditions agreed to prior to being able to click button
          CheckboxListTile(
            title: const Text('Accept Terms & Conditions'),
            checkColor: Colors.white,
            activeColor: Colors.deepPurpleAccent,
            value: _isAccepted,
            onChanged: (bool? value) {
              setState(() {
                _isAccepted = value ?? false;
              });
            }
          ),

          ElevatedButton(
            onPressed: _isAccepted ? _onButtonPressed : null,
            child: Text('Modify Data'),
          ),
        ],
      ),
    );
  }
}