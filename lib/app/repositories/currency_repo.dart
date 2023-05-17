import 'package:getx_mvc_templet/app/models/currency.dart';
import 'package:getx_mvc_templet/app/providers/api_provider.dart';

import '../models/currencies_conversion.dart';

class CurrencyRepo {
  final apiProvider = APIProvider();

  Future<List<CurrencyRate>> getCurrencies() {
    return apiProvider.getCurrencies();
  }

  Future<List<CurrenciesConversion>> getCurrenciesConversion(
      {required DateTime startDate,
      required DateTime endDate,
      required String fromCurrency,
      required String toCurrency}) async {
    return apiProvider.getCurrenciesConversion(
        startDate: startDate,
        endDate: endDate,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency);
  }
}
