// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';

import 'dart:math'; // For pow

import 'package:cecs453_lab04/classes/mortgageResult_class.dart'; // This is safer because otherwise I have to use positional movement like ../classes lol

// This class is going to be placed into edit_screen, helps divide the logic
class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  // Defining our text controllers for later
  final TextEditingController _principalController = TextEditingController();

  // Double to hold selected rate
  double _interestRate = 2.0;

  // Defining State variables for radio buttons and checkboxes
  int _interestTerm = 0;

  void _calculateMortgage() {
    // Simple interest formula is just I = Prt
    final double principal = double.parse(_principalController.text);
    final int totalMonths = _interestTerm * 12;

    // converts 2.00 to 0.0200
    final double rate = _interestRate / 100;

    final double monthlyRate = rate / 12;

    final double monthlyPayment =
        principal *
        (monthlyRate * pow(1 + monthlyRate, totalMonths)) /
        (pow(1 + monthlyRate, totalMonths) - 1);

    final double totalPayment = monthlyPayment * totalMonths;

    final MortgageResult result = MortgageResult(
      principalAmount: principal,
      years: _interestTerm,
      interestRate: _interestRate,
      monthlyPayment: monthlyPayment,
      totalPayment: totalPayment,
    );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Probably redundant with edit screen, will fix later
      appBar: AppBar(title: Text("Mortgage Calculator")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Text Fields
            TextField(
              controller: _principalController,
              decoration: InputDecoration(labelText: "Home Price"),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10),),
            // Radio Buttons
            // Looks like RadioListTile has been deprecated, Using RadioGroup Instead
            // Also, setstate needs to handle null like in C#
            // Starting with a title for the group
            Text("Loan Term", style: Theme.of(context).textTheme.titleMedium),
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
                  RadioListTile(title: const Text('10'), value: 10),
                  RadioListTile(title: const Text('15'), value: 15),
                  RadioListTile(title: const Text('30'), value: 30),
                ],
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10),),

            DropdownButtonFormField<double>(
              initialValue: _interestRate,
              decoration: const InputDecoration(
                labelText: 'Interest Rate',
                border: OutlineInputBorder(),
              ),
              items: List.generate(53, (index) {
                final rate = 2.0 + (index * 0.25);

                return DropdownMenuItem<double>(
                  value: rate,
                  child: Text('${rate.toStringAsFixed(2)}%'),
                );
              }),
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
        ),
      ),
    );
  }
}
