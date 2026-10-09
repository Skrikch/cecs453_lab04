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
      //home: MainScreen(),

      // The different screens
      routes: {
        '/': (context) => MainScreen(),
        // default (screen that shows the information)
        //'/CalcScreen': (context) => MortgageCalculator(),   // screen that calls for input
      },
      // Need to add special logic to handle the object type we're returning
      onGenerateRoute: (settings) {
        if (settings.name == '/CalcScreen') {
          return MaterialPageRoute<MortgageResult>(
            builder: (context) => MortgageCalculator(),
          );
        }
        return null;
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
  bool _isAccepted =
      false; // holds value for whether Terms and Conditions accepted or not
  // local variables to hold all needed calculated values
  double principalAmount = 0;
  int years = 0;
  double interestRate = 0.0;
  double monthlyPayment = 0.0;
  double totalPayment = 0.0;

  // Function to reset values
  void _clearValues() {
    setState(() {
      _isAccepted = false;
      principalAmount = 0.0;
      years = 0;
      interestRate = 0.0;
      monthlyPayment = 0.0;
      totalPayment = 0.0;
    });
  }

  Future<void> _onButtonPressed() async {
    final MortgageResult? result = await Navigator.pushNamed<MortgageResult>(
      context,
      '/CalcScreen',
    );

    if (result != null) {
      // Inputting all of the calculated output values into the local variables
      principalAmount = result.principalAmount;
      years = result.years;
      interestRate = result.interestRate;
      monthlyPayment = result.monthlyPayment;
      totalPayment = result.totalPayment;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mortgage Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Amount'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('\$${principalAmount.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Years'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('$years'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Interest Rate'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('${interestRate.toStringAsFixed(2)}%'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Monthly Payment'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('\$${monthlyPayment.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Total Payment'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('\$${totalPayment.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              ],
            ),

            // Checkbox to ensure Terms & Conditions agreed to prior to being able to click button
            CheckboxListTile(
              title: const Text('Accept Terms & Conditions'),
              checkColor: Colors.white,
              activeColor: Colors.deepPurpleAccent,
              value: _isAccepted,
              onChanged: (bool? value) async {
                // Only show the dialog when the user tries to check the box.
                if (value != true || _isAccepted) return;

                final bool? accepted = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Terms and Conditions'),
                      content: const Text(
                        'Please accept the terms and conditions before continuing.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, true);
                          },
                          child: const Text('Accept'),
                        ),
                      ],
                    );
                  },
                );
                // Only check the box if the user has accepted the popup.
                if (!mounted || accepted != true) return;
                setState(() {
                  _isAccepted = true;
                });
              },
            ),

            ElevatedButton(
              onPressed: _isAccepted ? _onButtonPressed : null,
              child: Text('Modify Data'),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            OutlinedButton.icon(
              onPressed: _clearValues,
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear All Values'),
            ),
          ],
        ),
      ),
    );
  }
}
