// Authors: Christos Georgakopoulos, Britney Ferguson
import 'package:flutter/material.dart';

// This class is going to be placed into edit_screen, helps divide the logic
class MortgageCalculator extends StatefulWidget{
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator>{
  // Defining our text controllers for later
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // Defining State variables for radio buttons and checkboxes
  String _interestType = 'Fixed';
  bool _includeTax = false;

  // Storing result
  String _result = "0.00";

  void _calculateMortgage() {
    // TODO: implement calculation logic
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
          TextField(controller: _priceController, decoration: InputDecoration(labelText: "Home Price")),
          TextField()
        ],
      ),
    );
  }
}