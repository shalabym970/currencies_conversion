class CurrenciesConversion {
  String? date;
  double? usd;
  double? eur;

  CurrenciesConversion({
    this.date,
    this.usd,
    this.eur,
  });

  factory CurrenciesConversion.fromJson(Map<String, dynamic> json) {
    return CurrenciesConversion(
      date: json['date'],
      usd: json['rates']['USD'],
      eur: json['rates']['EUR'],
    );
  }
}
