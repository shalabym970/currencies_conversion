// To parse this JSON data, do
//
//     final currencyRate = currencyRateFromJson(jsonString);

class CurrencyRate {
  String description;
  String code;

  CurrencyRate({
    required this.description,
    required this.code,
  });

  factory CurrencyRate.fromJson(Map<String, dynamic> json) => CurrencyRate(
        description: json["description"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
      };
}
