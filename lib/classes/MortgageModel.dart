// Authors: Christos Georgakopoulos, Britney Ferguson

import 'package:flutter/material.dart';
import 'dart:math';

class MortgageModel extends ChangeNotifier {
  // Fields required for calculation
  double _loanAmount = 0.0;
  double _interestRate = 2.0; // Default is 2%
  int _loanTerm = 0;

  // Combining mortgageResult into this file
  // return fields

  double _monthlyPayment = 0;
  double _totalPayment = 0;

  // Property Getters
  double get loanAmount => _loanAmount;
  double get interestRate => _interestRate;
  int get loanTerm => _loanTerm;

  // Just getters for these, they'll be modified programatically down below
  double get monthlyPayment => _monthlyPayment;
  double get totalPayment => _totalPayment;


  // Setters (each with a notifyListeners())
  set loanAmount(double value) {
    _loanAmount = value;
    notifyListeners();
  }

  set interestRate(double value) {
    _interestRate = value;
    notifyListeners();
  }

  set loanTerm(int value) {
    _loanTerm = value;
    notifyListeners();
  }

  // Calculator method
  void calculateMortgage() {
    // validating values before attempging calculation
    if (_loanAmount <= 0 || _interestRate <= 0 || _loanTerm <= 0) {
      this._monthlyPayment = 0.0;
      this._totalPayment = 0.0;
      notifyListeners();
      return;
    }
    // Convert to decimal and divide by months
    final double monthlyInterestRate = (_interestRate / 100) / 12;

    // Convert to years
    final int totalMonths = _loanTerm * 12;

    // Calculate the numerator and denominator
    final double numerator = monthlyInterestRate * pow(1 + monthlyInterestRate, totalMonths);
    final double denominator = pow(1 + monthlyInterestRate, totalMonths) -1;

    double calculatedMonthly = _loanAmount * (numerator / denominator);

    this._monthlyPayment = double.parse(calculatedMonthly.toStringAsFixed(2));
    this._totalPayment = double.parse((_monthlyPayment * totalMonths).toStringAsFixed(2));

    notifyListeners();
  }
}