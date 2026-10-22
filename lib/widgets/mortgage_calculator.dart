// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Adding the new model
import 'package:cecs453_lab04/classes/MortgageModel.dart';

// This class is going to be placed into edit_screen, helps divide the logic
class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  // Defining our text controllers for later
  final TextEditingController _principalController = TextEditingController();

  void _onButtonPressed(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: This might be useless
    MortgageModel model = Provider.of<MortgageModel>(context, listen: true);

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
            RadioGroup( //groupValue: _interestTerm,
              groupValue: model.loanTerm,
              onChanged: (int? value) {
                if (value == null) return;
                setState(() {
                  model.loanTerm = value;
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
              initialValue: model.interestRate,
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
                  model.interestRate = value!;
                });
              },
            ),
            // Calculate Button
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
