// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';

class MortgageResult {
  final int years;
  final double principalAmount;
  final double interestRate;
  final String monthlyPayment;
  final String totalPayment;

  MortgageResult({
    required this.principalAmount,
    required this.years,
    required this.interestRate,
    required this.monthlyPayment,
    required this.totalPayment,
  });
}

// This class is going to be placed into edit_screen, helps divide the logic
class MortgageCalculator extends StatefulWidget{
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator>{
  // Defining our text controllers for later
  final TextEditingController _principalController = TextEditingController();

  // Double to hold selected rate
  double _interestRate = 2.0;

  // Defining State variables for radio buttons and checkboxes
  int _interestTerm = 0;
  bool _conditionsAccepted = false;

  void _calculateMortgage() {
    // Simple interest formula is just I = Prt
    int _tempTerm = _interestTerm;
    double _tempPrincipal = _principalController.text as double;
    double _tempRate = _interestRate;
    // TODO: implement calculation logic
    double _totalInterest = _tempPrincipal * _tempTerm * _tempRate;

    // Now for monthly

    setState(() {
      // TODO: Update _result here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Probably redundant with edit screen, will fix later
      appBar: AppBar(title: Text("Britney and Christo\'s Mortgage Calculator")),

      body: Column(
        children: [
          // Text Fields
          TextField(controller: _principalController, decoration: InputDecoration(labelText: "Home Price")),

          // Radio Buttons
          // Looks like RadioListTile has been deprecated, Using RadioGroup Instead
          // Also, setstate needs to handle null like in C#
          RadioGroup(
            groupValue: _interestTerm,
            onChanged: (int? value) {
              if (value == null) return;
              setState(() {
                _interestTerm = value;
              });
            },
            child: Column(
              children: [
                RadioListTile(
                  title: const Text('10'),
                  value: 10,
                ),
                RadioListTile(
                  title: const Text('15'),
                  value: 15,
                ),
                RadioListTile(
                  title: const Text('30'),
                  value: 30,
                ),
              ]
            )
          ),

          DropdownButtonFormField<double>(
            initialValue: _interestRate,
            decoration: const InputDecoration(
              labelText: 'Interest Rate',
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              53,
                  (index) {
                final rate = 2.0 + (index * 0.25);

                return DropdownMenuItem<double>(
                  value: rate,
                  child: Text('${rate.toStringAsFixed(2)}%'),
                );
              },
            ),
            onChanged: (value) {
              setState(() {
                _interestRate = value!;
              });
            },
          ),
          // Calculate Button
          ElevatedButton(
            onPressed: _calculateMortgage,
            child: const Text('Calculate'),
          ),
        ],
      )
    );
  }
}