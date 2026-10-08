class MortgageResult {
  final int years;
  final double principalAmount;
  final double interestRate;
  final double monthlyPayment;
  final double totalPayment;

  MortgageResult({
    required this.principalAmount,
    required this.years,
    required this.interestRate,
    required this.monthlyPayment,
    required this.totalPayment,
  });
}