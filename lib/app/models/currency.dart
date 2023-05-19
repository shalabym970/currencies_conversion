class Currency {
  final String? code;
  final String? description;

  Currency({ this.code,  this.description});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] as String,
      description: json['description'] as String,
    );
  }
}

