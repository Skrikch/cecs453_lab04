// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Custom imports
import 'package:cecs453_lab04/widgets/mortgage_calculator.dart';
import 'package:cecs453_lab04/classes/MortgageModel.dart';

// Switching main to async to await SharedPreferences
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MortgageModel(),
      child: const MortgageApp(),
    ),
  );
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

      // The different screens
      routes: {
        // default (screen that shows the information)
        '/': (context) => MainScreen(),
        '/CalcScreen': (context) => MortgageCalculator(),
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
  // Properties
  // holds value for whether Terms and Conditions accepted or not
  bool _isAccepted = false;

  // Function to reset values, bound to the clear button
  // DONE: Adapt this to our new model
  void _clearValues() {
    final model = Provider.of<MortgageModel>(context, listen:false);
    setState(() {_isAccepted = false;});

    model.clearValues;
  }

  Future<void> _onButtonPressed() async {
    await Navigator.pushNamed(context, '/CalcScreen');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Instantiating the model
    final model = Provider.of<MortgageModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Mortgage Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16),
        // Table to neatly format the output of the calculator
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
                      child: Consumer<MortgageModel>(
                        builder: (context, model, child) {
                          return Text('\$${model.loanAmount.toStringAsFixed(2)}');
                      }
                      )
                      // child: Text('\$${principalAmount.toStringAsFixed(2)}'),
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
                      // child: Text('$years'),
                        child: Consumer<MortgageModel>(
                            builder: (context, model, child) {
                              return Text('${model.loanTerm}');
                            }
                        )
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
                      //child: Text('${interestRate.toStringAsFixed(2)}%'),
                        child: Consumer<MortgageModel>(
                            builder: (context, model, child) {
                              return Text('${model.interestRate.toStringAsFixed(2)}%');
                            }
                        )
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
                      //child: Text('\$${monthlyPayment.toStringAsFixed(2)}'),
                        child: Consumer<MortgageModel>(
                            builder: (context, model, child) {
                              return Text('\$${model.monthlyPayment.toStringAsFixed(2)}');
                            }
                        )
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
                      // child: Text('\$${totalPayment.toStringAsFixed(2)}'),
                        child: Consumer<MortgageModel>(
                            builder: (context, model, child) {
                              return Text('\$${model.totalPayment.toStringAsFixed(2)}');
                            }
                        )
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

                // Displaying an alert box to double-check the TOS agreement
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

            // Entrypoint for the calculator, won't work until user has
            // Accepted TOS
            ElevatedButton(
              onPressed: _isAccepted ? _onButtonPressed : null,
              child: Text('Modify Data'),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 20)),

            // Reset button so the user may start over.
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
