// Authors: Christos Georgakopoulos, Britney Ferguson

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cecs453_lab04/classes/mortgageResult_class.dart';

class MortgageModel extends ChangeNotifier {
  double _loanAmount = 0.0;
  double _interestRate = 2.0;
  int _loanTerm = 0;

  // Property Getters
  double get loanAmount => _loanAmount;
  double get interestRate => _interestRate;
  int get loanTerm => _loanTerm;

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
  MortgageResult? CalculateMortgage() {
    // Simple interest formula is just I = Prt
    //final double principal = double.parse(_principalController.text);
    final double principal = _loanAmount;
    final int totalMonths = _loanTerm * 12;

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
      years: _loanTerm,
      interestRate: _interestRate,
      monthlyPayment: monthlyPayment,
      totalPayment: totalPayment,
    );
    return result;
  }
}