// Authors: Christos Georgakopoulos, Britney Ferguson

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    saveData();
    notifyListeners();
  }

  set interestRate(double value) {
    _interestRate = value;
    saveData();
    notifyListeners();
  }

  set loanTerm(int value) {
    _loanTerm = value;
    saveData();
    notifyListeners();
  }


  // Adding a constructor for the class that will load any data stored
  MortgageModel() {
    loadData();
  }

  // Creating a clear method
  void clearValues(){
    this._loanAmount = 0.0;
    this._interestRate = 0.0;
    this._loanTerm = 0;
    this._monthlyPayment = 0.0;
    this._totalPayment = 0.0;
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

  // Implementing methods to save and load data as needed for our SharedPreferences implementation
  Future<void> saveData() async {
    // Because getInstance is asynchronous, we need to make this async too.
    // Only saving user-input data, everything else can be derived from it :)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('loanAmount', _loanAmount);
    await prefs.setDouble('interestRate', _interestRate);
    await prefs.setInt('loanTerm', _loanTerm);
  }

  // Setting up loadData()
  // bool for if there was data to return in the first place
  Future<bool> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    // If the first key exists, then the rest should exist
    // If they don't just set them to their default values
    if (prefs.containsKey('loanAmount')) {
      _loanAmount = prefs.getDouble('loanAmount') ?? 0.0;
      _interestRate = prefs.getDouble('interestRate') ?? 2.0;
      _loanTerm = prefs.getInt('loanTerm') ?? 0;
      notifyListeners();
      return true;
    }
    // If the first key didn't exist, there's no data
    return false;
  }
}