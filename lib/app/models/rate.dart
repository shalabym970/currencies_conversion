class Rate {
  String? currencyCode;
  double? exchangeRate;
  DateTime? date;

  Rate({
    this.currencyCode,
    this.exchangeRate,
    this.date,
  });

  Rate.fromJson(Map<String, dynamic> json) {
    currencyCode = json.keys.first;
    exchangeRate =  json.values.first;
    date = DateTime.parse(json['date']);
  }

}

class ExchangeRateResponse {
  Map<String, Map<String, double>>? rates;

  ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    rates = Map<String, Map<String, dynamic>>.from(json['rates'])
        .map((key, value) => MapEntry(key, Map<String, double>.from(value)));
  }
}
